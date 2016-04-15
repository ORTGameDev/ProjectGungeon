package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;

/**
 * ...
 * @author Gastón Marichal
 */
class PlayerSelectState extends FlxState
{

	private var txtTitle: FlxText;
	private var btnPlay: FlxButton;
	private var btnBack: FlxButton;
	
	
	
	public function new() 
	{
		super();
	}
	
	override public function update(elapsed:Float):Void
	{
		txtTitle = new FlxText(0, 50, 500, "Select your character...", 24);
		txtTitle.screenCenter(FlxAxes.X);
		add(txtTitle);
		
		btnPlay = new FlxButton(800, 500, "Play!!", playGame);
		add(btnPlay);
		
		btnBack = new FlxButton(80, 500, "Back to Menu", BackToMenu);
		add(btnBack);
		
		//btnPlay.screenCenter(FlxAxes.X);
		
		//btnBack.screenCenter(FlxAxes.X);
		
		super.update(elapsed);
	
	}
	
	private function playGame():Void
	{
		FlxG.switchState(new PlayState(1, "Nacho´s Room"));
	}
	
	private function BackToMenu():Void
	{
		FlxG.switchState(new MenuState());
	}
	
}