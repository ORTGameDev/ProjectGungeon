package menus;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.ui.FlxButtonPlus;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import openfl.system.System;
import states.PlayState;


/**
 * ...
 * @author Gastón Marichal
 */
class MainMenu extends FlxGroup
{
	//Buttons	
	private var btnPlay: FlxButton;
	private var btnQuit: FlxButton;
	//Background
	private var backGround: FlxSprite;
	private static inline var backGroundWidth: 	Int = 450;
	private static inline var backGroundHeigth: Int = 400;
	//General
	private static inline var buttonGap: Int = 10;

	

	public function new() {
		super();
		//Set BackGround
		backGround = new FlxSprite(0,250);
		backGround.makeGraphic(backGroundWidth, backGroundHeigth, FlxColor.fromRGB(64, 64, 64, 200));
		backGround.screenCenter(FlxAxes.X);
		add(backGround);
		//Set Button
		btnPlay = new FlxButton(0, backGround.y + buttonGap, "Play!", clickSinglePlay);
		btnPlay.screenCenter(FlxAxes.X);
		add(btnPlay);
		
		btnQuit = new FlxButton(0, btnPlay.y + btnPlay.height +  buttonGap, "Quit game", quitGame);
		btnQuit.screenCenter(FlxAxes.X);
		btnQuit.setSize(80, 30);
		add(btnQuit);
		
	}
	
	
	private function clickSinglePlay():Void {
		FlxG.sound.play("sounds/LoadnShot.mp3", 0.5, false, null, true, runGame );		
	}
	
	private function runGame():Void	{
		FlxG.switchState(new PlayState(3));
	}
	
	private function quitGame():Void {
		System.exit(0);
	}
}