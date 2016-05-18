package gameObjects.guns;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import gameObjects.guns.Bullet;
import gameObjects.guns.Gun;
import openfl.Assets;
import openfl.Lib;

/**
 * ...
 * @author Gastón // Nacho
 */

 
class Pistol extends Gun
{
	private var gunLastShoot: Int = 0;
	public function new(aX:Float, aY:Float) 
	{
		var bulletGroup = new FlxTypedGroup<Bullet>();
		bulletGroup.maxSize = 25;
		super(aX, aY, bulletGroup, 2, 250, FlxG.sound.load("sounds/pistolShot.mp3", 0.4, false));
		var anAtlas = FlxAtlasFrames.fromTexturePackerJson("img/atlas/spritesheet.png", "img/atlas/spritemap.json");
		frames = anAtlas;
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
	
	
	public override function shoot (aX:Float, aY:Float, aTargetX:Float, aTargetY:Float): Void
	{
		var bullet:Bullet = cast bullets.recycle(Bullet, null, false, false);
		bullet.bulletDamage = gunBulletDamage;
		bullet.bulletSpeed = gunBulletSpeed;
		if (!bullet.alive)
		{
			var currentTime = Lib.getTimer();
			if (currentTime > gunLastShoot + 700)
			{
				bullet.shoot(aX, aY, aTargetX, aTargetY, 1);
				gunSound.play(true);
				gunLastShoot = currentTime;
			}

			
		}
		
	}
	
	
	
}