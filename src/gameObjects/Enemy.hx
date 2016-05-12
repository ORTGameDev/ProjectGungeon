package gameObjects;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import gameObjects.Cannon;
import gameObjects.DeadEnemy;
import gameObjects.Gun;
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
	private var enemySpeed: Float = 100;
	private var enemyDrag: Int = 1500;
	//Generics
	private var enemyLife: Int = 6;
	private var enemyDamage: Int = 2;
	
	//Gun
	public var enemyGun:Gun;
	private var enemyShootDistance:Int = 600;

	//private var enemyLastShoot: Int = 0;

	private var enemyChaseDistance:Int = 200;

	public function new(X:Float = 0, Y:Float = 0) 
	{
		super(X, Y);
		drag.x = drag.y = enemyDrag;
		enemyGun= new Cannon(X, Y);
		frames = FlxAtlasFrames.fromTexturePackerJson("img/atlas/spritesheet.png", "img/atlas/spritemap.json");
		animation.addByPrefix("north3", "north3_", 10, true);
		animation.addByPrefix("south3", "south3_", 10, true);
		animation.addByPrefix("right3", "side3_", 10, true);
		animation.addByPrefix("left3", "side3_", 10, true, true);
		animation.addByPrefix("diagDown3", "diagDown3_", 10, true);
		animation.addByPrefix("diagUp3", "diagUp3_", 30, true);
		animation.addByPrefix("start3", "start3", 30, false);
		animation.addByPrefix("x", "start3", 30, false, false, true);
		animation.play("start3");
		width = 20;
		height = 20;
		offset.set(5, 5);
		
	}
	
	override public function update (elapsed: Float):Void
	{
		if (animation.curAnim.name == "x") // Si la animación actual es de muerte
		{
		super.update(elapsed);
		if (animation.curAnim.finished) // Al finalizar la animación mato al enemy
			{
				//Falta agregar el enemigo Dummy
				var deadEnemy = new DeadEnemy(this.x, this.y, "", 10, 10);
				FlxG.state.add(deadEnemy);
				this.enemyGun.kill();
				kill();
			}
			return;
		}
		super.update(elapsed);
		enemyGun.x = this.x ;
		enemyGun.y = this.y + 7;
		//Comienza captura del player
		var player = GlobalGameData.player;
		var dX:Float = player.x - x;
		var dY:Float = player.y - y;
		var length:Float = Math.sqrt(dX * dX + dY * dY); 
		dX /= length;
		dY /= length;
		if (length >= enemyChaseDistance)
		{
			velocity.x = dX * enemySpeed;
			velocity.y = dY * enemySpeed;
		}
		
		if (length <= enemyShootDistance)
		{
			//var currentTime = Lib.getTimer();
			//if (currentTime > enemyLastShoot + 2000)
			//{
				enemyGun.shoot(x + width / 2, y + height / 2, player.x, player.y);
				//enemyLastShoot = currentTime;
			//}
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
	
}