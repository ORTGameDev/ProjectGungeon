package gameObjects.enemies;
import flixel.FlxG;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFrame;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import gameObjects.enemies.Enemy;
import gameObjects.guns.Gun;
import gameObjects.guns.Smg;
import gameObjects.guns.Wand;
import openfl.Assets;
import openfl.Lib;
import openfl.utils.Timer;

/**
 * ...
 * @author Gastón Marichal // Ignacion Benedetto
 */
class BossEnemy extends Enemy
{
	private var weapongChangeTime:Int = 8000;
	private var lastWeaponChange:Int;
	private var specialAtackTime: Int = 5000;
	
	private var voices: Array<FlxSound>;
	
	private var mainGun:Gun;
	private var secondGun:Gun;
	private var onSpecialAtack: Bool;

	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		//Graphics
		this.loadGraphic(Assets.getBitmapData("img/atlas/enemies/Boss.png"),true, 96,96);
		animation.add("start", [0], 1, true);
		animation.add("north", [9, 10, 11], 5, true);
		animation.add("south", [0, 1, 2], 5, true);
		animation.add("right", [6, 7, 8], 5, true);
		animation.add("left", [3, 4, 5], 5, true);
		animation.add("die", [1,1,1,1,1,1], 5, false);
		scale.set(1.5, 1.5);
		updateHitbox();
		animation.play("start");
		//Voices
		voices = new Array<FlxSound>();
		/*voices.push(FlxG.sound.load("sounds/voices/die.mp3"));
		voices.push(FlxG.sound.load("sounds/voices/no_one.mp3"));
		voices.push(FlxG.sound.load("sounds/voices/stupid_monkey.mp3"));*/
		
		//Skills
		enemySpeed = 55;
		enemyChaseDistance = 600;
		enemyLife = 25;
		enemyTotalLife = enemyLife;
		drag.x = drag.y = 1500;
		maxVelocity.set(550, 400);
		enemyShootDistance = 500;
		//Main gun
		mainGun = new Wand(X, Y, GlobalGameData.enemiesBullets);
		mainGun.infiniteBullets = true;
		//Second Gun
		secondGun = new Smg(X, Y, GlobalGameData.enemiesBullets); 
		secondGun.infiniteBullets = true;
		enemyGun = mainGun;
		lastWeaponChange = Lib.getTimer();	
		onSpecialAtack = false;
		tweenDuration = 1;
		
	}
	
	
	override public function update (elapsed: Float):Void {
		super.update(elapsed);
		if (!onSpecialAtack && (Lib.getTimer() - lastWeaponChange >= weapongChangeTime)){
			onSpecialAtack = true;
			enemyGun = secondGun;
			lastWeaponChange = Lib.getTimer();
		//	talk();
		}
		if (onSpecialAtack && Lib.getTimer() -  lastWeaponChange >= weapongChangeTime){
			onSpecialAtack = false;
			enemyGun = mainGun;
			lastWeaponChange = Lib.getTimer();
		}
		if (enemyLife < enemyTotalLife / 2 && enemyLife >= enemyTotalLife / 3 && this.color != FlxColor.PINK){
			this.color = FlxColor.PINK;
		}
		if (enemyLife < enemyTotalLife / 3 && this.color != FlxColor.RED){
			this.color = FlxColor.RED;
		}
	}
	
	override private function shootToPlayer(aPlayerX:Float, aPlayerY:Float):Void {
		enemyGun.shoot(x + width / 2, y + height / 2, aPlayerX, aPlayerY);
	}
	
	private function talk(){
		var aux = Math.random();
		if (aux <= 0.33){
			voices[0].play();
		}else if (aux > 0.33 && aux <= 0.66){
			voices[1].play();
		}else{
			voices[2].play();
		}
	}
	
	override public function kill() {
		explode();
		super.kill();
	}
	
	private function explode():Void {
		var aux = 0;
		while (aux < 6){
			aux++;
			var exp = new SkeletonExplotion(this.x + this.width / 2 - Std.int(Math.random() * 100), this.y + Std.int(Math.random() * 100));
		}
		
	}
}