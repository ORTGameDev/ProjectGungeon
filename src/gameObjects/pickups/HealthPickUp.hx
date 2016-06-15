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
class HealthPickup extends Pickup
{
	public var lifeAmount: Int = 2;
	
	
	public function new(aX:Float, aY:Float) 
	{
		super(aX, aY);
		loadGraphic(Assets.getBitmapData("img/sprite_0.png"), false, 32, 32);
		pickUpSound = FlxG.sound.load("sounds/healPickUp.mp3", 1, false);
		
	}
	
	override public function pickUp():Void 
	{
		if (!GlobalGameData.player.fullHealth())
		{
			allowCollisions = FlxObject.NONE;
			GlobalGameData.player.healPlayer(lifeAmount);
			this.kill();
		}
		
	}

	
	
}