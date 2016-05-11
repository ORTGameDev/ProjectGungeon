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
		var game = new FlxGame(800, 640, MenuState, 1, 60, 60, false, true);
		addChild(game);
		
		
		
	}
	
	
	
	

}
