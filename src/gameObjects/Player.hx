package gameObjects;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import gameObjects.Gun;
import openfl.Assets;

/**
 * ...
 * @author Gastón // Nacho
 */
class Player extends FlxSprite
{

	//Player
	public var playerCurrentLife:Int = 10;
	public var playerTotalLife:Int = 10;
	
	//Movement
	static private inline var playerAcceleration: Float = 150;
	static private inline var playerXMaxSpeed: Float = 250;
	static private inline var playerYMaxSpeed: Float = 200;
	static private inline var playerDrag: Int = 2500;
	
	//Gun
	public var playerGun:Gun;
			
	public function new(X:Float = 0, Y:Float = 0)
	{
		super(X, Y);
		drag.set(playerDrag, playerDrag);
		maxVelocity.set(playerXMaxSpeed, playerYMaxSpeed);
		//Cargo animaciones del player
		var anAtlas = FlxAtlasFrames.fromTexturePackerJson("img/atlas/spritesheet.png", "img/atlas/spritemap.json");
		this.frames = anAtlas;
		this.animation.addByPrefix("north1", "north1_", 10, true);
		this.animation.addByPrefix("south1", "south1_", 10, true);
		this.animation.addByPrefix("right1", "side1_", 10, true);
		this.animation.addByPrefix("left1", "side1_", 10, true, true);
		this.animation.addByPrefix("diagDown1_right", "diagdown1_", 10, true);
		this.animation.addByPrefix("diagUp1_right", "diagup1_", 10, true);
		this.animation.addByPrefix("diagDown1_left", "diagdown1_", 10, true, true);
		this.animation.addByPrefix("diagUp1_left", "diagup1_", 10, true, true);
		this.animation.addByPrefix("start1", "start1", 10, false);
		this.animation.play("start1");
		this.scale.set(2, 2);
		this.setSize(22, 42);
		this.offset.set(7, 0);
		
		//Creo gun y bullets
		var aBullets = new FlxTypedGroup<Bullet>();
		this.playerGun = new Gun(X, Y + this.height / 2, aBullets);
		
	}
		
	override public function update(elapsed:Float):Void 
	{
		this.acceleration.set();
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.A)
		{
			this.acceleration.x -= playerAcceleration;
		}
		if (FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.D)
		{
			this.acceleration.x += playerAcceleration;
		}
		if (FlxG.keys.pressed.DOWN || FlxG.keys.pressed.S)
		{
			this.acceleration.y += playerAcceleration;
		}
		if (FlxG.keys.pressed.UP || FlxG.keys.pressed.W)
		{
			this.acceleration.y -= playerAcceleration;
		}
		if (FlxG.keys.justPressed.SPACE || FlxG.mouse.justPressed)
		{
			playerGun.shoot(x + width /2 , y + height/2, FlxG.mouse.x, FlxG.mouse.y);
		}
		super.update(elapsed);
		playerGun.x = this.x + 7;
		playerGun.y = this.y + 16;
	}
	
	override public function draw():Void
	{
		var dX = FlxG.mouse.x - this.x;
		var dY = FlxG.mouse.y - this.y;
		var angle = Math.atan2(dY, dX) * 180 / Math.PI;
		if (angle < 0)
		{
		 angle += 360;
		}
		if (angle <= (0 + 20) || angle > (360 - 20)){
			animation.play("right1");
			playerGun.alpha = 1;
			playerGun.animation.play("right");
		} else if (angle  <=  (90 - 20) && angle > (0 + 20)){
			animation.play("diagDown1_right");
			playerGun.alpha = 1;
			playerGun.animation.play("diagDown_right");
		} else if (angle  <=  (90 + 20) && angle > (90 - 20)){
			animation.play("south1");
			playerGun.alpha = 1;
			playerGun.animation.play("south");
		} else if (angle <= (180 - 20) && angle > (90 + 20)){
			animation.play("diagDown1_left");
			playerGun.alpha = 1;
			playerGun.animation.play("diagDown_left");
			playerGun.x -= 7;
		} else if (angle <= (180 + 20) && angle > (180 - 20)){
			animation.play("left1");
			playerGun.alpha = 1;
			playerGun.animation.play("left");
			playerGun.x -= 7;
		} else if (angle <= (270 - 20) && angle > (180 + 20)){
			animation.play("diagUp1_left");
			playerGun.alpha = 0;
			playerGun.animation.play("diagUp_left");
			playerGun.x -= 7;
		} else if (angle <= (270 + 20) && angle > (270 - 20)){
			animation.play("north1");
			playerGun.alpha = 0;
			playerGun.animation.play("north");
		} else if (angle <= (360 - 20) && angle > (270 + 20)){
			animation.play("diagUp1_right");
			playerGun.alpha = 0;
			playerGun.animation.play("diagUp_right");
		}
		if(velocity.x == 0 && velocity.y == 0)
			animation.stop();
		super.draw();
	}

	public function receiveDamage(damage:Int):Void
	{
		playerCurrentLife -= damage;
		if (playerCurrentLife <= 0)
		{
			velocity.set(0, 0);
			animation.play("x");
		}	
	}
	
	
}