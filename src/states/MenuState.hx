package states;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import gameObjects.Pointer;


/**
 * ...
 * @author Gastón // Nacho
 */
class MenuState extends FlxState
{
	//Cursor
	private var gamePointer:Pointer;
	
	//Images
	
	//Buttons	
	private var gameLogo:FlxSprite;
	private var btnPlay: FlxButton;
	private var btnSettings: FlxButton;
	
	//General
	private static inline var buttonGap: Int = 10;

	public function new()
	{
		super();
	}
	
	
	override public function create():Void
	{
		super.create();
		//Set Texts
		gameLogo = new FlxSprite(0, 50);
		//gameLogo.loadGraphic(AssetPaths.logo__png, false, 375, 148);
		gameLogo.loadGraphic("img/logo.png",false, 375, 148);
		gameLogo.screenCenter(FlxAxes.X);
		add(gameLogo);
		
		//Set Button
		btnPlay = new FlxButton(0, gameLogo.y + gameLogo.height * 3 , "Play!", clickSinglePlay);
		btnPlay.screenCenter(FlxAxes.X);
		btnPlay.setSize(80, 20);
		add(btnPlay);
		
		btnSettings = new FlxButton(0, btnPlay.y + btnPlay.height +  buttonGap, "Setting", runGame);
		btnSettings.screenCenter(FlxAxes.X);
		btnSettings.setSize(80, 20);
		add(btnSettings);
				
		this.changeGamePointer();
		
		//Cambiar esto por AssethPath
		FlxG.sound.playMusic("music/01_labyrinth.mp3", 0.2, true);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	private function clickSinglePlay():Void{
		FlxG.sound.play("sounds/LoadnShot.mp3", 0.5, false, null, true, runGame);		
	}
	
	private function clickSettings():Void {
		FlxG.switchState(new PlayerSelectState());
		//FlxG.switchState(new SettingState());
	}
	
	private function runGame():Void{
		FlxG.switchState(new PlayState());
	}

	
	private function changeGamePointer(){
		gamePointer = new Pointer();
		FlxG.mouse.visible = false;
		FlxG.mouse.hideSystemCursor();
		add(gamePointer);
	}
	
	
}
