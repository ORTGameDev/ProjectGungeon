package gameObjects.enemies;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFrame;
import gameObjects.enemies.Enemy;
import gameObjects.guns.Boltgun;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal
 */
class BossEnemy extends Enemy
{

	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		var anAtlas = FlxAtlasFrames.fromTexturePackerJson("img/atlas/spritesheet.png", "img/atlas/spritemap.json");
		frames = anAtlas;
		animation.addByPrefix("north3", "north3_", 5, true);
		animation.addByPrefix("south3", "south3_", 5, true);
		animation.addByPrefix("right3", "side3_", 5, true);
		animation.addByPrefix("left3", "side3_", 5, true, true);
		animation.addByPrefix("diagDown3", "diagDown3_", 5, true);
		animation.addByPrefix("diagUp3", "diagUp3_", 5, true);
		animation.addByPrefix("start3", "start3", 5, false);
		animation.addByPrefix("x", "start3", 5, false, false, true);
		animation.play("start3");
		enemyGun = new Boltgun(X, Y);
		drag.x = drag.y = 1500;
		enemySpeed = 30;
		enemyLife = 25;
		maxVelocity.set(550, 400);
		scale.set(3, 3);
		width = 30;
		height = 30;
		offset.set(5, 5);
	}
	
	
	override public function update (elapsed: Float):Void
	{
		super.update(elapsed);
	}
	
}