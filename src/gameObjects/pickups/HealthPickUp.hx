package gameObjects.pickups;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal
 */
class HealthPickUp extends FlxSprite implements IPickable
{
	public var lifeAmount: Int = 2;
	
	private var pickUpSound: FlxSound;

	public function new(aX:Float, aY:Float) 
	{
		super(aX, aY);
		loadGraphic(Assets.getBitmapData("img/sprite_0.png"), false, 32, 32);
		pickUpSound = FlxG.sound.load("sounds/healPickUp.mp3", 1, false);
		FlxTween.tween(this, { y:this.y + 5}, 0.50, { type: FlxTween.PINGPONG});
	}
	
	
	override public function kill():Void
	{
		pickUpSound.play();
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
		if (!GlobalGameData.player.fullHealth())
		{
			GlobalGameData.player.healPlayer(lifeAmount);
			this.kill();
		}
		
	}

	
	
}