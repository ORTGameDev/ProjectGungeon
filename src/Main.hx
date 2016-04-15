package;

import flash.display.Graphics;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import flixel.util.FlxColor;
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
		addChild(new FlxGame(900, 600, MenuState));
		
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
	}

}
