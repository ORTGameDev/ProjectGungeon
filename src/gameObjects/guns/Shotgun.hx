package gameObjects.guns;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import gameObjects.guns.bullets.Bullet;
import gameObjects.guns.Gun;
import gameObjects.guns.Pistol;
import gameObjects.guns.bullets.ShotgunBullet;
import openfl.Assets;
import openfl.Lib;

/**
 * ...
 * @author Gastón // Nacho
 */

 
class Shotgun extends Gun
{
	private var gunLastShoot: Int = 0;	
	
	public function new(aX:Float, aY:Float, bullets:FlxTypedGroup<Bullet>) 
	{
		super(aX, aY, bullets, FlxG.sound.load("sounds/shotgunShot.mp3", 0.4, false), 8, false, 2000);
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
		if(currentInChamber > 0){
			var currentTime = Lib.getTimer();
			if (currentTime> gunLastShoot + shootDelay){
				var bullet1:ShotgunBullet = cast (bulletGroup.recycle(ShotgunBullet, null, false, false), ShotgunBullet);
				bullet1.shootWithAngle(aX, aY, aTargetX, aTargetY, Math.PI / 16);
				
				var bullet2:ShotgunBullet = cast (bulletGroup.recycle(ShotgunBullet, null, false, false), ShotgunBullet);
				bullet2.shootWithAngle(aX, aY, aTargetX, aTargetY, 0);
				
				var bullet3
				:ShotgunBullet = cast (bulletGroup.recycle(ShotgunBullet, null, false, false), ShotgunBullet);
				bullet3.shootWithAngle(aX, aY, aTargetX, aTargetY, (Math.PI / 16) * -1);
				
				gunSound.play(true);
				gunLastShoot = currentTime;
				currentInChamber --;
				if (currentInChamber == 0 && infiniteBullets){
					currentInChamber = chamberLength;
				}else{
					
				}
				
			}
		}
	}
	
	
	
	
}