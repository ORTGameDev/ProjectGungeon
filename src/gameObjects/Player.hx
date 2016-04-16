package gameObjects;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
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
	static private inline var playerAcceleration: Float = 150;
	static private inline var playerXMaxSpeed: Float = 250;
	static private inline var playerYMaxSpeed: Float = 200;
	static private inline var playerDrag: Int = 2500;
	
	//Gun
	public var playerGun:Gun;
			
	public function new(X:Float = 0, Y:Float = 0, aGun:Gun /* aGraphic:FlxGraphicAsset*/)
	{
		super(X, Y);
		var anAtlas = FlxAtlasFrames.fromTexturePackerJson("img/atlas/spritesheet.png", "img/atlas/spritemap.json");
		this.frames = anAtlas;
		this.animation.addByPrefix("north1", "north1_", 10, true);
		this.animation.addByPrefix("south1", "south1_", 10, true);
		this.animation.addByPrefix("right1", "side1_", 10, true);
		this.animation.addByPrefix("left1", "side1_", 10, true, true);
		this.animation.addByPrefix("diagDown1", "diagDown1_", 10, true);
		this.animation.addByPrefix("diagUp1", "diagUp1_", 30, true);
		this.animation.addByPrefix("start1", "start1_", 30, true);
		this.animation.play("start");
		drag.set(playerDrag, playerDrag);
		maxVelocity.set(playerXMaxSpeed, playerYMaxSpeed);
		/*
		makeGraphic(50, 50, FlxColor.CYAN);
		
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
		
		
		*/playerGun = aGun;
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
					animation.play("left1");
				
				case FlxObject.RIGHT:
					
					animation.play("right1");
					
				case FlxObject.UP:
					animation.play("north1");
					
				case FlxObject.DOWN:
					animation.play("south1");
				
			}
			
		}
		super.draw();
	}
	
	
	
}