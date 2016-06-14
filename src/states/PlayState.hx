package states;
import GlobalGameData;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import gameObjects.Barrel;
import gameObjects.enemies.BossEnemy;
import gameObjects.enemies.Skeleton;
import gameObjects.enemies.Summoner;
import gameObjects.guns.Bullet;
import gameObjects.enemies.Enemy;
import gameObjects.enemies.GreenOrc;
import gameObjects.enemies.PistolPete;
import gameObjects.pickups.HealthPickup;
import gameObjects.players.Player;
import gameObjects.Pointer;
import level.LevelManager;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal
 */
class PlayState extends FlxState
{
	//level
	public var level:LevelManager;

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
	public var gamePlayer:Player;
	private static inline var gamePlayerXSpawn:Int = 200;
	private static inline var gamePlayerYSpawn:Int = 200;

	//Enemies
	public var enemies:FlxTypedGroup<Enemy>;
	private var enemyBullets:FlxTypedGroup<Bullet>;

	//PickUps
	public var pickups: FlxTypedGroup<FlxSprite>;

	//Barrels & Explotions
	private var barrels: FlxTypedGroup<Barrel>;
	private var explotionParticles : FlxTypedGroup<FlxParticle>;

	//Exit
	public var exit:FlxSprite;

	public function new()
	{
		super();
		enemies = new FlxTypedGroup<Enemy>();

	}

	override public function create():Void
	{
		//Map Setup
		//map = new FlxTilemap();
		////map.loadMapFromCSV(Assets.getText(AssetPaths.lvl1__csv), Assets.getBitmapData(AssetPaths.mapTiles__png), tileWidth, tileHeight, null, 0, 1, 5);
		//map.loadMapFromCSV(Assets.getText("img/maps/level001.csv"), Assets.getBitmapData("img/maps/mapTiles.png"), tileWidth, tileHeight, null, 0, 1 ,6);
		//add(map);
		////Player Setup
		//gamePlayer = new Player(gamePlayerXSpawn, gamePlayerYSpawn);
		pickups = new FlxTypedGroup<FlxSprite>();
		enemyBullets = new FlxTypedGroup<Bullet>();


		GlobalGameData.pickups = pickups;
		GlobalGameData.enemiesBullets = enemyBullets;
		//add(enemyBullets);


		//GlobalGameData.healthspick = healthpickups;

		level = new level.LevelManager("maps/level1.tmx", this);

		// Add floor
		add(level.floorLayer);

		// Add objects
		add(level.objectsLayer);

		add(level.characterGroup);
		
		add(level.enemiesGroup);
		
		loadEnemyBullets();

		// Add foreground tiles after adding level objects, so these tiles render on top of player
		add(level.foregroundLayer);

		add(level.collidableLayer);

		add(level.hudLayer);
	
		this.changeGamePointer();
	}

	override public function update(elapsed:Float):Void
	{
		level.update(elapsed);
		super.update(elapsed);
		
		if (enemies.countLiving() == 0)
		{
			hud.playerWin();
		}
	}

	private function loadEnemyBullets():Void
	{
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
