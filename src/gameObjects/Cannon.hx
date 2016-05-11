package gameObjects;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import gameObjects.Bullet;
import gameObjects.Gun;
import gameObjects.Pistol;
import openfl.Assets;

/**
 * ...
 * @author Gastón // Nacho
 */

 
class Cannon extends Gun
{
		
	public function new(aX:Float, aY:Float) 
	{
		var bulletGroup = new FlxTypedGroup<Bullet>();
		bulletGroup.maxSize = 25;
		super(aX, aY, bulletGroup, 1, 200, FlxG.sound.load("sounds/cannonShot.mp3", 0.4, false));
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
	
	public  override function shoot (aX:Float, aY:Float, aTargetX:Float, aTargetY:Float): Void
	{
		var bullet:Bullet = cast bullets.recycle(Bullet, null, false, false);
		bullet.bulletDamage = gunBulletDamage;
		bullet.bulletSpeed = gunBulletSpeed;
		if (!bullet.alive)
		{
			bullet.shoot(aX, aY, aTargetX, aTargetY, 2);
			gunSound.play(true);
		}
		
	}
	
	
	
	
}