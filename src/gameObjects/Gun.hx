package gameObjects;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author Gastón // Nacho
 */

 
class Gun extends FlxSprite
{
	
	private var damage:	Int = 0;
	private var delay:	Int = 0;
	

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(10, 5, FlxColor.BLUE);
	}
	
}