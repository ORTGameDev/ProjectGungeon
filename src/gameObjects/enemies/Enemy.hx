package gameObjects.enemies;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import gameObjects.guns.Shotgun;
import gameObjects.enemies.DeadEnemy;
import gameObjects.guns.Gun;
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
	private var enemyChaseDistance:Int = 0; //Chase rate where enemy start moving to the player
	
	//Life
	private var enemyLife: Int = 0; //Enemy total life
	
	//Gun
	public	var enemyGun:Gun = null;
	private var enemyShootDistance:Int = 0; //Enemy atack rate 


	public function new(X:Float = 0, Y:Float = 0) 
	{
		super(X, Y);
	}
	
	override public function update (elapsed: Float):Void
	{
		super.update(elapsed);
		if (animation.curAnim.name == "x") {  // Si la animación actual es de muerte
			if (animation.curAnim.finished) { // Al finalizar la animación mato al enemy
				var deadEnemy = new DeadEnemy(this.x, this.y, "", 10, 10);
				FlxG.state.add(deadEnemy);
				kill();
			}
			return;
		}
		
		if (enemyGun != null) { //Actualizo posicion del arma
			enemyGun.x = this.x ;
			enemyGun.y = this.y + 7;
		}
		
		//Comienza captura del player
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
		if (enemyGun != null && length < enemyShootDistance)
		{
			enemyGun.shoot(x + width / 2, y + height / 2, player.x, player.y);
		}
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
						animation.play("left3");
						enemyGun.alpha = 1;
						enemyGun.animation.play("left");
					case FlxObject.RIGHT:
						animation.play("right3");
						enemyGun.alpha = 1;
						enemyGun.animation.play("right");
					case FlxObject.UP:
						animation.play("north3");
						enemyGun.alpha = 0;
						enemyGun.animation.play("north");
					case FlxObject.DOWN:
						animation.play("south3");
						enemyGun.alpha = 1;
						enemyGun.animation.play("south");
				}
			}else{ //Enemy without Gun
				switch (facing)
				{	
					case FlxObject.LEFT:
						animation.play("left3");
					case FlxObject.RIGHT:
						animation.play("right3");
					case FlxObject.UP:
						animation.play("north3");
					case FlxObject.DOWN:
						animation.play("south3");
				}
			}		
		}
		super.draw();
	}

	
	public function receiveDamage(damage:Int):Void
	{
		enemyLife -= damage;
		if (enemyLife <= 0)
		{
			velocity.set(0, 0);
			animation.play("x");
		}	
	}
	
	override public function kill():Void 
	{
		if (enemyGun != null){
			enemyGun.kill();
		}
		super.kill();
	}
	
}