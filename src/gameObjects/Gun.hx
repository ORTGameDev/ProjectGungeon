package gameObjects;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import gameObjects.Bullet;
import openfl.Assets;

/**
 * ...
 * @author Gastón // Nacho
 */

 
class Gun extends FlxSprite
{
	public var bullets: FlxTypedGroup<Bullet>;
	
	public function new(aX:Float, aY:Float, aBullets:FlxTypedGroup<Bullet>) 
	{
		super(aX + 10, aY + 10);
		bullets = aBullets;
		bullets.maxSize = 50;
		
		
		var anAtlas = FlxAtlasFrames.fromTexturePackerJson("img/atlas/spritesheet.png", "img/atlas/spritemap.json");
		this.frames = anAtlas;
		this.animation.addByPrefix("north", "p_up", 10, true);
		this.animation.addByPrefix("south", "p_down", 10, true);
		this.animation.addByPrefix("right", "p_side", 10, true);
		this.animation.addByPrefix("left", "p_side", 10, true, true);
		this.animation.addByPrefix("diagDown_right", "p_diagdown", 10, true);
		this.animation.addByPrefix("diagUp_right", "p_diagup", 10, true);
		this.animation.addByPrefix("diagDown_left", "p_diagdown", 10, true, true);
		this.animation.addByPrefix("diagUp_left", "p_diagup", 10, true, true);
		this.animation.play("south");
	}
	
	public function shoot (aX:Float, aY:Float): Void
	{
		var bullet:Bullet = cast bullets.recycle(Bullet, null, false, false);
		
		if (!bullet.alive)
		{
			bullet.reset(aX, aY);
		}
		
	}
	
	
	
}