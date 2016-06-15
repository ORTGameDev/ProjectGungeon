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
 * @author Ignacio Benedetto
 */
class PistolPickup extends Pickup
{
	
	public function new(aX:Float, aY:Float)
	{
		super(aX, aY);
		loadGraphic(Assets.getBitmapData("img/guns/pistol/p_pick.png"), false, 18, 9);
		pickUpSound = FlxG.sound.load("sounds/healPickUp.mp3", 1, false);
		

	}


	
	override public function pickUp():Void
	{
		allowCollisions = FlxObject.NONE;
		this.kill();
	}



}
