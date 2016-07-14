package gameObjects.guns;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import gameObjects.guns.bullets.Bullet;
import openfl.Assets;

/**
 * ...
 * @author Gastón // Nacho
 */

 
class Gun extends FlxSprite {
	public 	var bulletGroup: FlxTypedGroup<Bullet>;
	public 	var chamberLength: Int = 0;
	public 	var currentInChamber: Int = 0;
	public  var infiniteBullets: Bool = false;
	private var gunSound: FlxSound;
	private var bulletSprite: FlxSprite;
	private var lastShoot: Int = 0;
	private var shootDelay: Int = 0;
	
	
	public function new(aX:Float, aY:Float, aBullets:FlxTypedGroup<Bullet>, aGunSound:FlxSound, aChamberLength:Int, hasInfiniteBullet:Bool, aShootDelay:Int) 
	{
		super(aX, aY);
		this.bulletGroup = aBullets;
		this.gunSound = aGunSound;
		this.chamberLength = this.currentInChamber = aChamberLength;
		this.infiniteBullets = hasInfiniteBullet;
		this.shootDelay = aShootDelay;
	}
	
	public function shoot(aX:Float, aY:Float, aTargetX:Float, aTargetY:Float): Void { }
	
	public function reload():Void {	this.currentInChamber = this.chamberLength;	}
	
	
	
}