package gameObjects.enemies;
import flixel.FlxG;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup.FlxTypedGroup;
import gameObjects.enemies.Enemy;
import gameObjects.guns.Boltgun;
import openfl.Assets;
import openfl.Lib;

/**
 * ...
 * @author Gastón Marichal
 */
class SummonerEnemy extends Enemy
{

	private var lastSummonTime: Int = 0;
	private var minionsGroup: FlxTypedGroup<SkeletonEnemy>;
	
	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		minionsGroup = new FlxTypedGroup<SkeletonEnemy>();
		
		//Graphics
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
		scale.set(2, 2);
		width  = 30;
		height = 42;
		//Skills
		enemySpeed = 45;
		enemyChaseDistance = 400;
		enemyLife = 5;
		enemyGun = new Boltgun(X, Y);
		enemyShootDistance = 300;
		
		drag.x = drag.y = 1500;
		maxVelocity.set(550, 400);
		
	}
	
	
	override public function update (elapsed: Float):Void
	{
		super.update(elapsed);
		var currentTime = Lib.getTimer();
		if (currentTime > lastSummonTime + 5000)
		{
			summonSkeleton();
			lastSummonTime = currentTime;
		}
	}
	
	private function summonSkeleton():Void
	{
		//var s1 = minionsGroup.recycle(SkeletonEnemy, null, false, true);
		//s1.setPosition(this.x + this.y + 50);
		
		GlobalGameData.enemies.add(new SkeletonEnemy(this.x -50 , this.y));
		
		
	}
	
}