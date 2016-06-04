package level;


import flixel.FlxBasic;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.editors.tiled.TiledImageLayer;
import flixel.addons.editors.tiled.TiledImageTile;
import flixel.addons.editors.tiled.TiledLayer.TiledLayerType;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.effects.particles.FlxParticle;
import flixel.group.FlxGroup;
import flixel.math.FlxRect;
import flixel.tile.FlxTilemap;
import gameObjects.Barrel;
import gameObjects.enemies.Enemy;
import gameObjects.enemies.HunterEnemy;
import gameObjects.guns.Bullet;
import gameObjects.pickups.HealthPickUp;
import gameObjects.players.Player;
import haxe.io.Path;
import states.PlayState;

/**
 * @author Ignacio Benedetto
 */
class LevelManager extends TiledMap
{
	// For each "Tile Layer" in the map, you must define a "tileset" property which contains the name of a tile sheet image
	// used to draw tiles in that layer (without file extension). The image file must be located in the directory specified bellow.
	private inline static var c_PATH_LEVEL_TILESHEETS = "maps/";

	// Array of tilemaps used for collision
	public var foregroundLayer:FlxGroup; //muros no colisionables
	public var objectsLayer:FlxGroup; //jugadores, enemies, pickups, barrels
	public var floorLayer:FlxGroup;
	public var collidableLayer:FlxTypedGroup<FlxTilemap>;
	public var hudLayer:HUD;

	public var characterGroup:FlxGroup;
	public var enemiesGroup:FlxGroup;
	public var pickupGroup:FlxGroup;
	public var breakableGroup:FlxGroup;

	public var playerBulletGroup:FlxTypedGroup<Bullet>;
	public var enemyBulletGroup:FlxTypedGroup<Bullet>;
	private var particlesGroup:FlxTypedGroup<FlxParticle>;

	private var collidableTileLayers:Array<FlxTilemap>;

	private var bounds:FlxRect;

	public function new(tiledLevel:Dynamic, state:PlayState)
	{
		super(tiledLevel);

		floorLayer = new FlxGroup();
		foregroundLayer = new FlxGroup();
		collidableLayer = new FlxTypedGroup<FlxTilemap>();
		objectsLayer = new FlxGroup();


		breakableGroup = new FlxGroup();
		characterGroup = new FlxGroup();
		enemiesGroup = new FlxGroup();
		pickupGroup = new FlxGroup();

		playerBulletGroup = new FlxTypedGroup<Bullet>();
		enemyBulletGroup = new FlxTypedGroup<Bullet>();
		particlesGroup = new FlxTypedGroup<FlxParticle>();

		bounds = new FlxRect(0, 0, fullWidth, fullHeight);

		FlxG.camera.setScrollBoundsRect(0, 0, fullWidth, fullHeight, true);

		//loadImages();

		// Load Tile Maps
		for (layer in layers)
		{
			if (layer.type != TiledLayerType.TILE) continue;
			var tileLayer:TiledTileLayer = cast layer;

			var tileSheetName:String = tileLayer.properties.get("tileset");

			if (tileSheetName == null)
				throw "'tileset' property not defined for the '" + tileLayer.name + "' layer. Please add the property to the layer.";

			var tileSet:TiledTileSet = null;
			for (ts in tilesets)
			{
				if (ts.name == tileSheetName)
				{
					tileSet = ts;
					break;
				}
			}

			if (tileSet == null)
				throw "Tileset '" + tileSheetName + " not found. Did you misspell the 'tilesheet' property in " + tileLayer.name + "' layer?";

			var imagePath 		= new Path(tileSet.imageSource);
			var processedPath 	= c_PATH_LEVEL_TILESHEETS + imagePath.file + "." + imagePath.ext;

			var tilemap:FlxTilemap = new FlxTilemap();
			tilemap.loadMapFromArray(tileLayer.tileArray, width, height, processedPath,
				tileSet.tileWidth, tileSet.tileHeight, OFF, tileSet.firstGID, 1, 1);

			loadObjects(state);

			if (tileLayer.properties.get("type") == "floor")
			{
				floorLayer.add(tilemap);
			}
			else if (tileLayer.properties.get("type") == "foreground")
			{
				foregroundLayer.add(tilemap);
			}
			else if (tileLayer.properties.get("type") == "collidable")
			{
				if (collidableTileLayers == null)
					collidableTileLayers = new Array<FlxTilemap>();
				tilemap.allowCollisions = FlxObject.ANY;
				collidableLayer.add(tilemap);
				collidableTileLayers.push(tilemap);
			}
		}
	}

	public function update(elapsed:Float):Void
	{
		updateCollisions();
	}

	public function updateCollisions():Void
	{
		FlxG.collide(collidableLayer, characterGroup);
		FlxG.collide(collidableLayer, enemiesGroup);
		FlxG.collide(collidableLayer, playerBulletGroup, destroyBullet);
		FlxG.collide(collidableLayer, enemyBulletGroup, destroyBullet);

		FlxG.overlap(playerBulletGroup, breakableGroup, poomBarrel);
		FlxG.overlap(enemyBulletGroup, breakableGroup, poomBarrel);
		FlxG.overlap(characterGroup, particlesGroup, particlesVsPlayer);
		FlxG.overlap(enemiesGroup, particlesGroup, particlesVsEnemies);

		FlxG.overlap(enemyBulletGroup, characterGroup, bulletVsPlayer);
		FlxG.overlap(playerBulletGroup, enemiesGroup, bulletVsEnemy);
		FlxG.overlap(characterGroup, pickupGroup, pickItem);
	}

