package gameObjects.pickups;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal
 */
class HealthPickUp extends FlxSprite
{
	public var lifeAmount: Int = 2;
	
	private var pickUpSound: FlxSound;

	public function new(aX:Float, aY:Float) 
	{
		super(aX, aY);
		loadGraphic(Assets.getBitmapData("img/life_full.png"), false, 32, 32);
		pickUpSound = FlxG.sound.load("sounds/healPickUp.mp3",1,false);
	}
	
	override public function kill():Void 
	{
		pickUpSound.play();
		super.kill();
	}
	
}