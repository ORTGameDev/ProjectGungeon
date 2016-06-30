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
class ShotgunBullet extends Bullet
{
	
	public function new()
	{
		super();
		bulletSpeed =  200;
		bulletDamage = 2;
		loadGraphic(Assets.getBitmapData("img/bullets/Bullets001.png"), true, 11, 11);
		animation.add("idle", [0, 1, 2, 1, ], 20, true);
		animation.play("idle");
	}

	
	public function shootWithAngle(aOrX:Float, aOrY:Float, aTargetX:Float, aTargetY:Float, anAngle:Float)
	{
		this.reset(aOrX, aOrY);
		var dX:Float = aTargetX - aOrX;
		var dY:Float = aTargetY - aOrY;
		var length:Float = Math.sqrt(dX * dX + dY * dY);
		dX /= length;
		dY /= length;
		dX = dX * Math.cos(anAngle) - dY * Math.sin(anAngle);
		dY = dX * Math.sin(anAngle) + dY * Math.cos(anAngle);
		velocity.x = dX * bulletSpeed;
		velocity.y = dY * bulletSpeed;
	}
	
}
