package gameObjects.guns.bullets;
import flash.desktop.Clipboard;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import openfl.Assets;
import openfl.Lib;

/**
 * ...
 * @author Gastón Marichal
 */
class Bullet extends FlxSprite
{
	//Bullet Props.
	public 	var bulletSpeed:Int;
	public 	var bulletDamage:Int;
	private static inline var bulletLifeTime: Int = 3000;
	private var bulletStartTime:Int;

	//Target Coords.
	private var targetX:Float;
	private var targetY:Float;



	public function new() {
		super(0, 0);
		bulletStartTime = Lib.getTimer();
	}

	override public function update (elapsed: Float):Void {
		super.update(elapsed);
		if (bulletStartTime + bulletLifeTime < Lib.getTimer()) {
			this.kill();
		}
	}
	
	public function shoot(aOrX:Float, aOrY:Float, aTargetX:Float, aTargetY:Float):Void {
		this.reset(aOrX, aOrY);
		var dX:Float = aTargetX - aOrX;
		var dY:Float = aTargetY - aOrY;
		var length:Float = Math.sqrt(dX * dX + dY * dY);
		dX /= length;
		dY /= length;
		velocity.x = dX * bulletSpeed;
		velocity.y = dY * bulletSpeed;
	}

	override public function reset(aX:Float, aY:Float):Void {
		super.reset(aX, aY);
		bulletStartTime = Lib.getTimer();
		animation.play("idle");
	}

}
