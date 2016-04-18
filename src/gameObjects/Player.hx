package gameObjects;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.Assets;

/**
 * ...
 * @author Gastón // Nacho
 */
class Player extends FlxSprite
{

	//Player
	public var playerLife:Int = 7;
	public var totalLife:Int = 8;
	
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
		this.updateHitbox();
		var aBullets = new FlxTypedGroup<Bullet>();
		playerGun = new Gun(X, Y, aBullets);
		
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
		drag.set(playerDrag, playerDrag);
		maxVelocity.set(playerXMaxSpeed, playerYMaxSpeed);
			
	}
		
	override public function update(elapsed:Float):Void 
	{
		acceleration.set();
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.A)
		{
			acceleration.x -= playerAcceleration;
		}
		if (FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.D)
		{
			acceleration.x += playerAcceleration;
		}
		if (FlxG.keys.pressed.DOWN || FlxG.keys.pressed.S)
		{
			acceleration.y += playerAcceleration;
		}
		if (FlxG.keys.pressed.UP || FlxG.keys.pressed.W)
		{
			acceleration.y -= playerAcceleration;
		}
		if (FlxG.keys.justPressed.SPACE || FlxG.mouse.justPressed)
		{
			playerGun.shoot(x + width, y + height/2);
		}
		super.update(elapsed);
		playerGun.x = this.x + 10;
		playerGun.y = this.y + (this.height / 2);
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
		} else if (angle  <=  (90 - 20) && angle > (0 + 20)){
			animation.play("diagDown1_right");
			playerGun.alpha = 1;
		} else if (angle  <=  (90 + 20) && angle > (90 - 20)){
			animation.play("south1");
			playerGun.alpha = 1;
		} else if (angle <= (180 - 20) && angle > (90 + 20)){
			animation.play("diagDown1_left");
			playerGun.alpha = 1;
		} else if (angle <= (180 + 20) && angle > (180 - 20)){
			animation.play("left1");
			playerGun.alpha = 1;
		} else if (angle <= (270 - 20) && angle > (180 + 20)){
			animation.play("diagUp1_left");
			playerGun.alpha = 0;
		} else if (angle <= (270 + 20) && angle > (270 - 20)){
			animation.play("north1");
			playerGun.alpha = 0;
		} else if (angle <= (360 - 20) && angle > (270 + 20)){
			animation.play("diagUp1_right");
			playerGun.alpha = 0;
		}
		if(velocity.x == 0 && velocity.y == 0)
			animation.stop();
		super.draw();
	}
	
	
	
}