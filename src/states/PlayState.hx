package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;

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
	//Cursor
	private var gamePointer:Pointer;
	
	//HUD + UI
	private var hud:HUD;
	private var lvlNumber:Int;
	private var lvlDesc:String;
	private var txtPlayerLife: FlxText;
	private var txtLevelNumber: FlxText;
	private var txtLevelDescription: FlxText;

	//Map
	private var map:FlxTilemap;
	private var tileWidth:  Int = 16;
	private var tileHeight: Int = 16;
	
	//Player
	private var gamePlayer:Player;
		
	//Enemies
	private var enemies:FlxGroup;
	
	
	public function new(aLvlNumber:Int, aLvlDesc:String) 
	{
		super();
		this.lvlNumber = aLvlNumber;
		this.lvlDesc = aLvlDesc;
		enemies = new FlxGroup();
		
	}
	
	override public function create():Void 
	{	
		map = new FlxTilemap();
		map.loadMapFromCSV(Assets.getText("img/maps/tilemapdata.csv"), Assets.getBitmapData("img/maps/tilemap.png"), tileWidth, tileHeight,1,1);
		add(map);
		
		gamePlayer = new Player(100, 100);
		GlobalGameData.player = gamePlayer;
		//gamePlayer.width = 16;
		//gamePlayer.height = 22;
		//gamePlayer.playerGun.x += 15;
		//gamePlayer.playerGun.y += 10;
		this.add(gamePlayer);
		this.add(gamePlayer.playerGun);
		this.add(gamePlayer.playerGun.bullets);
		
		
		/*
		hud = new HUD();
		add(hud);
		*/
		
		txtLevelNumber = new FlxText(0, 25, 200, "Level: " + this.lvlNumber , 12);
		txtLevelNumber.screenCenter(FlxAxes.X);
		this.add(txtLevelNumber);
		
		txtLevelDescription = new FlxText(0, 50, 200, "( " + this.lvlDesc + " )", 14);
		txtLevelDescription.screenCenter(FlxAxes.X);
		this.add(txtLevelDescription);
		
		txtPlayerLife = new FlxText(15, 25, 200, "Life: " + gamePlayer.playerLife, 12);
		this.add(txtPlayerLife);
		this.loadEnemies();
		this.changeGamePointer();
		
		FlxG.camera.follow(gamePlayer, NO_DEAD_ZONE, 1);
		FlxG.camera.zoom = 2;
		
		//hud.updateHUD(GlobalGameData.player.playerLife, GlobalGameData.player.totalLife);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.collide(map, gamePlayer);
		FlxG.collide(map, gamePlayer.playerGun.bullets);
	}
	
	private function loadEnemies(){
		/*enemies.add(new Enemy(150, 250));
		enemies.add(new HunterEnemy(300, 400));
		enemies.add(new BossEnemy(550, 550));
		add(enemies);*/
	}
	
	private function changeGamePointer()
	{
		gamePointer = new Pointer();
		FlxG.mouse.visible = false;
		FlxG.mouse.hideSystemCursor();
		add(gamePointer);
	}
		
	
}