package gameObjects.enemies;
import flixel.FlxG;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFrame;
import flixel.system.FlxSound;
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
		/*var anAtlas = FlxAtlasFrames.fromTexturePackerJson("img/atlas/spritesheet.png", "img/atlas/spritemap.json");
		frames = anAtlas;
		animation.addByPrefix("north3", "north3_", 5, true);
		animation.addByPrefix("south3", "south3_", 5, true);
		animation.addByPrefix("right3", "side3_", 5, true);
		animation.addByPrefix("left3", "side3_", 5, true, true);
		animation.addByPrefix("diagDown3", "diagDown3_", 5, true);
		animation.addByPrefix("diagUp3", "diagUp3_", 5, true);
		animation.addByPrefix("start3", "start3", 5, false);
		animation.addByPrefix("x", "start3", 5, false, false, true);*/
		
		this.loadGraphic(Assets.getBitmapData("img/atlas/enemies/Boss.png"),true, 96,96);
		animation.add("start", [0], 1, true);
		animation.add("north", [9, 10, 11], 5, true);
		animation.add("south", [0, 1, 2], 5, true);
		animation.add("right", [6, 7, 8], 5, true);
		animation.add("left", [3, 4, 5], 5, true);
		animation.add("die", [1], 1, true);
		scale.set(1.5, 1.5);
		updateHitbox();
		animation.play("start");
		//Voices
		voices = new Array<FlxSound>();
		voices.push(FlxG.sound.load("sounds/voices/die.mp3"));
		voices.push(FlxG.sound.load("sounds/voices/no_one.mp3"));
		voices.push(FlxG.sound.load("sounds/voices/stupid_monkey.mp3"));
		
		//Skills
		enemySpeed = 40;
		enemyChaseDistance = 600;
		enemyLife = 25;
		drag.x = drag.y = 1500;
		maxVelocity.set(550, 400);
		enemyShootDistance = 500;
		//Enemy Guns
		//Main gun
		mainGun = new Wand(X, Y, GlobalGameData.enemiesBullets);
		mainGun.infiniteBullets = true;
		//SecondGun
		secondGun = new Smg(X, Y, GlobalGameData.enemiesBullets); 
		secondGun.infiniteBullets = true;
		enemyGun = mainGun;
		lastWeaponChange = Lib.getTimer();	
		onSpecialAtack = false;
		
	}
	
	
	override public function update (elapsed: Float):Void {
		super.update(elapsed);
		/*
		switch (animation.curAnim.name) {
			case "start": 
				width = 96;
				offset.set(0,0);
			case "north": 
				width = 96; 
				offset.set(0,0);
			case "south": 
				width = 96; 
				offset.set(0,0);
			case "right": 
				width = 96 / 2;
				offset.set(96/3,0);
			case "left":  
				width = 96 / 2; 
				offset.set(96/3,0);
			
		}*/
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
	
	
}