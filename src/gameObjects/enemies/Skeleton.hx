package gameObjects.enemies;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFrame;
import flixel.util.FlxColor;
import gameObjects.enemies.Enemy;
import gameObjects.guns.Pistol;
import gameObjects.guns.Shotgun;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal // Ignacio Benedetto
 */
class Skeleton extends Enemy
{

	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		//Graphics
		var anAtlas = FlxAtlasFrames.fromTexturePackerJson("img/atlas/enemies/Skeleton.png", "img/atlas/enemies/Skeleton.json");
		frames = anAtlas;
		animation.addByPrefix("north", "skeleton_walk_up", 10, true);
		animation.addByPrefix("south", "skeleton_walk_down", 10, true);
		animation.addByPrefix("right", "skeleton_walk_right", 10, true);
		animation.addByPrefix("left",  "skeleton_walk_left", 10, true);
		animation.addByPrefix("start", "skeleton_walk_down (1)", 5, false);
		animation.addByPrefix("die", "skeleton_die", 5, false);
		animation.play("start");
		setSize(28, 52);
		offset.set(18, 12);
		
		//Skills
		enemySpeed = 100;
		enemyChaseDistance = 800;
		enemyLife = 1;
		enemyShootDistance = 0;
		drag.x = drag.y = 1500;
		maxVelocity.set(550, 400);
		
		
	}
	
	override public function update (elapsed: Float):Void
	{
		super.update(elapsed);
		if (this.overlaps(GlobalGameData.player) && this.alive && this.exists)
		{
			GlobalGameData.player.receiveDamage(1);
			this.kill();
		}
	}
	
	

}