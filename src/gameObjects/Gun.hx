package gameObjects;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
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
	private var gunSound: FlxSound;
	private var gunBulletDamage: Int = 1;
	private var gunBulletSpeed: Int = 100;
	private var bulletSprite: FlxSprite;
	
	
	public function new(aX:Float, aY:Float, aBullets:FlxTypedGroup<Bullet>, aBulletDamage:Int, aBulletSpeed:Int, aGunSound:FlxSound) 
	{

		super(aX, aY);
		gunBulletDamage = aBulletDamage;
		gunBulletSpeed = aBulletSpeed;
		gunSound = aGunSound;
		bullets = aBullets;
	}
	
	public function shoot(aX:Float, aY:Float, aTargetX:Float, aTargetY:Float): Void { }
	
	
	
}