package gameObjects.enemies;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import gameObjects.guns.Pistol;
import gameObjects.guns.Shotgun;
import gameObjects.guns.Gun;
import gameObjects.pickups.HealthPickup;
import gameObjects.pickups.Pickup;
import gameObjects.pickups.ShotgunPickup;
import openfl.Assets;
import openfl.Lib;
import openfl.utils.Timer;
import states.PlayState;


/**
 * ...
 * @author Gastón Marichal / Ignacio Benedetto
 */
class Enemy extends FlxSprite {
	/*******Enemy default config.***********/
	//Movement
	private var enemySpeed: Float = 0;
	private var enemyChaseDistance:Int = 0; //Chase rate, enemy start moving to the player
	private var enemyLife: Int = 0; //Enemy Current life
	private var enemyTotalLife: Int = 0; //Enemy total life
	public	var enemyGun:Gun = null;
	private var enemyShootDistance:Int = 0; //Enemy atack rate
	private var gunPerc = 0.15;
	private var healthPerc = 0.05;
	private var tweenDuration: Int = 2;

	
	
	public function new(X:Float = 0, Y:Float = 0) {
		super(X, Y);
	}

	override public function update (elapsed: Float):Void {
		super.update(elapsed);
		if (animation.curAnim.name == "die") {  // Si la animación actual es de muerte
			if (animation.curAnim.finished && this.alive) { // Al finalizar la animación mato al enemy
				alive = false;
				FlxTween.tween(this, {alpha: 0, color: FlxColor.BLACK}, tweenDuration, {onComplete:killEnemy, type:FlxTween.ONESHOT });
				//killEnemy();
			}
			return;
		}
		chasePlayer();
	}

	override public function draw():Void {
		if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE) {
			if (Math.abs(velocity.x) > Math.abs(velocity.y)) {
				if (velocity.x < 0)
					facing = FlxObject.LEFT;
				else
					facing = FlxObject.RIGHT;
			} else {
				if (velocity.y < 0)
					facing = FlxObject.UP;
				else
					facing = FlxObject.DOWN;
			}
			if (enemyGun != null) {
				switch (facing) {
					case FlxObject.LEFT:
						animation.play("left");
						enemyGun.alpha = 1;
						enemyGun.animation.play("left");
					case FlxObject.RIGHT:
						animation.play("right");
						enemyGun.alpha = 1;
						enemyGun.animation.play("right");
					case FlxObject.UP:
						animation.play("north");
						enemyGun.alpha = 0;
						enemyGun.animation.play("north");
					case FlxObject.DOWN:
						animation.play("south");
						enemyGun.alpha = 1;
						enemyGun.animation.play("south");
				}
			} else { //Enemy without Gun
				switch (facing) {
					case FlxObject.LEFT:
						animation.play("left");
					case FlxObject.RIGHT:
						animation.play("right");
					case FlxObject.UP:
						animation.play("north");
					case FlxObject.DOWN:
						animation.play("south");
				}
			}
		}
		if(animation.curAnim.name != "die" && velocity.x == 0 && velocity.y == 0) 
			animation.stop();
		super.draw();
	}

	private function chasePlayer():Void {
		if (GlobalGameData.player.alive) {
			var player = GlobalGameData.player;
			var dX:Float = player.x - x;
			var dY:Float = player.y - y;
			var length:Float = Math.sqrt(dX * dX + dY * dY);
			dX /= length;
			dY /= length;

			if (length < enemyChaseDistance) {
				velocity.x = dX * enemySpeed;
				velocity.y = dY * enemySpeed;
			}
			if (length < enemyShootDistance) { 
				shootToPlayer(player.x + player.width / 2, player.y + player.height / 2);
			}
		}
	}

	private function shootToPlayer(aPlayerX:Float, aPlayerY:Float):Void {
		//Each Enemy should redefine this!
		//enemyGun.shoot(x + width / 2, y + height / 2, player.x, player.y);
	}

	public function receiveDamage(damage:Int):Void {
		if (alive) {
			enemyLife -= damage;
			if (enemyLife <= 0) {
				velocity.set(0, 0);
				animation.play("die");
			}
		}

	}

	private function killEnemy(tween:FlxTween):Void {
		tween.cancel();
		if (enemyGun != null) {
			enemyGun.kill();
		}
		dropItem();
		kill();
	}
	
	private function dropItem():Void {
		var pickupProb = Math.random();
		if (pickupProb <= healthPerc) {
			var aPickup = PickupFactory.getPickup("health", this.x - 15, this.y - 5);
		} 
		if (pickupProb <= gunPerc) {
			var aPickup = PickupFactory.getPickup("shotgun", this.x + 15, this.y + 5);
		}
		
	}

}