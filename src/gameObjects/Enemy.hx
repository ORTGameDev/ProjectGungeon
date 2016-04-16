package gameObjects;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal / Ignacio Benedetto
 */
class Enemy extends FlxSprite
{
	
	//Movement
	static private inline var enemySpeed: Float = 100;
	static private inline var enemyXMaxSpeed: Float = 500;
	static private inline var enemyYMaxSpeed: Float = 300;
	static private inline var enemyDrag: Int = 1000;
	
	
	//Generics
	private var life: Int = 3;
	private var dead: Bool = false;

	public function new(X:Float = 0, Y:Float = 0, aWidth:Float, aHeight:Float, aXOffset:Float, aYOffset:Float, aBitmapData:String) 
	{
		super(X, Y);
		loadGraphic(Assets.getBitmapData(aBitmapData), true, 55, 70);
		animation.add("d", [0]);
		animation.add("l", [1]);
		animation.add("u", [2]);
		animation.add("r", [3]);
		animation.add("x", [4, 5, 6, 7, 7, 7, 7], 7, false);
		animation.play("d");
		
		drag.x = drag.y = enemyDrag;
		maxVelocity.set(enemyXMaxSpeed, enemyYMaxSpeed);
		width = aWidth;
		height = aHeight;
		offset.set(aXOffset, aYOffset);
		
	}
	
	
	override public function update (elapsed: Float):Void
	{
		if (animation.curAnim.name == "x") // Si la animación actual es de muerte
		{
			super.update(elapsed);
			if (animation.curAnim.finished) // Al finalizar la animación mato al enemy
			{
				//Falta agregar el enemigo Dummy
				kill();
			}
			return;
		}
		super.update(elapsed);
		//Comienza captura del player
		var player = GlobalGameData.player;
		var dX:Float = player.x - x;
		var dY:Float = player.y - y;
		var length:Float = Math.sqrt(dX * dX + dY * dY); 
		
		dX /= length;
		dY /= length;
		velocity.x = dX * enemySpeed;
		velocity.y = dY * enemySpeed;
		
	}
	
	public function damage(aDamage:Int) 
	{
		if (life <= 0){
			animation.play("x");
			velocity.set(0, 0);
			allowCollisions = FlxObject.NONE;	//Deja de colisionar contra CUALQUIER objeto
		}
		else
		{
			life -= aDamage;
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
					animation.play("l");
				
				case FlxObject.RIGHT:
					animation.play("r");
					
				case FlxObject.UP:
					animation.play("u");
					
				case FlxObject.DOWN:
					animation.play("d");
				
			}
			
		}
		super.draw();
	}
	
}