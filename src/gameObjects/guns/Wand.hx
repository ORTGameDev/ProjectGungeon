package gameObjects.guns;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import gameObjects.guns.bullets.BoltBullet;
import gameObjects.guns.bullets.Bullet;
import gameObjects.guns.Gun;
import openfl.Assets;
import openfl.Lib;

/**
 * ...
 * @author Gastón // Nacho
 */

 
class Wand extends Gun
{
	private var gunLastShoot: Int = 0;
	public function new(aX:Float, aY:Float, bullets:FlxTypedGroup<Bullet>) 
	{
		super(aX, aY, bullets, FlxG.sound.load("sounds/pistolShot.mp3", 0.4, false), 1, true, 500);
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
	
	
	public override function shoot (aX:Float, aY:Float, aTargetX:Float, aTargetY:Float): Void
	{
		var bullet:Bullet = cast bulletGroup.recycle(BoltBullet, null, false, false);
			var currentTime = Lib.getTimer();
			if (currentTime > gunLastShoot + 2500)
			{
				bullet.shoot(aX, aY, aTargetX, aTargetY);
				gunSound.play(true);
				gunLastShoot = currentTime;
			}

	}
	
	
	
}