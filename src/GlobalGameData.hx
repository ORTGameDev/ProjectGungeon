package;
import flixel.group.FlxGroup.FlxTypedGroup;
import gameObjects.Bullet;
import gameObjects.Player;

/**
 * ...
 * @author Nacho/Gaston
 */

class GlobalGameData
{

	public static var player: Player;
	
	public static var enemiesBullets: FlxTypedGroup<Bullet>;
	
	public static function clear():Void 
	{
		player = null;
	}
	
}