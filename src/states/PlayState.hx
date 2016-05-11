package states;
import GlobalGameData;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import gameObjects.BossEnemy;
import gameObjects.Bullet;
import gameObjects.Enemy;
import gameObjects.HunterEnemy;
import gameObjects.PistolPete;
import gameObjects.Player;
import gameObjects.Pointer;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal
 */
class PlayState extends FlxState
{
	
	//Level  data
	private var lvlNumber: Int = 1;
	private var lvlDesc : String = "Rock Castle";
	
	//Cursor+
	private var gamePointer:Pointer;
	
	//HUD + UI
	private var hud:HUD;
	
	//Map
	private var map:FlxTilemap;
	private var tileWidth:  Int = 32;
	private var tileHeight: Int = 32;
	
	//Player
	private var gamePlayer:Player;
	private static inline var gamePlayerXSpawn:Int = 200;
	private static inline var gamePlayerYSpawn:Int = 200;
		
	//Enemies
	private var enemies:FlxTypedGroup<Enemy>;
	private var enemyBullets:FlxTypedGroup<Bullet>;
	
	
	public function new() 
	{
		super();
		enemies = new FlxTypedGroup<Enemy>();
		
	}
	
	override public function create():Void 
	{	
		//Map Setup
		map = new FlxTilemap();
		//map.loadMapFromCSV(Assets.getText(AssetPaths.lvl1__csv), Assets.getBitmapData(AssetPaths.mapTiles__png), tileWidth, tileHeight, null, 0, 1, 5);
		map.loadMapFromCSV(Assets.getText("img/maps/lvl1.csv"), Assets.getBitmapData("img/maps/mapTiles.png"), tileWidth, tileHeight, null, 0, 1 ,6);
		add(map);
		//Player Setup
		gamePlayer = new Player(gamePlayerXSpawn, gamePlayerYSpawn);
		GlobalGameData.player = gamePlayer;
		//gamePlayer.width = 16;
		//gamePlayer.height = 22;
		gamePlayer.playerGun.x += 15;
		gamePlayer.playerGun.y += 10;
		add(gamePlayer);
		add(gamePlayer.playerGun);
		add(gamePlayer.playerGun.bullets);
		
		this.loadEnemies();
		
		hud = new HUD(lvlNumber, lvlDesc);
		add(hud);
		
		FlxG.camera.follow(gamePlayer, FlxCameraFollowStyle.TOPDOWN);
		FlxG.camera.setScrollBoundsRect(0, 0, map.width,map.height);
		FlxG.worldBounds.set(0, 0, map.width, map.height);
		this.changeGamePointer();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.worldBounds.setPosition(gamePlayer.x-400, gamePlayer.y-240);
		FlxG.overlap(gamePlayer.playerGun.bullets, enemies, bulletVsEnemy);
		FlxG.collide(map, gamePlayer);
		FlxG.collide(map, enemies);
		FlxG.collide(map, gamePlayer.playerGun.bullets, destroyBullet);
		
		//FlxG.camera.follow(gamePlayer, LOCKON, 2);
		//FlxG.camera.target = gamePlayer;
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
	
	private function bulletVsPlayer(b:Bullet, p:Player):Void
	{
		if (p.exists && p.alive && b.exists && b.alive){
			p.receiveDamage(b.bulletDamage);			
			b.kill();
		}
	}
	
	private function loadEnemies()
	{
		enemies.add(new Enemy(1000, 1200));
		enemies.add(new Enemy(1000, 2000));
		enemies.add(new Enemy(1500, 900));
		//enemies.add(new HunterEnemy(580, 900));
		enemies.add(new BossEnemy(3000, 3000));
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