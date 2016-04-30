package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import gameObjects.Pointer;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal
 */
class PlayerSelectState extends FlxState
{
	
	//Cursor
	private var gamePointer:Pointer;

	private var txtTitle: FlxText;
	private var btnPlay: FlxButton;
	private var btnBack: FlxButton;
	
	private var characterOne: FlxButton;
	private var characterTwo: FlxButton;
	
	
	
	public function new() 
	{
		super();
	}
	
	override public function create():Void
	{
		super.create();
		this.changeGamePointer();
		
		characterOne = new FlxButton(250, 250, "Naevia", selectedOne);
		//characterOne.label.addFormat(new FlxTextFormat(FlxColor.GREEN, true, false, FlxColor.ORANGE));
		//characterOne.label.font = "Sans";
		characterOne.label.setPosition(100, 0);
		characterOne.scale.x = characterOne.scale.y = 3;
		//characterOne.loadGraphic(Assets.getBitmapData("img/characters/side1.png"), true, 20, 24);
		characterOne.animation.add("side", [0, 1, 2, 3], 5, true);
		characterOne.statusAnimations = ["normal", "side", "pressed"];
		add(characterOne);
		
		characterTwo = new FlxButton(500, 250, "Krixo", selectedOne);
		characterTwo.setSize(200, 200);
		characterTwo.loadGraphic(Assets.getBitmapData("img/characters/side2.png"), true, 20, 24);
		characterTwo.animation.add("side", [0, 1, 2, 3], 5, true);
		characterTwo.statusAnimations = ["normal", "side", "pressed"];
		
		add(characterTwo);
		
		txtTitle = new FlxText(0, 50, 500, "Select your character...", 24);
		txtTitle.screenCenter(FlxAxes.X);
		add(txtTitle);
		
		btnPlay = new FlxButton(800, 500, "Play!!", playGame);
		add(btnPlay);
		
		btnBack = new FlxButton(80, 500, "Back to Menu", BackToMenu);
		add(btnBack);
		
		
	}
	
	override public function update(elapsed:Float):Void
	{
		
		super.update(elapsed);
	
	}
	
	
	
	private function playGame():Void
	{
		FlxG.switchState(new PlayState());
	}
	
	private function BackToMenu():Void
	{
		FlxG.switchState(new MenuState());
	}
	
	private function selectedOne():Void
	{
		return;
	}
	
	private function changeGamePointer()
	{
		gamePointer = new Pointer();
		FlxG.mouse.visible = false;
		FlxG.mouse.hideSystemCursor();
		add(gamePointer);
	}
	
}