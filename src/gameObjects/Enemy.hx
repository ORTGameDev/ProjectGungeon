package gameObjects;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal
 */
class Enemy extends FlxSprite
{
	
	//Movement
	static private inline var EnemyAcceleration: Float = 800;
	static private inline var EnemyXMaxSpeed: Float = 500;
	static private inline var EnemyYMaxSpeed: Float = 300;
	static private inline var EnemyDrag: Int = 1000;

	public function new(X:Float = 0, Y:Float = 0) 
	{
		super(X, Y);
		loadGraphic(Assets.getBitmapData("characters/start3.png"), false, 20, 24);
		
	}
	
}