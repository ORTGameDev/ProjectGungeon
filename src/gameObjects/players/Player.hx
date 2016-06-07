package gameObjects.players;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import gameObjects.guns.Bullet;
import gameObjects.guns.Gun;
import gameObjects.guns.Pistol;
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
	
	//Hurt
	public var isHurt:Bool = false;
	

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
		/********************************
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
		this.animation.addByPrefix("x", "start1", 30, false, false, true);
		this.animation.play("start1");
		this.scale.set(2, 2);
		this.setSize(22, 42);
		this.offset.set(7, 0);
        *************************************/
		
		var anAtlas = FlxAtlasFrames.fromTexturePackerJson("img/atlas/players/PlayerOne.png", "img/atlas/players/PlayerOne.json");
		this.frames = anAtlas;
		this.animation.addByPrefix("north", "playerOne_walk_up", 8, true);
		this.animation.addByPrefix("south", "playerOne_walk_down", 8, true);
		this.animation.addByPrefix("right", "playerOne_walk_right", 8, true);
		this.animation.addByPrefix("left", "playerOne_walk_left", 8, true);
		this.animation.addByPrefix("die", "playerOne_die", 5, false);
		this.animation.addByPrefix("start", "playerOne_walk_down (1)", 1, false, false, true);
		this.animation.play("start");
		this.setSize(28, 52);
		this.offset.set(18, 12);
		//Creo gun y bullets
		//var aBullets = new FlxTypedGroup<Bullet>();
		this.playerGun = new Pistol(X, Y + this.height / 2);
		FlxG.state.add(playerGun);

	}

	override public function update(elapsed:Float):Void
	{
		if (animation.curAnim.name == "die") // Si la animación actual es de muerte
		{
		super.update(elapsed);
		if (animation.curAnim.finished) // Al finalizar la animación mato al enemy
			{
				playerGun.kill();
				kill();
			}
			return;
		}
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
			playerGun.shoot(x + width /2 , y + height/2, FlxG.mouse.x, FlxG.mouse.y);
		}
		super.update(elapsed);
		playerGun.x = this.x + 7;
		playerGun.y = this.y + 26;
	}

	override public function draw():Void
	{
		if (playerCurrentLife > 0)
		{
			var dX = FlxG.mouse.x - this.x;
			var dY = FlxG.mouse.y - this.y;
			var angle = Math.atan2(dY, dX) * 180 / Math.PI;
			if (angle < 0)
			{
				angle += 360;
			}
			if (angle <= (0 + 45) || angle > (360 - 45)){
				animation.play("right");
				playerGun.alpha = 1;
				playerGun.animation.play("right");
			} else if (angle  <=  (90 + 45) && angle > (90 - 45)){
				animation.play("south");
				playerGun.alpha = 1;
				playerGun.animation.play("south");
			} else if (angle <= (180 + 45) && angle > (180 - 45)){
				animation.play("left");
				playerGun.alpha = 1;
				playerGun.animation.play("left");
				playerGun.x -= 7;
			} else if (angle <= (270 + 45) && angle > (270 - 45)){
				animation.play("north");
				playerGun.alpha = 0;
				playerGun.animation.play("north");
			}
			if(velocity.x == 0 && velocity.y == 0)
				animation.stop();	
		}
		super.draw();
	}

	public function receiveDamage(damage:Int):Void
	{
		if (!isHurt)
		{
			playerCurrentLife -= damage;
			GlobalGameData.aHud.updateHUD();
			if (playerCurrentLife <= 0)
			{
				playerCurrentLife = 0;
				velocity.set(0, 0);
				animation.play("die");
			}else
			{
			hurtTween();
			isHurt = true;
			}
		}
		
	}

	public function healPlayer(health:Int):Void
	{
		playerCurrentLife += health;
		if (playerCurrentLife > playerTotalLife)
		{
			playerCurrentLife = playerTotalLife;
		}
		GlobalGameData.aHud.updateHUD();
	}
	

	public function fullHealth():Bool
	{
		return playerCurrentLife == playerTotalLife;
	}

	private function hurtTween():Void
	{
		FlxTween.color(this, 2, FlxColor.RED, FlxColor.WHITE, {onComplete:tweenEnds });
	}
	
	private function tweenEnds(tween:FlxTween):Void
	{
		tween.cancel();
		isHurt = false;
	}

}
