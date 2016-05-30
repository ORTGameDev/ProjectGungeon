package gameObjects.guns;
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
	private static inline var bulletLifeTime: Int = 4000;
	private var bulletStartTime:Int = 0;
	
	//Target Coords.
	private var targetX:Float;
	private var targetY:Float;
	
	

	public function new(aBulletSpeed:Int, aBulletDamage:Int) 
	{
		super(0, 0);
		bulletSpeed = aBulletSpeed;
		bulletDamage = aBulletDamage;
		alive = false;
	}
	
	override public function update (elapsed: Float):Void
	{
		super.update(elapsed);
		if ((Lib.getTimer() - bulletStartTime) > bulletLifeTime) { // Si pasan mas de 4 seg. Mato la bala.
			this.kill();
		}
	}
	public function shoot(aOrX:Float, aOrY:Float, aTargetX:Float, aTargetY:Float, bType:Int)
	{
		this.reset(aOrX, aOrY);
		switch bType
		{
			case 1: loadGraphic(Assets.getBitmapData("img/bullets/Bullets001.png"), true, 11, 11);
					animation.add("idle", [0, 1, 2, 1, ], 20, true);
					animation.play("idle");
			case 2: loadGraphic(Assets.getBitmapData("img/bullets/Bullets002.png"), true, 11, 11);
					animation.add("idle", [0, 1, 2, 1, ], 20, true);
					animation.play("idle");
			case 3: loadGraphic(Assets.getBitmapData("img/bullets/Bullets003.png"), true, 25, 25);
					animation.add("idle", [0, 1, 2, 1, ], 20, true);
					animation.play("idle");
			default: loadGraphic(Assets.getBitmapData("img/bullets/Bullets001.png"), true, 11, 11);
					animation.add("idle", [0, 1, 2, 1, ], 20, true);
					animation.play("idle");
		}
		bulletStartTime = Lib.getTimer();
		var dX:Float = aTargetX - aOrX;
		var dY:Float = aTargetY - aOrY;
		var length:Float = Math.sqrt(dX * dX + dY * dY); 
		dX /= length;
		dY /= length;
		velocity.x = dX * bulletSpeed;
		velocity.y = dY * bulletSpeed;
	}
		
	override public function reset(aX:Float, aY:Float):Void 
	{
		super.reset(aX, aY);
	}
	
	
	
}