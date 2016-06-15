package;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import gameObjects.BarrelExplotion;
import gameObjects.enemies.Enemy;
import gameObjects.guns.Bullet;
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

	public static var explotions: FlxTypedGroup<BarrelExplotion>;


	public static function clear():Void
	{
		player = null;
		playerBullets.destroy();
		player = null;
		enemies.destroy();
		enemies = null;
		enemiesBullets.destroy();
		enemiesBullets = null;
		pickups.destroy();
		pickups = null;
		explotions.destroy();
		explotions = null;
		aHud.destroy();
		aHud = null;

	}

}
