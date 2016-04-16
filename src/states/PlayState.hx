package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import gameObjects.Enemy;
import gameObjects.Gun;
import gameObjects.Player;
import gameObjects.Pointer;
import GlobalGameData;

/**
 * ...
 * @author Gastón Marichal
 */
class PlayState extends FlxState
{
	//Cursor
	private var gamePointer:Pointer;
	
	//Player
	private var gamePlayer:Player;
	private var lvlNumber:Int;
	private var lvlDesc:String;
	private var txtPlayerLife: FlxText;
	private var txtLevelNumber: FlxText;
	private var txtLevelDescription: FlxText;
	
	//Map
	
	
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
		var aGun = new Gun(0, 0);	
		gamePlayer = new Player(100, 100, aGun); 
		aGun.x = gamePlayer.x + 10;
		aGun.y = gamePlayer.y + (gamePlayer.height / 2);
		this.add(aGun);
		this.add(gamePlayer);
		
		GlobalGameData.player = gamePlayer;
		
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
		
		//FlxG.camera.follow(gamePlayer, NO_DEAD_ZONE, 1);
		FlxG.camera.zoom = 2;
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
	}
	
	private function loadEnemies(){
		enemies.add(new Enemy(150, 250, 20, 20, 5, 5, "characters/jason.png"));
		enemies.add(new Enemy(300, 400, 20, 20, 5, 5, "characters/jason.png"));
		enemies.add(new Enemy(550, 505, 20, 20, 5, 5, "characters/jason.png"));
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