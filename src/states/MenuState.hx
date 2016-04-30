package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
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
	
	//Texts
	private var txtGameTitle:FlxText;
	private var btnPlay: FlxButton;
	private var btnSettings: FlxButton;
	

	public function new()
	{
		super();
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
