package gameObjects.pickups;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * @author Gastón Marichal // Ignacio Benedetto
 */
class Pickup extends FlxSprite
{
	private var pickUpSound: FlxSound;
	
	public function new(X:Float = 0, Y:Float = 0) {
		super(X, Y);
	}
	
	
	override public function update (elapsed: Float):Void {
		super.update(elapsed);
	}
	
	
	
	override public function kill():Void {
		pickUpSound.play();
		alive = false;
		FlxTween.tween(this, { alpha: 0, y: y - 16 }, .40, { ease: FlxEase.bounceIn, onComplete: finishKill });
	}
	
	private function finishKill(_):Void	{
		exists = false;
	}
	
	
	public function pickUp():Void {	}
	
	override public function reset(X:Float, Y:Float):Void {
		super.reset(X, Y);
		FlxTween.tween(this, { y:this.y + 5}, 0.50, { type: FlxTween.PINGPONG});
		FlxG.state.add(this);
	}
}