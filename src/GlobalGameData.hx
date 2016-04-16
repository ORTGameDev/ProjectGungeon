package;
import gameObjects.Player;

/**
 * ...
 * @author Nacho/Gaston
 */

class GlobalGameData
{

	public static var player: Player;
	
	public static function clear():Void 
	{
		player = null;
	}
	
}