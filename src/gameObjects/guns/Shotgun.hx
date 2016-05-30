package gameObjects.guns;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import gameObjects.guns.Bullet;
import gameObjects.guns.Gun;
import gameObjects.guns.Pistol;
import openfl.Assets;
import openfl.Lib;

/**
 * ...
 * @author Gastón // Nacho
 */

 
class Shotgun extends Gun
{
	private var gunLastShoot: Int = 0;	
	
	public function new(aX:Float, aY:Float) 
	{
		super(aX, aY, GlobalGameData.enemiesBullets, 2, 200, FlxG.sound.load("sounds/shotgunShot.mp3", 0.4, false));
		var anAtlas = FlxAtlasFrames.fromTexturePackerJson("img/atlas/spritesheet.png", "img/atlas/spritemap.json");
		this.frames = anAtlas;
		this.animation.addByPrefix("north", "shot_up", 10, true);
		this.animation.addByPrefix("south", "shot_down", 10, true);
		this.animation.addByPrefix("right", "shot_side", 10, true);
		this.animation.addByPrefix("left", "shot_side", 10, true, true);
		this.animation.addByPrefix("diagDown_right", "shot_diagdown", 10, true);
		this.animation.addByPrefix("diagUp_right", "shot_diagup", 10, true);
		this.animation.addByPrefix("diagDown_left", "shot_diagdown", 10, true, true);
		this.animation.addByPrefix("diagUp_left", "shot_diagup", 10, true, true);
		this.animation.play("south");

	}
	
	public  override function shoot (aX:Float, aY:Float, aTargetX:Float, aTargetY:Float): Void
	{
		var currentTime = Lib.getTimer();
		if (currentTime > gunLastShoot + 4000)
		{
			var angleX: Int = -30;
			var angleY: Int = -30;
			for (i in 0...3)
			{
				var bullet:Bullet = bullets.recycle(Bullet, null, false, false);
				bullet.bulletDamage = gunBulletDamage;
				bullet.bulletSpeed = gunBulletSpeed;
				bullet.shoot(aX, aY, aTargetX + angleX, aTargetY + angleY, 2);
				angleX += 30;
				angleY += 30;
			}
			/*
			var bullet:Bullet = cast bullets.recycle(Bullet, null, false, false);
			bullet.bulletDamage = gunBulletDamage;
			bullet.bulletSpeed = gunBulletSpeed;
			//if (!bullet.alive)
			//{*/
				gunSound.play(true);
				gunLastShoot = currentTime;
			//}
		}
		
	}
	
	
	
	
}