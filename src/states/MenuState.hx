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
		btnPlay = new FlxButton(0, gameLogo.y + gameLogo.height + buttonGap * 15, "Play!", clickSinglePlay);
		btnPlay.screenCenter(FlxAxes.X);
		add(btnPlay);
		
		btnSettings = new FlxButton(0, btnPlay.y + btnPlay.height +  buttonGap, "Setting", clickSettings);
		btnSettings.screenCenter(FlxAxes.X);
		add(btnSettings);
		this.changeGamePointer();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	private function clickSinglePlay():Void{
		FlxG.switchState(new PlayState());
	}
	
	private function clickSettings():Void {
		FlxG.switchState(new PlayerSelectState());
		//FlxG.switchState(new SettingState());
	}
	

	
	private function changeGamePointer(){
		gamePointer = new Pointer();
		FlxG.mouse.visible = false;
		FlxG.mouse.hideSystemCursor();
		add(gamePointer);
	}
	
	
}
