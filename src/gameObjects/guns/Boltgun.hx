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

 
class Boltgun extends Gun
{
	private var gunLastShoot: Int = 0;
	public function new(aX:Float, aY:Float) 
	{
		super(aX, aY, GlobalGameData.enemiesBullets, 4, 150, FlxG.sound.load("sounds/pistolShot.mp3", 0.4, false));
		var anAtlas = FlxAtlasFrames.fromTexturePackerJson("img/atlas/spritesheet.png", "img/atlas/spritemap.json");
		frames = anAtlas;
		this.animation.addByPrefix("north", "laser_up", 10, true);
		this.animation.addByPrefix("south", "laser_down", 10, true);
		this.animation.addByPrefix("right", "laser_side", 10, true);
		this.animation.addByPrefix("left", "laser_side", 10, true, true);
		this.animation.addByPrefix("diagDown_right", "laser_diagdown", 10, true);
		this.animation.addByPrefix("diagUp_right", "laser_diagup", 10, true);
		this.animation.addByPrefix("diagDown_left", "laser_diagdown", 10, true, true);
		this.animation.addByPrefix("diagUp_left", "laser_diagup", 10, true, true);
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
			if (currentTime > gunLastShoot + 2500)
			{
				bullet.shoot(aX, aY, aTargetX, aTargetY, 3);
				gunSound.play(true);
				gunLastShoot = currentTime;
			}

			
		}
		
	}
	
	
	
}