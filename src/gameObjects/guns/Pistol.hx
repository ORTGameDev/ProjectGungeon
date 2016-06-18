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
	
	
	public function new(aX:Float, aY:Float) 
	{
		var bulletGroup = GlobalGameData.playerBullets;
		super(aX, aY, bulletGroup, 2, 250, FlxG.sound.load("sounds/pistolShot.mp3", 0.4, false), 20, true, 1000);
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
		var currentTime = Lib.getTimer();
		if (currentTime > lastShoot + shootDelay)
		{
			var bullet:Bullet = cast bulletGroup.recycle(Bullet, null, false, false);
			bullet.bulletDamage = this.bulletDamage;
			bullet.bulletSpeed = this.bulletSpeed;
			if (!bullet.alive) 
			{
				bullet.shoot(aX, aY, aTargetX, aTargetY, 1);
				gunSound.play(true);
				lastShoot = currentTime;
				currentInChamber --;
				if (currentInChamber == 0){
					if (infiniteBullets){
						currentInChamber = chamberLength;
					}else{
						currentInChamber = 0;
						//Acá hay que destruir el arma del player y que vuelva a la pisto
					}
				}
			}
		}
	}
		
	
}