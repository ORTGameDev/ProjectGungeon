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
class BoltBullet extends Bullet
{
	
	public function new() {
		super();
		bulletSpeed =  180;
		bulletDamage = 3;
		loadGraphic(Assets.getBitmapData("img/bullets/Bullets003.png"), true, 25, 25);
		animation.add("idle", [0, 1, 2, 1, ], 20, true);
		animation.play("idle");
		offset.set(3, 3);
		setSize(18, 18);
	}

}
