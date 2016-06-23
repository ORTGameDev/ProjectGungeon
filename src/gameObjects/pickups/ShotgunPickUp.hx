package gameObjects.pickups;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import gameObjects.guns.Shotgun;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal
 */
class ShotgunPickup extends Pickup
{

	public function new(aX:Float, aY:Float)
	{
		super(aX, aY);
		loadGraphic(Assets.getBitmapData("img/guns/shotgun/shot_pick.png"), false, 76, 27);
		pickUpSound = FlxG.sound.load("sounds/healPickUp.mp3", 1, false);
		

	}



	override public function pickUp():Void
	{
		allowCollisions = FlxObject.NONE;
		GlobalGameData.player.pickWeapon(shotgun);
		this.kill();
	}



}
