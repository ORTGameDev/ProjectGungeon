package gameObjects.players;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import gameObjects.guns.Smg;
import gameObjects.guns.Wand;
import gameObjects.guns.bullets.Bullet;
import gameObjects.guns.Gun;
import gameObjects.guns.Pistol;
import gameObjects.guns.Shotgun;
import gameObjects.players.Player.GunType;
import openfl.Assets;

/**
 * ...
 * @author Gastón // Nacho
 */

 enum GunType{
	pistol;
	shotgun;
	smg;
	}
	
	
class Player extends FlxSprite
{

	//Player
	public var playerCurrentLife:Int = 10;
	public var playerTotalLife:Int = 10;
	
	//Hurt
	public var isHurt:Bool = false;
	
	//Movement
	static private inline var playerAcceleration: Float = 25000;
	static private inline var playerXMaxSpeed: Float = 250;
	static private inline var playerYMaxSpeed: Float = 150;
	static private inline var playerDrag: Int = 2500;

	//Gun
	public var playerCurrentGun:Gun;
	private var guns:Array<Gun>;
	

	public function new(X:Float = 0, Y:Float = 0) {
		super(X, Y);
		var anAtlas = FlxAtlasFrames.fromTexturePackerJson("img/atlas/players/PlayerOne.png", "img/atlas/players/PlayerOne.json");
		this.frames = anAtlas;
		this.animation.addByPrefix("north", "playerOne_walk_up", 8, true);
		this.animation.addByPrefix("south", "playerOne_walk_down", 8, true);
		this.animation.addByPrefix("right", "playerOne_walk_right", 8, true);
		this.animation.addByPrefix("left", "playerOne_walk_left", 8, true);
		this.animation.addByPrefix("die", "playerOne_die", 5, false);
		this.animation.addByPrefix("start", "playerOne_walk_down (1)", 1, false, false, true);
		this.animation.play("start");
		this.setSize(26, 52);
		this.offset.set(17, 12);
		
		drag.set(playerDrag, playerDrag);
		maxVelocity.set(playerXMaxSpeed, playerYMaxSpeed);
		
		guns = new Array<Gun>();
		this.guns[0] = new Pistol(this.x, this.y, GlobalGameData.playerBullets);
		this.playerCurrentGun = guns[0];

		//FlxG.state.add(playerCurrentGun);

	}

	override public function update(elapsed:Float):Void {
		if (animation.curAnim.name == "die") {// Si la animación actual es de muerte
			super.update(elapsed);
			if (animation.curAnim.finished) { // Al finalizar la animación mato al enemy
				playerCurrentGun.kill();
				kill();
			}
			return;
		}
		acceleration.set(0, 0);
		
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.A) {
			velocity.x = 0;
			acceleration.x -= playerAcceleration;
		}
		if (FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.D) {
			velocity.x = 0;
			acceleration.x += playerAcceleration;
		}
		if (FlxG.keys.pressed.DOWN || FlxG.keys.pressed.S) {
			velocity.x = 0;
			acceleration.y += playerAcceleration;
		}
		if (FlxG.keys.pressed.UP || FlxG.keys.pressed.W) {
			velocity.x = 0;
			acceleration.y -= playerAcceleration;
		}
		if (FlxG.keys.pressed.SPACE || FlxG.mouse.pressed) {
			playerCurrentGun.shoot(x + width / 2 , y + height / 2, FlxG.mouse.x, FlxG.mouse.y);
			GlobalGameData.aHud.updateVisualizer();
		}
		if (FlxG.keys.pressed.ONE) {
			changeWeapon(pistol);
		}
		if (FlxG.keys.pressed.TWO) {
			changeWeapon(shotgun);
		}
		if (FlxG.keys.pressed.THREE) {
			changeWeapon(smg);
		}
		super.update(elapsed);
		playerCurrentGun.x = this.x + 7;
		playerCurrentGun.y = this.y + 26;
	}

	override public function draw():Void {
		if (playerCurrentLife > 0) {
			var dX = FlxG.mouse.x - this.x;
			var dY = FlxG.mouse.y - this.y;
			var angle = Math.atan2(dY, dX) * 180 / Math.PI;
			if (angle < 0) {
				angle += 360;
			}
			if (angle <= (0 + 45) || angle > (360 - 45)) {
				animation.play("right");
				//playerCurrentGun.alpha = 1;
				//playerCurrentGun.animation.play("right");
			} else if (angle  <=  (90 + 45) && angle > (90 - 45)) {
				animation.play("south");
				//playerCurrentGun.alpha = 1;
				//playerCurrentGun.animation.play("south");
			} else if (angle <= (180 + 45) && angle > (180 - 45)) {
				animation.play("left");
				//playerCurrentGun.alpha = 1;
				//playerCurrentGun.animation.play("left");
				//playerCurrentGun.x -= 7;
			} else if (angle <= (270 + 45) && angle > (270 - 45)) {
				animation.play("north");
				//playerCurrentGun.alpha = 0;
				//playerCurrentGun.animation.play("north");
			}
			if(velocity.x == 0 && velocity.y == 0)
				animation.stop();	
		}
		super.draw();
	}

	public function receiveDamage(damage:Int):Void
	{
		if (!isHurt)
		{
			playerCurrentLife -= damage;
			GlobalGameData.aHud.updateHUD();
			if (playerCurrentLife <= 0)
			{
				playerCurrentLife = 0;
				velocity.set(0, 0);
				animation.play("die");
			}else
			{
			hurtTween();
			isHurt = true;
			}
		}
		
	}

	public function healPlayer(health:Int):Void
	{
		playerCurrentLife += health;
		if (playerCurrentLife > playerTotalLife)
		{
			playerCurrentLife = playerTotalLife;
		}
		GlobalGameData.aHud.updateHUD();
	}
	
	public function pickWeapon(gType:GunType):Void
	{
		switch(gType)
		{
			case pistol:	
				if (guns[0] == null){
					guns[0] = new Pistol(this.x, this.y, GlobalGameData.playerBullets);
				}
				this.playerCurrentGun = guns[0];
				this.playerCurrentGun.reload();
				
			case shotgun:
				if (guns[1] == null){
					guns[1] = new Shotgun(this.x, this.y, GlobalGameData.playerBullets);
				}
				this.playerCurrentGun = guns[1];
				this.playerCurrentGun.reload();
			case smg: 
				if (guns[2] == null){
					guns[2] = new Smg(this.x, this.y, GlobalGameData.playerBullets);
				}
				this.playerCurrentGun = guns[2];
				this.playerCurrentGun.reload();
		}
		changeWeapon(gType);
	}
	
	private function changeWeapon(gType:GunType):Void
	{
		this.playerCurrentGun.kill();
		switch(gType)
		{
			case pistol:
				if (guns[0] != null){
					this.playerCurrentGun = guns[0];
				}
			case shotgun:
				if (guns[1] != null){
					this.playerCurrentGun = guns[1];
				}
			case smg:
				if (guns[2] != null){
					this.playerCurrentGun = guns[2];
				}
		}
		this.playerCurrentGun.revive();
		GlobalGameData.aHud.updateVisualizer();
	}
	

	public function fullHealth():Bool
	{
		return playerCurrentLife == playerTotalLife;
	}

	private function hurtTween():Void
	{
		FlxTween.color(this, 2, FlxColor.RED, FlxColor.WHITE, {onComplete:tweenEnds });
	}
	
	private function tweenEnds(tween:FlxTween):Void
	{
		tween.cancel();
		isHurt = false;
	}

	
}

	