package gameObjects.enemies;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFrame;
import gameObjects.enemies.Enemy;
import gameObjects.guns.Shotgun;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal // Ignacio Benedetto
 */
class GreenOrc extends Enemy
{

	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		//Graphics
		var anAtlas = FlxAtlasFrames.fromTexturePackerJson("img/atlas/enemies/GreenOrc.png", "img/atlas/enemies/GreenOrc.json");
		frames = anAtlas;
		animation.addByPrefix("north", "GreenOrc_walk_up", 8, true);
		animation.addByPrefix("south", "GreenOrc_walk_down", 8, true);
		animation.addByPrefix("right", "GreenOrc_walk_right", 8, true);
		animation.addByPrefix("left", "GreenOrc_walk_left", 8, true);
		animation.addByPrefix("start", "GreenOrc_walk_down (1)", 8, false);
		animation.addByPrefix("die", "GreenOrc_die", 8, false);
		animation.play("start");
		setSize(28, 52);
		offset.set(18, 12);
		
		//Skills
		enemySpeed = 40;
		enemyChaseDistance = 600;
		enemyLife = 4;
		enemyTotalLife = enemyLife;
		enemyGun = new Shotgun(X, Y, GlobalGameData.enemiesBullets);
		enemyGun.infiniteBullets = true;
		
		enemyShootDistance = 600;
		drag.x = drag.y = 1500;
		maxVelocity.set(550, 400);
	}
	
	override public function update (elapsed: Float):Void
	{
		super.update(elapsed);
	}
	
	override private function shootToPlayer(aPlayerX:Float, aPlayerY:Float):Void
	{
		enemyGun.shoot(x + width / 2, y + height / 2, aPlayerX, aPlayerY);
	}
}