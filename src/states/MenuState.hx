package states;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import gameObjects.Pointer;
import menus.MainMenu;


/**
 * ...
 * @author Gastón // Nacho
 */
class MenuState extends FlxState
{
	//Cursor
	private var gamePointer:Pointer;
	
	//Images
	private var gameLogo:FlxSprite;
	
	//Menu
	private var menu: MainMenu;
	
	public function new()
	{
		super();
	}
	
	
	override public function create():Void
	{
		super.create();
		//Set Logo
		gameLogo = new FlxSprite(0, 50);
		//gameLogo.loadGraphic(AssetPaths.logo__png, false, 375, 148);
		gameLogo.loadGraphic("img/logo.png",false, 375, 148);
		gameLogo.screenCenter(FlxAxes.X);
		add(gameLogo);
		//Set Sounds
		//Cambiar esto por AssethPath
		FlxG.sound.playMusic("music/01_labyrinth.mp3", 0.2, true);
		
		menu = new MainMenu();
		
		add(menu);
				
		this.changeGamePointer();
		
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	


	
	private function changeGamePointer(){
		gamePointer = new Pointer();
		FlxG.mouse.visible = false;
		FlxG.mouse.hideSystemCursor();
		add(gamePointer);
	}
	
	
}
