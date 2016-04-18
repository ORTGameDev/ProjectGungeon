package gameObjects;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxColor;
import openfl.Assets;

/**
 * ...
 * @author Gastón Marichal / Ignacio Benedetto
 */
class Enemy extends FlxSprite
{
	
	//Movement  
	private  var enemySpeed: Float = 100;
	
	/*static private inline var enemyXMaxSpeed: Float = 500;
	
	static private inline var enemyYMaxSpeed: Float = 300;
	static private inline var enemyDrag: Int = 1000;
	//Image properties
	static private inline var enemyWidth: Float = 20;
	static private inline var enemyHeight: Float = 20;
	static private inline var enemyXOffset: Float = 5;
	static private inline var enemyYOffset: Float = 5;
	*/
	
	//Generics
	private var enemyLife: Int = 3;
	private var enemyDamage: Int = 2;
	private var EnemyIsdead: Bool = false;
	

	public function new(X:Float = 0, Y:Float = 0) 
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
		animation.play("start3");
		drag.x = drag.y = 1500;
		maxVelocity.set(500, 300);
		width = 20;
		height = 20;
		offset.set(5, 5);
	}
	
	
	override public function update (elapsed: Float):Void
	{
		//if (animation.curAnim.name == "x") // Si la animación actual es de muerte
		//{
			//super.update(elapsed);
			//if (animation.curAnim.finished) // Al finalizar la animación mato al enemy
			//{
				////Falta agregar el enemigo Dummy
				//kill();
			//}
			//return;
		//}
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
		if (enemyLife <= 0){
			animation.play("x");
			velocity.set(0, 0);
			allowCollisions = FlxObject.NONE;	//Deja de colisionar contra CUALQUIER objeto
		}
		else
		{
			enemyLife -= aDamage;
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
				
				case FlxObject.RIGHT:
					animation.play("right3");
					
				case FlxObject.UP:
					animation.play("north3");
					
				case FlxObject.DOWN:
					animation.play("south3");
				
			}
			
		}
		super.draw();
	}
	
}