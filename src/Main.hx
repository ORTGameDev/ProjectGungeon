package;

import flash.display.Graphics;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.Lib;
import states.MenuState;

/**
 * ...
 * @author Gastón Marichal
 */
class Main extends Sprite 
{

	public function new() 
	{
		super();
		addChild(new FlxGame(900, 600, MenuState, 1, 60, 60, false, true));
		
		//Cambiar esto por AssethPath
		FlxG.sound.playMusic("music/01_labyrinth.mp3", 0.2, true);
		
	}
	
	
	
	

}
