package states;
import GlobalGameData;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import gameObjects.enemies.BossEnemy;
import gameObjects.enemies.SkeletonEnemy;
import gameObjects.enemies.SummonerEnemy;
import gameObjects.guns.Bullet;
import gameObjects.enemies.Enemy;
import gameObjects.enemies.HunterEnemy;
import gameObjects.enemies.PistolPete;
import gameObjects.pickups.HealthPickUp;
import gameObjects.players.Player;
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
	
	//PickUps
	private var healthpickups: FlxTypedGroup<HealthPickUp>;
	
	
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
		map.loadMapFromCSV(Assets.getText("img/maps/level001.csv"), Assets.getBitmapData("img/maps/mapTiles.png"), tileWidth, tileHeight, null, 0, 1 ,6);
		add(map);
		//Player Setup
		gamePlayer = new Player(gamePlayerXSpawn, gamePlayerYSpawn);
		GlobalGameData.player = gamePlayer;
		add(gamePlayer);
		add(gamePlayer.playerGun);
		add(gamePlayer.playerGun.bullets);
		
		enemyBullets = new FlxTypedGroup<Bullet>();
		GlobalGameData.enemiesBullets = enemyBullets;
		add(enemyBullets);
		
		healthpickups = new FlxTypedGroup<HealthPickUp>();
		GlobalGameData.healthspick = healthpickups;
		
		
		this.loadEnemies();
		GlobalGameData.enemies = this.enemies;
		this.loadPickUps();
		
		hud = new HUD(lvlNumber, lvlDesc);
		hud.updateHUD();
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
		FlxG.collide(map, GlobalGameData.enemiesBullets, destroyBullet);
		FlxG.overlap(GlobalGameData.enemiesBullets, gamePlayer , bulletVsPlayer);
		FlxG.overlap(gamePlayer, GlobalGameData.healthspick, healPlayer);
		FlxG.worldBounds.set(0, 0, FlxG.camera.width, FlxG.camera.height);
		
		if (enemies.countLiving() == 0)
		{
			hud.playerWin();
		}
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
			hud.updateHUD();
		}
	}
	
	private function healPlayer(p:Player, h:HealthPickUp):Void
	{
		if (p.exists && p.alive && h.exists && h.alive)
		{
			if (!p.fullHealth())
			{
				p.healPlayer(h.lifeAmount);	
				h.kill();
				hud.updateHUD();
			}
		}
	}
	
	private function loadPickUps():Void
	{
		healthpickups.add(new HealthPickUp(800, 800));
		healthpickups.add(new HealthPickUp(500, 1000));
		healthpickups.add(new HealthPickUp(1200, 900));
		add(healthpickups);
	}
	private function loadEnemies():Void
	{	
		
		enemies.add(new HunterEnemy(1000, 1200));
		enemies.add(new HunterEnemy(1000, 2000));
		enemies.add(new HunterEnemy(1500, 900));
		enemies.add(new SkeletonEnemy(1020, 1000));
		enemies.add(new SkeletonEnemy(1040, 1100));
		enemies.add(new SkeletonEnemy(1060, 1200));
		enemies.add(new SummonerEnemy(1080, 1300));
		/*enemies.add(new HunterEnemy(2500, 3000));
		enemies.add(new HunterEnemy(2000, 3000));
		*/
		enemies.add(new BossEnemy(1200, 2800));
		add(enemies);
		for (e in enemies)
		{
			if (e.enemyGun != null){
			add(e.enemyGun);
			//add(e.enemyGun.bullets);
			}
		}

	}
	
	private function changeGamePointer()
	{
		gamePointer = new Pointer();
		FlxG.mouse.visible = false;
		FlxG.mouse.hideSystemCursor();
		add(gamePointer);
	}

	
}