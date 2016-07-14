package gameObjects.guns;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import gameObjects.guns.bullets.Bullet;
import gameObjects.guns.Gun;
import gameObjects.guns.bullets.PistolBullet;
import openfl.Assets;
import openfl.Lib;

/**
 * ...
 * @author Gastón // Nacho
 */

 
class Pistol extends Gun
{
	
	
	public function new(aX:Float, aY:Float, bullets:FlxTypedGroup<Bullet>) 
	{
		var bulletGroup = GlobalGameData.playerBullets;
		super(aX, aY, bullets, FlxG.sound.load("sounds/pistolShot.mp3", 0.4, false), 20, true, 1000);
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
		if (currentInChamber > 0 ){
			
			var currentTime = Lib.getTimer();
			if (currentTime > lastShoot + shootDelay) {
				var bullet:Bullet = cast bulletGroup.recycle(PistolBullet, null, false, false);
					bullet.shoot(aX, aY, aTargetX, aTargetY);
					gunSound.play(true);
					lastShoot = currentTime;
					currentInChamber --;
					if (currentInChamber == 0) {
						if (infiniteBullets) {
							reload();
						}else{
							currentInChamber = 0;
							//Acá hay que destruir el arma del player y que vuelva a la pisto
						}
					}
			}
		}
	}
	

	
}