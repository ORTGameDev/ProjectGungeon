package gameObjects.enemies;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import gameObjects.guns.Shotgun;
import gameObjects.guns.Gun;
import gameObjects.pickups.PistolPickup;
import openfl.Assets;
import openfl.Lib;
import openfl.utils.Timer;
import states.PlayState;

/**
 * ...
 * @author Gastón Marichal / Ignacio Benedetto
 */
class Enemy extends FlxSprite
{
	/*******Enemy default config.***********/
	//Movement
	private var enemySpeed: Float = 0;
	private var enemyChaseDistance:Int = 0; //Chase rate, enemy start moving to the player
	private var enemyLife: Int = 0; //Enemy total life
	public	var enemyGun:Gun = null;
	private var enemyShootDistance:Int = 0; //Enemy atack rate


	public function new(X:Float = 0, Y:Float = 0)
	{
		super(X, Y);
	}

	override public function update (elapsed: Float):Void
	{
		super.update(elapsed);
		if (animation.curAnim.name == "die") {  // Si la animación actual es de muerte
			if (animation.curAnim.finished) { // Al finalizar la animación mato al enemy
				FlxTween.tween(this, {alpha: 0, color: FlxColor.BLACK},2, {onComplete:killEnemy });
				//kill();
			}
			return;
		}

		chasePlayer();

		/*if (enemyGun != null) { //Actualizo posicion del arma
			enemyGun.x = this.x ;
			enemyGun.y = this.y + 7;
		}*/


	}

	override public function draw():Void
	{
		if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE)
		{
			if (Math.abs(velocity.x) > Math.abs(velocity.y))
			{
				if (velocity.x < 0)
					facing = FlxObject.LEFT;
				else
					facing = FlxObject.RIGHT;
			}
			else
			{
				if (velocity.y < 0)
					facing = FlxObject.UP;
				else
					facing = FlxObject.DOWN;
			}
			if (enemyGun != null) {
				switch (facing)
				{
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
			}else{ //Enemy without Gun
				switch (facing)
				{
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
		super.draw();
	}


	private function chasePlayer():Void
	{
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
		if (length < enemyShootDistance)
		{
			shootToPlayer(player.x, player.y);
		}
	}

	private function shootToPlayer(aPlayerX:Float, aPlayerY:Float):Void
	{
		//Each Enemy should redefine this!
		//enemyGun.shoot(x + width / 2, y + height / 2, player.x, player.y);
	}

	public function receiveDamage(damage:Int):Void
	{
		if (alive) {
			enemyLife -= damage;
			if (enemyLife <= 0)
			{
				alive = false;
				velocity.set(0, 0);
				animation.play("die");
			}
		}

	}

	private function killEnemy(tween:FlxTween):Void
	{
		tween.cancel();
		if (enemyGun != null){
			enemyGun.kill();
		}
		var aPickup = PickupFactory.getPickup("pistol", 0, 0);
		aPickup.reset(this.x + this.width / 2, this.y + this.height);
		//var aPickup = GlobalGameData.pickups.recycle(FlxSprite);
		//aPickup.reset(this.x + this.width / 2, this.y + this.height);
		super.kill();
	}

}
