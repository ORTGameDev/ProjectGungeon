package gameObjects;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author Gastón Marichal
 */
class Pointer extends FlxSprite
{

	public function new()
	{
		super(0, 0);
		loadGraphic("pointer/crosshairBig.png");
		//makeGraphic(10, 10, FlxColor.PURPLE);
		FlxG.mouse.hideSystemCursor();
	}
	
	override public function update(elapsed:Float):Void{
		this.x = FlxG.mouse.x - 10;
		this.y = FlxG.mouse.y - 10;
		super.update(elapsed);
		
	}
	
}