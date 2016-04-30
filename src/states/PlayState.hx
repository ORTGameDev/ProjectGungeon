package states;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.addons.editors.tiled.TiledMap;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import openfl.display.Tile;

import flixel.util.FlxAxes;
import gameObjects.BossEnemy;
import gameObjects.Bullet;
import gameObjects.Enemy;
import gameObjects.Gun;
import gameObjects.HunterEnemy;
import gameObjects.Player;
import gameObjects.Pointer;
import GlobalGameData;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal
 */
class PlayState extends FlxState
{
	
	//Level  data
	private var lvlNumber: Int = 1;
	private var lvlDesc : String = "Nacho´s Room";
	
	//Cursor
	private var gamePointer:Pointer;
	
	//HUD + UI
	private var hud:HUD;
	

	//Map
	private var map:FlxTilemap;
	private var tileWidth:  Int = 32;
	private var tileHeight: Int = 32;
	
	//Player
	private var gamePlayer:Player;
		
	//Enemies
	private var enemies:FlxGroup;
	
	
	public function new() 
	{
		super();
		enemies = new FlxGroup();
		
	}
	
	override public function create():Void 
	{	
		//Map Setup
		map = new FlxTilemap();
		map.loadMapFromCSV(Assets.getText("img/maps/lvl1.csv"), Assets.getBitmapData("img/maps/mapTiles.png"), tileWidth, tileHeight);
		map.setTileProperties(1, FlxObject.ANY);
		map.setTileProperties(2, FlxObject.NONE);
		map.setTileProperties(3, FlxObject.NONE);
		map.setTileProperties(4, FlxObject.NONE);
		map.setTileProperties(5, FlxObject.ANY);
		add(map);
		
		//Playee Setup
		gamePlayer = new Player(200, 200);
		GlobalGameData.player = gamePlayer;
		//gamePlayer.width = 16;
		//gamePlayer.height = 22;
		gamePlayer.playerGun.x += 15;
		gamePlayer.playerGun.y += 10;
		add(gamePlayer);
		add(gamePlayer.playerGun);
		add(gamePlayer.playerGun.bullets);
		
		
		hud = new HUD(lvlNumber, lvlDesc);
		add(hud);
		
		
		//hud.updateHUD(GlobalGameData.player.playerLife, GlobalGameData.player.totalLife);
		this.loadEnemies();
		this.changeGamePointer();
		
		
		
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.worldBounds.setPosition(gamePlayer.x-400, gamePlayer.y-240);
		//FlxG.collide(_mWalls, gamePlayer);
		//FlxG.collide(_mWalls, gamePlayer.playerGun.bullets, destroyBullet);
		//FlxG.collide(_mWalls, enemies);
		FlxG.overlap(gamePlayer.playerGun.bullets, enemies, bulletVsEnemy);
		//FlxG.collide(map, gamePlayer);
		//FlxG.collide(map, gamePlayer.playerGun.bullets);
		
		FlxG.camera.follow(gamePlayer, LOCKON, 2);
		FlxG.camera.target = gamePlayer;
		//FlxG.camera.zoom = 4;
		
		
		FlxG.worldBounds.set(0, 0, FlxG.camera.width, FlxG.camera.height);
		
	}
	
	private function destroyBullet(t:FlxTilemap, b:Bullet):Void
	{
		if (t.exists && t.alive && b.exists && b.alive){
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
	
	private function loadEnemies(){
		enemies.add(new Enemy(1000, 1200));
		enemies.add(new HunterEnemy(580, 900));
		enemies.add(new BossEnemy(550, 550));
		add(enemies);
	}
	
	private function changeGamePointer()
	{
		gamePointer = new Pointer();
		FlxG.mouse.visible = false;
		FlxG.mouse.hideSystemCursor();
		add(gamePointer);
	}
		
	
}