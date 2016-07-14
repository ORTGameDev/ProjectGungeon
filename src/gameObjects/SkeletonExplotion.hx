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
class SkeletonExplotion extends FlxSprite
{
	private var expSound: FlxSound;

	public function new(aX:Float, aY:Float) 
	{
		super(aX, aY);
		expSound = FlxG.sound.load("sounds/barrelExplotion.mp3", 0.6);
		loadGraphic(Assets.getBitmapData("barrels/explosion_02.png"), true, 100, 100);
		animation.add("explode", [1,2,3,4,5,6,7,8,9,10], 25, false);
		FlxG.state.add(this);
		expSound.play();
		animation.play("explode");
		
	}
	
	override public function update (elapsed: Float):Void
	{
		super.update(elapsed);
		if (animation.finished)
		{
			kill();
		}
		if (this.overlaps(GlobalGameData.player) && this.alive && this.exists) {
			GlobalGameData.player.receiveDamage(1);
		}
		
	}
	
	
	
	override public function reset(X:Float, Y:Float):Void 
	{
		super.reset(X - width / 2, Y - width);
		expSound.play();
		animation.play("explode");
	}
	


}