package gameObjects;
import flixel.FlxSprite;

/**
 * ...
 * @author Gastón Marichal
 */
class Bullet extends FlxSprite
{
	
	

	public function new() 
	{
		super(0, 0);
		makeGraphic(5, 5, FlxColor.RED);
		alive = false;
		
	}
	
	override public function reset(aX:Float, aY:Float):Void 
	{
		super.reset(aX, aY);
		velocity.x = 1000;
		
	}
	
}