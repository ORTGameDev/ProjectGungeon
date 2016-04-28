package gameObjects;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal
 */
class Bullet extends FlxSprite
{
	
	public var bulletSpeed:Int;
	public var bulletDamage:Int;

	public function new(aBulletSpeed:Int, aBulletDamage:Int) 
	{
		super(0, 0);
		bulletSpeed = aBulletSpeed;
		bulletDamage = aBulletDamage;
		loadGraphic(Assets.getBitmapData("img/bullets/simpleBullet.png"), true, 11, 11);
		animation.add("idle", [0, 1, 2, 1, ], 20, true);
		alive = false;
		//offset.set(5, 5);
		animation.play("idle");
		
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