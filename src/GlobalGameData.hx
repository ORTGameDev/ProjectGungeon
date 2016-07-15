package;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import gameObjects.Explotion;
import gameObjects.enemies.Enemy;
import gameObjects.guns.bullets.Bullet;
import gameObjects.pickups.Pickup;
import gameObjects.players.Player;

/**
 * ...
 * @author Nacho/Gaston
 */

class GlobalGameData
{

	public static var aHud: HUD;

	public static var player: Player;

	public static var playerBullets: FlxTypedGroup<Bullet>;
	public static var enemies: FlxTypedGroup<Enemy>;

	public static var enemiesBullets: FlxTypedGroup<Bullet>;
	public static var pickups: FlxTypedGroup<Pickup>;

	public static var explotions: FlxTypedGroup<Explotion>;

	public static var levelNbr: Dynamic;
	
	public static function clear():Void
	{
		//player = null;
		playerBullets.clear();
		//player = null;
		enemies.clear();
		//enemies = null;
		enemiesBullets.clear();
		//enemiesBullets = null;
		pickups.clear();
		//pickups = null;
		explotions.clear();
		//explotions = null;
		//aHud.destroy();
		//aHud = null;

	}

}
