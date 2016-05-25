package;
import flixel.effects.particles.FlxParticle;
import flixel.group.FlxGroup.FlxTypedGroup;
import gameObjects.enemies.Enemy;
import gameObjects.pickups.HealthPickUp;


import gameObjects.guns.Bullet;
import gameObjects.players.Player;

/**
 * ...
 * @author Nacho/Gaston
 */

class GlobalGameData
{
	
	public static var aHud: HUD;

	public static var player: Player;
	
	public static var enemies: FlxTypedGroup<Enemy>;
	
	public static var enemiesBullets: FlxTypedGroup<Bullet>;
	public static var healthspick: FlxTypedGroup<HealthPickUp>;
	
	public static var particles: FlxTypedGroup<FlxParticle>;
	
	public static function clear():Void 
	{
		player = null;
		enemies.destroy();
		enemies = null;
		enemiesBullets.destroy();
		enemiesBullets = null;
		healthspick.destroy();
		healthspick = null;
		particles.destroy();
		particles = null;
		aHud.destroy();
		aHud = null;
	}
	
}