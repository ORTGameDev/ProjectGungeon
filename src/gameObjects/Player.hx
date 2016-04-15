package gameObjects;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import openfl.Assets;

/**
 * ...
 * @author Gastón // Nacho
 */
class Player extends FlxSprite
{

	//Player
	public var playerLife:Int = 10;
	
	
	//Movement
	static private inline var playerAcceleration: Float = 300;
	static private inline var playerXMaxSpeed: Float = 250;
	static private inline var playerYMaxSpeed: Float = 200;
	static private inline var playerDrag: Int = 1800;
	
	//Gun
	public var playerGun:Gun;
	
		
	public function new(X:Float = 0, Y:Float = 0, aGun:Gun /* aGraphic:FlxGraphicAsset*/)
	{
		super(X, Y);
		makeGraphic(50, 50, FlxColor.CYAN);
		maxVelocity.set(playerXMaxSpeed, playerYMaxSpeed);
		loadGraphic(Assets.getBitmapData("characters/start1.png"), false, 20, 24);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		animation.add("u", [0, 1, 2, 3], 4);
		//animation.add("ur", [0, 1, 2, 3], 4);
		//animation.add("ul", [0, 1, 2, 3], 4);
		animation.add("r", [0, 1, 2, 3], 4);
		animation.add("d", [0, 1, 2, 3], 4);
		//animation.add("dr", [0, 1, 2, 3], 4);
		//animation.add("dl", [0, 1, 2, 3], 4);
		animation.add("l", [0, 1, 2, 3], 4);
		drag.set(playerDrag, playerDrag);
		playerGun = aGun;
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
	/*	if (FlxG.keys.justPressed.SPACE)
		{
			gun.shoot(x + width, y + height/2);
		}*/
		super.update(elapsed);
		playerGun.x = this.x + 10;
		playerGun.y = this.y + (this.height / 2);
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
					loadGraphic(Assets.getBitmapData("characters/side1.png"), true, 20, 24);
					animation.play("l");
				
				case FlxObject.RIGHT:
					loadGraphic(Assets.getBitmapData("characters/side1.png"), true, 20, 24);
					animation.play("r");
					
				case FlxObject.UP:
					loadGraphic(Assets.getBitmapData("characters/north1.png"), true, 20, 24);
					animation.play("u");
					
				case FlxObject.DOWN:
					loadGraphic(Assets.getBitmapData("characters/south1.png"), true, 20, 24);
					animation.play("d");
				
			}
			
		}
		super.draw();
	}
	
	
	
}