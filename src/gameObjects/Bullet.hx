package gameObjects;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author Gastón Marichal
 */
class Bullet extends FlxSprite
{
	
	var bulletSpeed:Int = 500;

	public function new() 
	{
		super(0, 0);
		makeGraphic(5, 5, FlxColor.RED);
		alive = false;
		
		
	}
	
	override public function reset(aX:Float, aY:Float):Void 
	{
		super.reset(aX, aY);
		
		var dX:Float = FlxG.mouse.x - aX;
		var dY:Float = FlxG.mouse.y - aY;
		var length:Float = Math.sqrt(dX * dX + dY * dY); 
		dX /= length;
		dY /= length;
		velocity.x = dX * bulletSpeed;
		velocity.y = dY * bulletSpeed;
		
		
	}
	
}