	public function loadObjects(state:PlayState)
	{
		var layer:TiledObjectLayer;
		for (layer in layers)
		{
			if (layer.type != TiledLayerType.OBJECT) continue;
			var objectLayer:TiledObjectLayer = cast layer;
			if (layer.name == "objects")
			{
				for (o in objectLayer.objects)
				{
					loadObject(state, o, objectLayer, objectsLayer);
				}
			}
		}
	}

	private function loadObject(state:PlayState, o:TiledObject, g:TiledObjectLayer, group:FlxGroup)
	{
		var x:Int = o.x;
		var y:Int = o.y;

		// objects in tiled are aligned bottom-left (top-left in flixel)
		if (o.gid != -1)
			y -= g.map.getGidOwner(o.gid).tileHeight;

		switch (o.type.toLowerCase())
		{
			case "player_start":
				objectsLayer.add(playerBulletGroup);
				GlobalGameData.playerBullets = playerBulletGroup; //arreglar player para que tome bullets del GGD
				var player = new Player(x, y);
				//dibujar arma aca?
				//FlxG.camera.setScrollBoundsRect(0, 0, this.width,this.height);
				FlxG.camera.follow(player, FlxCameraFollowStyle.TOPDOWN);
				FlxG.worldBounds.set(0, 0, fullWidth, fullHeight);
				GlobalGameData.player = player;
				characterGroup.add(player);
				hudLayer = new HUD(1, "Rock Castle"); //(lvlNumber, lvlDesc);
				GlobalGameData.aHud = hudLayer;
				hudLayer.updateHUD();

			case "enemy":
				objectsLayer.add(enemyBulletGroup);
				GlobalGameData.enemiesBullets = enemyBulletGroup; //idem player
				//idem player: arma?
				var enemy = new HunterEnemy(x, y);//new FlxSprite(x, y);  //Usar un Factory para crear diferentes Enemies? Que usar para diferenciarlos?
				//state.enemies.add(enemy);
				enemiesGroup.add(enemy);

			case "breakable":
				GlobalGameData.particles = particlesGroup;
				var barrel = new Barrel(x, y);
				objectsLayer.add(barrel);
				breakableGroup.add(barrel);
				//state.barrels.add(barrel);

			case "pickup":
				var tileset = g.map.getGidOwner(o.gid);
				var pickup = new HealthPickUp(x, y);
				//state.healthpickups.add(pickup);
				objectsLayer.add(pickup);
				pickupGroup.add(pickup);

			case "exit":
				// Create the level exit
				var exit = new FlxSprite(x, y);
				exit.makeGraphic(32, 32, 0xff3f3f3f);
				exit.exists = false;
				state.exit = exit;
				group.add(exit);
		}
	}
//
	//public function loadImages()
	//{
		//for (layer in layers)
		//{
			//if (layer.type != TiledLayerType.IMAGE)
				//continue;
//
			//var image:TiledImageLayer = cast layer;
			//var sprite = new FlxSprite(image.x, image.y, c_PATH_LEVEL_TILESHEETS + image.imagePath);
			//imagesLayer.add(sprite);
		//}
	//}

	public function collideWithLevel(obj:FlxBasic, ?notifyCallback:FlxObject->FlxObject->Void, ?processCallback:FlxObject->FlxObject->Bool):Bool
	{
		if (collidableTileLayers == null)
			return false;

		for (map in collidableTileLayers)
		{
			// IMPORTANT: Always collide the map with objects, not the other way around.
			//			  This prevents odd collision errors (collision separation code off by 1 px).
			if (FlxG.overlap(map, obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate))
			{
				return true;
			}
		}
		return false;
	}

	private function poomBarrel(aBullet:Bullet, abarrel:Barrel):Void
	{
		if (aBullet.exists && aBullet.alive && abarrel.exists && abarrel.alive){
			aBullet.kill();
			abarrel.explote();
		}
	}

	private function destroyBullet(t:FlxTilemap, b:Bullet):Void
	{
		if (b.exists && b.alive){
			b.kill();
		}
	}

	private function bulletVsEnemy(b:Bullet, e:Enemy):Void
	{
		if (e.exists && e.alive && b.exists && b.alive){
			e.receiveDamage(b.bulletDamage);
			b.kill();
		}
	}

	private function bulletVsPlayer(b:Bullet, p:Player):Void
	{
		if (p.exists && p.alive && b.exists && b.alive){
			p.receiveDamage(b.bulletDamage);
			b.kill();
			hudLayer.updateHUD();
		}
	}

	private function particlesVsPlayer(p:Player, par:FlxParticle):Void
	{
		if (p.exists && p.alive && par.exists && par.alive){
					p.receiveDamage(2);
					par.kill();
					hudLayer.updateHUD();
		}
	}

	private function particlesVsEnemies(e:Enemy, par:FlxParticle):Void
	{
		if (e.exists && e.alive && par.exists && par.alive){
					e.receiveDamage(2);
					par.kill();
					hudLayer.updateHUD();
		}
	}

	private function pickItem(p:Player, pk:HealthPickUp):Void
	{
		if (p.exists && p.alive && pk.exists && pk.alive)
		{
			//if (pk.name = "life"){
				if (!p.fullHealth())
				{
					p.healPlayer(pk.lifeAmount);
					pk.kill();
					hudLayer.updateHUD();
				}
			//}
		}
	}
}