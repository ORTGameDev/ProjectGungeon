package gameObjects.enemies;
import flixel.FlxG;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup.FlxTypedGroup;
import gameObjects.enemies.Enemy;
import gameObjects.guns.Wand;
import openfl.Assets;
import openfl.Lib;

/**
 * ...
 * @author Gastón Marichal
 */
class Summoner extends Enemy
{

	private var lastSummonTime: Int = 0;
	private var minionsGroup: FlxTypedGroup<Skeleton>;
	
	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		minionsGroup = new FlxTypedGroup<Skeleton>();
		
		//Graphics
		var anAtlas = FlxAtlasFrames.fromTexturePackerJson("img/atlas/enemies/Summoner.png", "img/atlas/enemies/Summoner.json");
		frames = anAtlas;
		animation.addByPrefix("north", "Summoner_walk_up", 8, true);
		animation.addByPrefix("south", "Summoner_walk_down", 8, true);
		animation.addByPrefix("right", "Summoner_walk_right", 8, true);
		animation.addByPrefix("left", "Summoner_walk_left", 8, true);
		animation.addByPrefix("start", "Summoner_walk_down (1)", 5, false);
		animation.addByPrefix("die", "Summoner_die", 5, false);
		animation.play("start");
		setSize(28, 52);
		offset.set(18, 12);
		//Skills
		enemySpeed = 45;
		enemyChaseDistance = 400;
		enemyLife = 5;
		enemyGun = new Wand(X, Y);
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
		
		GlobalGameData.enemies.add(new Skeleton(this.x -50 , this.y));
		
		
	}
	
}