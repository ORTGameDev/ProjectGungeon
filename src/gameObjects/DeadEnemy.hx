package gameObjects;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFrame;
import gameObjects.Enemy;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal
 */
class HunterEnemy extends FlxSprite
{

	public function new(X:Float, Y:Float, aBitmapData:String, aWidth:Int, aHeight:Int) 
	{
		
		super(X, Y);
		loadGraphic(Assets.getBitmapData(aBitmapData), false, aWidth, aHeight);
		velocity.set(0, 0);
		allowCollisions = FlxObject.NONE;
	}
	
	override public function update (elapsed: Float):Void
	{
		super.update(elapsed);
	}
	
}