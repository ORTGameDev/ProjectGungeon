package gameObjects;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import gameObjects.enemies.Enemy;
import gameObjects.players.Player;
import openfl.Assets;
import openfl.Lib;

/**
 * ...
 * @author Gastón Marichal
 */
class Explotion extends FlxSprite
{
	public  var expDamage: Int = 2;
	private var expSound: FlxSound;

	public function new(aX:Float, aY:Float) 
	{
		super(aX, aY);
		expSound = FlxG.sound.load("sounds/barrelExplotion.mp3", 0.6);
		loadGraphic(Assets.getBitmapData("barrels/explosion_01.png"), true, 52, 65);
		animation.add("explode", [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 25, false);
		FlxG.state.add(this);
		
	}
	
	override public function update (elapsed: Float):Void
	{
		if (animation.finished)
		{
			kill();
		}
		super.update(elapsed);
	}
	
	
	
	override public function reset(X:Float, Y:Float):Void 
	{
		super.reset(X - width / 2, Y - width);
		expSound.play();
		animation.play("explode");
	}
	


}