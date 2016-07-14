package gameObjects;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import openfl.Assets;
import openfl.Lib;

/**
 * ...
 * @author Gastón Marichal
 */
class Barrel extends FlxSprite 
{
	
	public function new(aX:Float, aY:Float) 
	{
		super(aX, aY);
		loadGraphic(Assets.getBitmapData("barrels/Barrel.png"), true, 19, 25);
		allowCollisions = FlxObject.ANY;
		immovable = true;
		FlxG.state.add(this);
	}
	
	override public function update (elapsed: Float):Void
	{
		super.update(elapsed);
	}
	
	public function eBreak(): Void
	{
		var aExplotion = GlobalGameData.explotions.recycle(Explotion);
		aExplotion.reset(this.x + this.width / 2, this.y + this.height);
		this.kill();
	}
	
}