package gameObjects;
import flixel.FlxSprite;
import openfl.Assets;


/**
 * ...
 * @author Gaston // Nacho
 */
class Exit extends FlxSprite
{

	public function new(X:Float = 0, Y:Float = 0) {
		super(X, Y);
		loadGraphic(Assets.getBitmapData("img/portal.png"), true, 64, 64);
		animation.add("active", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31], 12, true );
		animation.play("active");
		setSize(50, 50);
		offset.set(10, 12);
	}
	
}