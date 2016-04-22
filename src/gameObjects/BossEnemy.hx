package gameObjects;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFrame;
import gameObjects.Enemy;
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
		animation.addByPrefix("north3", "north3_", 10, true);
		animation.addByPrefix("south3", "south3_", 10, true);
		animation.addByPrefix("right3", "side3_", 10, true);
		animation.addByPrefix("left3", "side3_", 10, true, true);
		animation.addByPrefix("diagDown3", "diagDown3_", 10, true);
		animation.addByPrefix("diagUp3", "diagUp3_", 30, true);
		animation.addByPrefix("start3", "start3", 30, false);
		animation.addByPrefix("x", "start3", 30, false, false, true);
		animation.play("start3");
		drag.x = drag.y = 1500;
		enemySpeed = 20;
		enemyDamage = 5;
		enemyLife = 25;
		maxVelocity.set(500, 300);
		width = 20;
		height = 20;
		offset.set(5, 5);
	}
	
	
	override public function update (elapsed: Float):Void
	{
		super.update(elapsed);
	}
	
}