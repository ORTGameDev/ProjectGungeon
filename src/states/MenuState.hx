package states;
import flash.display.GraphicsPath;
import flash.display.SpreadMethod;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import gameObjects.Pointer;

/**
 * ...
 * @author Gastón // Nacho
 */
class MenuState extends FlxState
{

	//Cursor
	private var gamePointer:Pointer;
	
	//Texts
	private var txtGameTitle:FlxText;
	private var btnPlay: FlxButton;
	private var btnSettings: FlxButton;
	
	public function new()
	{
		super();
		
	}
	
	private function changeGamePointer(){
		gamePointer = new Pointer();
		FlxG.mouse.visible = false;
		FlxG.mouse.hideSystemCursor();
		add(gamePointer);
	}
	
	override public function create():Void
	{
		super.create();
		
		//Set Texts
		txtGameTitle = new FlxText(0, 30, 500, "<Replace with GameName (when u have one)>", 25);
		txtGameTitle.screenCenter(FlxAxes.X);
		add(txtGameTitle);
		
		//Set Button
		btnPlay = new FlxButton(0, 100, "Play!", clickSinglePlay);
		btnPlay.screenCenter(FlxAxes.X);
		add(btnPlay);
		
		btnSettings = new FlxButton(0, 150, "Setting", clickSettings);
		btnSettings.screenCenter(FlxAxes.X);
		add(btnSettings);
		this.changeGamePointer();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	private function clickSinglePlay():Void{
		FlxG.switchState(new PlayState(1, "Nacho´s Room"));
	}
	
	private function clickSettings():Void {
		FlxG.switchState(new PlayerSelectState());
		//FlxG.switchState(new SettingState());
	}
	
}