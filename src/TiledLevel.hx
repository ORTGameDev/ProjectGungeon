package;

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
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import gameObjects.enemies.Enemy;
import gameObjects.enemies.HunterEnemy;
import gameObjects.pickups.HealthPickUp;
import gameObjects.players.Player;
import haxe.io.Path;
import states.PlayState;

/**
 * @author Ignacio Benedetto
 */
class TiledLevel extends TiledMap
{
	// For each "Tile Layer" in the map, you must define a "tileset" property which contains the name of a tile sheet image 
	// used to draw tiles in that layer (without file extension). The image file must be located in the directory specified bellow.
	private inline static var c_PATH_LEVEL_TILESHEETS = "maps/";
	
	// Array of tilemaps used for collision
	public var foregroundLayer:FlxGroup; //muros no colisionables
	public var objectsLayer:FlxGroup; //jugadores, enemies, pickups, barrels
	public var floorLayer:FlxGroup;
	public var collidableLayer:FlxGroup;
	public var characterLayer:FlxGroup;
	public var enemiesLayer:FlxGroup;
	public var pickupLayer:FlxGroup;
	
	private var collidableTileLayers:Array<FlxTilemap>;
	
	
	public function new(tiledLevel:Dynamic, state:PlayState)
	{
		super(tiledLevel);
		
		imagesLayer = new FlxGroup();
		
		floorLayer = new FlxGroup();
		foregroundLayer = new FlxGroup();
		collidableLayer = new FlxGroup();
		
		objectsLayer = new FlxGroup();
		characterLayer = new FlxGroup();
		enemiesLayer = new FlxGroup();
		pickupLayer = new FlxGroup();
		
		
		
		
		FlxG.camera.setScrollBoundsRect(0, 0, fullWidth, fullHeight, true);
		
		loadImages();
		
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
				
				collidableLayer.add(tilemap);
				collidableTileLayers.push(tilemap);
			}
		}
	}
	
	public function loadObjects(state:PlayState)
	{
		var layer:TiledObjectLayer;
		for (layer in layers)
		{
			if (layer.type != TiledLayerType.OBJECT)
				continue;
			var objectLayer:TiledObjectLayer = cast layer;
			
			//objects layer
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
				var player = new Player(x, y);
				FlxG.camera.follow(player, FlxCameraFollowStyle.TOPDOWN);
				//FlxG.camera.setScrollBoundsRect(0, 0, this.width,this.height);
				//FlxG.worldBounds.set(0, 0, this.width, this.height);
				//state.gamePlayer = player;
				GlobalGameData.player = player;
				characterLayer.add(player);

			case "enemy":
				var enemy = new HunterEnemy(x, y);//new FlxSprite(x, y);
				//state.enemies.add(enemy);
				enemiesLayer.add(enemy);
				
			case "pickup":
				var tileset = g.map.getGidOwner(o.gid);
				var pickup = new HealthPickUp(x, y);
				//state.healthpickups.add(pickup);
				pickupLayer.add(pickup);
				
			case "exit":
				// Create the level exit
				var exit = new FlxSprite(x, y);
				exit.makeGraphic(32, 32, 0xff3f3f3f);
				exit.exists = false;
				state.exit = exit;
				group.add(exit);
		}
	}

	public function loadImages()
	{
		for (layer in layers)
		{
			if (layer.type != TiledLayerType.IMAGE)
				continue;

			var image:TiledImageLayer = cast layer;
			var sprite = new FlxSprite(image.x, image.y, c_PATH_LEVEL_TILESHEETS + image.imagePath);
			imagesLayer.add(sprite);
		}
	}
	
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
}