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
class PistolBullet extends Bullet
{
	
	public function new()
	{
		super();
		bulletSpeed =  300;
		bulletDamage = 1;
		loadGraphic(Assets.getBitmapData("img/bullets/Bullets002.png"), true, 11, 11);
		animation.add("idle", [0, 1, 2, 1, ], 20, true);
		animation.play("idle");
	}

	override public function update (elapsed: Float):Void
	{
		super.update(elapsed);
	}
}
