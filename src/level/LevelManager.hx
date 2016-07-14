package level;

import flixel.FlxBasic;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
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
import gameObjects.Explotion;
import gameObjects.Exit;
import gameObjects.enemies.Enemy;
import gameObjects.enemies.GreenOrc;
import gameObjects.enemies.Skeleton;
import gameObjects.enemies.Summoner;
import gameObjects.guns.bullets.Bullet;
import gameObjects.pickups.HealthPickup;
import gameObjects.pickups.Pickup;
import gameObjects.pickups.ShotgunPickup;
import gameObjects.players.Player;
import haxe.io.Path;


/**
 * @author Ignacio Benedetto
**/
class LevelManager extends TiledMap
{
	// For each "Tile Layer" in the map, you must define a "tileset" property which contains the name of a tile sheet image
	// used to draw tiles in that layer (without file extension). The image file must be located in the directory specified bellow.
	private var c_PATH_LEVEL_TILESHEETS="";
	
	private var collidableTileLayers:Array<FlxTilemap>;

	private var gameOver: Bool = false;

	private var exit:Exit;
	
	private var level: Dynamic;

	//Layers
	public var foregroundLayer:FlxGroup; //muros no colisionables
	public var objectsLayer:FlxGroup; //jugadores, enemies, pickups, barrels
	public var floorLayer:FlxGroup;
	public var collidableLayer:FlxTypedGroup<FlxTilemap>;

	//Groups
	public var hud:HUD;
	public var characterGroup:FlxGroup;
	public var enemiesGroup:FlxTypedGroup<Enemy>;
	public var pickupGroup:FlxTypedGroup<Pickup>;
	public var breakableGroup:FlxGroup;
	public var explotionGroup:FlxTypedGroup<Explotion>;
	public var playerBulletGroup:FlxTypedGroup<Bullet>;
	public var enemyBulletGroup:FlxTypedGroup<Bullet>;
	
	public function new(tiledLevel:Dynamic)
	{
		level = tiledLevel;
		var levelString = "level" + level;
		var pathLevel = "maps/" + levelString + "/";
		var mapPath = pathLevel + levelString + ".tmx";
		super(mapPath);
		loadLevel(tiledLevel);
		
		
	}

	public function update(elapsed:Float):Void
	{
		updateCollisions();
		if (!gameOver) {
			if (GlobalGameData.player.playerCurrentLife <= 0) {
				gameOver = true;
				hud.createPlayMenu(false);
			} else if (GlobalGameData.enemies.countLiving() == 0) {
				gameOver = true;
				exit.alive = true;
			}
		}
	}
	
	private function loadLevel(tiledLevel:Dynamic): Void {
		level = tiledLevel;
		var levelString = "level" + level;
		var pathLevel = "maps/" + levelString + "/";
		var mapPath = pathLevel + levelString + ".tmx";
		c_PATH_LEVEL_TILESHEETS = pathLevel;
		floorLayer = new FlxGroup();
		foregroundLayer = new FlxGroup();
		collidableLayer = new FlxTypedGroup<FlxTilemap>();
		objectsLayer = new FlxGroup();

		explotionGroup = new FlxTypedGroup<Explotion>();
		GlobalGameData.explotions = explotionGroup;

		breakableGroup = new FlxGroup();
		characterGroup = new FlxGroup();
		enemiesGroup = new FlxTypedGroup<Enemy>();

		pickupGroup = new FlxTypedGroup<Pickup>();
		GlobalGameData.pickups = pickupGroup;


		playerBulletGroup = new FlxTypedGroup<Bullet>();
		enemyBulletGroup = new FlxTypedGroup<Bullet>();
		GlobalGameData.playerBullets = playerBulletGroup;
		GlobalGameData.enemiesBullets = enemyBulletGroup;
		GlobalGameData.enemies = enemiesGroup;

		FlxG.camera.setScrollBoundsRect(0, 0, fullWidth, fullHeight, true);

		loadTileLayers();
		loadObjects();
	}

	public function updateCollisions():Void
	{
		FlxG.collide(collidableLayer, characterGroup);
		FlxG.collide(collidableLayer, enemiesGroup);
		FlxG.collide(collidableLayer, playerBulletGroup, destroyBullet);
		FlxG.collide(collidableLayer, enemyBulletGroup, destroyBullet);

		FlxG.collide(breakableGroup, enemiesGroup);
		FlxG.collide(breakableGroup, characterGroup);

		FlxG.overlap(playerBulletGroup, breakableGroup, poomBarrel);
		FlxG.overlap(enemyBulletGroup, breakableGroup, poomBarrel);

		FlxG.overlap(enemyBulletGroup, characterGroup, bulletVsPlayer);
		FlxG.overlap(playerBulletGroup, enemiesGroup, bulletVsEnemy);
		FlxG.overlap(characterGroup, pickupGroup, pickItem);

		FlxG.overlap(characterGroup, explotionGroup, explotionHitPlayer);
		FlxG.overlap(enemiesGroup, explotionGroup, explotionHitEnemy);
		FlxG.overlap(explotionGroup, breakableGroup, explotionHitBarrel);

		FlxG.overlap(characterGroup, exit, nextLevel);
	}

