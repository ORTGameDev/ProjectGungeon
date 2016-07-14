package gameObjects.enemies;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFrame;
import flixel.util.FlxColor;
import gameObjects.SkeletonExplotion;
import gameObjects.enemies.Enemy;
import gameObjects.guns.Pistol;
import gameObjects.guns.Shotgun;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal // Ignacio Benedetto
 */
class Skeleton extends Enemy {

	public function new(X:Float, Y:Float) {
		super(X, Y);
		//Graphics
		var anAtlas = FlxAtlasFrames.fromTexturePackerJson("img/atlas/enemies/Skeleton.png", "img/atlas/enemies/Skeleton.json");
		frames = anAtlas;
		animation.addByPrefix("north", "skeleton_walk_up", 10, true);
		animation.addByPrefix("south", "skeleton_walk_down", 10, true);
		animation.addByPrefix("right", "skeleton_walk_right", 10, true);
		animation.addByPrefix("left",  "skeleton_walk_left", 10, true);
		animation.addByPrefix("start", "skeleton_walk_down (1)", 5, false);
		animation.addByPrefix("die", "skeleton_die", 10, false);
		animation.play("start");
		setSize(28, 52);
		offset.set(18, 12);
		
		//Skills
		enemySpeed = 100;
		enemyChaseDistance = 500;
		enemyLife = 2;
		enemyTotalLife = enemyLife;
		enemyShootDistance = 0;
		drag.x = drag.y = 1500;
		maxVelocity.set(550, 400);
		tweenDuration = 1;
		
	}
	
	override public function update (elapsed: Float):Void {
		super.update(elapsed);
		if (this.overlaps(GlobalGameData.player) && this.alive && this.exists) {
			this.kill();
		}
	}
	
	override private function shootToPlayer(aPlayerX:Float, aPlayerY):Void {
		return;
	}
	
	private function explode():Void {
		var exp = new SkeletonExplotion(this.x - this.width / 2, this.y - this.height / 2);
	}
	
	override public function kill() {
		explode();
		super.kill();
		
	}

}