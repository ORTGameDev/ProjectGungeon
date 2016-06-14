package gameObjects.pickups;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal
 */
class ShotgunPickup extends FlxSprite implements IPickable
{
	private var pickUpSound: FlxSound;

	public function new(aX:Float, aY:Float)
	{
		super(aX, aY);
		loadGraphic(Assets.getBitmapData("img/guns/shotgun/shot_pick.png"), false, 18, 9);
		//pickUpSound = FlxG.sound.load("sounds/healPickUp.mp3", 1, false);
		FlxTween.tween(this, { y:this.y + 5}, 0.50, { type: FlxTween.PINGPONG});

	}


	override public function kill():Void
	{
		//pickUpSound.play();
		alive = false;
		FlxTween.tween(this, { alpha: 0, y: y - 16 }, .40, { ease: FlxEase.bounceIn, onComplete: finishKill });
	}

	private function finishKill(_):Void
	{
		exists = false;
	}



	/* INTERFACE gameObjects.pickups.IPickable */

	public function pickUp():Void
	{
		allowCollisions = FlxObject.NONE;
		this.kill();
	}



}