	private function explotionHitEnemy(e:Enemy, exp:Explotion):Void
	{
		if (exp.exists && exp.alive && e.exists && e.alive)
		{
			e.receiveDamage(exp.expDamage);
		}
	}

	private function explotionHitBarrel(e1:Explotion, b:Barrel):Void
	{
		if (e1.exists && e1.alive && b.exists && b.alive)
		{
			b.eBreak();
		}
	}

	private function explotionHitPlayer(p:Player, exp:Explotion):Void
	{
		if (exp.exists && exp.alive && p.exists && p.alive)
		{
			p.receiveDamage(exp.expDamage);
		}
	}
	

	public function loadObjects()
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
					loadObject( o, objectLayer, objectsLayer);
				}
			}
		}
	}

	private function loadObject(o:TiledObject, g:TiledObjectLayer, group:FlxGroup)
	{
		var x:Int = o.x;
		var y:Int = o.y;

		
		objectsLayer.add(playerBulletGroup);
		objectsLayer.add(enemyBulletGroup);
		

		// objects in tiled are aligned bottom-left (top-left in flixel)
		if (o.gid != -1)
			y -= g.map.getGidOwner(o.gid).tileHeight;

		switch (o.type.toLowerCase())
		{
			case "player_start":
				var player = new Player(x, y);
				GlobalGameData.player = player;
		 		characterGroup.add(player);
				FlxG.camera.follow(player, FlxCameraFollowStyle.TOPDOWN);
				FlxG.worldBounds.set(0, 0, fullWidth, fullHeight);
				hud = new HUD(); //(lvlNumber, lvlDesc);
				GlobalGameData.aHud = hud;
			case "enemy":
				 var enemy = EnemyFactory.getEnemy(o.properties.get("eType"), x, y);//new FlxSprite(x, y);  //Usar un Factory para crear diferentes Enemies? Que usar para diferenciarlos?
				 enemiesGroup.add(enemy);

			case "breakable":
				var barrel = new Barrel(x, y);
				breakableGroup.add(barrel);
				objectsLayer.add(breakableGroup);

			case "pickup":
				var tileset = g.map.getGidOwner(o.gid);
				var pickup = PickupFactory.getPickup(o.properties.get("pType"), x, y);
				pickupGroup.add(pickup);
				objectsLayer.add(pickupGroup);

			case "exit":
				exit = new Exit(x, y);
				objectsLayer.add(exit);
		}
	}
	
	private function loadTileLayers():Void {
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
				//tilemap.inmovable?
				collidableLayer.add(tilemap);
				collidableTileLayers.push(tilemap);
			}
		}
	}

	private function poomBarrel(aBullet:Bullet, abarrel:Barrel):Void
	{
		if (aBullet.exists && aBullet.alive && abarrel.exists && abarrel.alive){
			aBullet.kill();
			abarrel.eBreak();
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
		if (p.exists && p.alive && !p.isHurt && b.exists && b.alive){
			p.receiveDamage(b.bulletDamage);
			b.kill();
			hud.updateHUD();
		}
	}

	private function particlesVsPlayer(p:Player, par:FlxParticle):Void
	{
		if (p.exists && p.alive && par.exists && par.alive){
			p.receiveDamage(2);
			par.kill();
			hud.updateHUD();
		}
	}

	private function particlesVsEnemies(e:Enemy, par:FlxParticle):Void
	{
		if (e.exists && e.alive && par.exists && par.alive){
			e.receiveDamage(2);
			par.kill();
			hud.updateHUD();
		}
	}

	private function pickItem(p:Player, pk:Pickup):Void
	{
		if (p.exists && p.alive)
		{
			pk.pickUp();
		}
	}

	private function nextLevel(p:Player, e:Exit):Void {
		if (e.exists && e.alive && p.exists && p.alive) {
			clearLevel();
			loadLevel(level + 1);			
		}
	}
	
	private function clearLevel():Void{
		GlobalGameData.clear();
		floorLayer.destroy();
		floorLayer = null;
		foregroundLayer.destroy();
		foregroundLayer = null;
		collidableLayer.destroy();
		collidableLayer = null;
		objectsLayer.destroy();
		objectsLayer = null;
		explotionGroup = null;
		breakableGroup.destroy();
		breakableGroup = null;
		characterGroup.destroy();
		characterGroup = null;
		enemiesGroup = null;
		pickupGroup = null;
	}
}
