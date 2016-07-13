package gameObjects.enemies;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFrame;
import gameObjects.enemies.Enemy;
import gameObjects.guns.Wand;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal // Ignacion Benedetto
 */
class BossEnemy extends Enemy
{

	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		//Graphics
		/*var anAtlas = FlxAtlasFrames.fromTexturePackerJson("img/atlas/spritesheet.png", "img/atlas/spritemap.json");
		frames = anAtlas;
		animation.addByPrefix("north3", "north3_", 5, true);
		animation.addByPrefix("south3", "south3_", 5, true);
		animation.addByPrefix("right3", "side3_", 5, true);
		animation.addByPrefix("left3", "side3_", 5, true, true);
		animation.addByPrefix("diagDown3", "diagDown3_", 5, true);
		animation.addByPrefix("diagUp3", "diagUp3_", 5, true);
		animation.addByPrefix("start3", "start3", 5, false);
		animation.addByPrefix("x", "start3", 5, false, false, true);*/
		
		this.loadGraphic(Assets.getBitmapData("img/atlas/enemies/Boss.png"),true, 96,96);
		animation.add("start", [0], 1, true);
		animation.add("north", [9, 10, 11], 5, true);
		animation.add("south", [0, 1, 2], 5, true);
		animation.add("right", [6, 7, 8], 5, true);
		animation.add("left", [3, 4, 5], 5, true);
		animation.add("die", [1], 1, true);
		scale.set(2, 2);
		updateHitbox();
		//Skills
		enemySpeed = 40;
		enemyChaseDistance = 600;
		enemyLife = 25;
		enemyGun = new Wand(X, Y, GlobalGameData.enemiesBullets); 
		enemyShootDistance = 500;
		
		drag.x = drag.y = 1500;
		maxVelocity.set(550, 400);
		
		animation.play("start");
	}
	
	
	override public function update (elapsed: Float):Void
	{
		super.update(elapsed);
		
	}
	
}