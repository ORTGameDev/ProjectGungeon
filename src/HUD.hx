package;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import gameObjects.guns.Pistol;
import gameObjects.guns.Shotgun;
import openfl.Assets;
import openfl.text.Font;
import states.MenuState;
import states.PlayState;

/**
 * ...
 * @author Gaston Marichal / Ignacio Benedetto
 */
class HUD extends FlxTypedGroup<FlxSprite> {
	
	/////  Top info  /////
	private var sprBackground: FlxSprite;
	private var sprHealthArray: Array<FlxSprite>;
	
	/////  Messages and Buttons  /////
	private var backGround: FlxSprite;
	private static inline var backGroundWidth: 	Int = 300;
	private static inline var backGroundHeigth: Int = 200;
	private var PlayerMessage: FlxText;
	private var btnRetryLevel: FlxButton;
	private var btnQuit: FlxButton;
	private var btnNextLevel: FlxButton;
	private static inline var buttonGap: Int = 10;

	
	/////  Gun visualizer  /////
	private var visualizerBackground: FlxSprite;
	private var gunSprite: FlxSprite;
	private var bulletInChamber: FlxText;
	
	
	public function new(aLvlNumber:Int, aLvlString:String) {
		super();
		createTopHudInfo(aLvlNumber, aLvlString);
		createGunVisualizer();
		updateVisualizer();
		forEach(function(spr:FlxSprite)	{
			spr.scrollFactor.set(0, 0);
		});
	}
	
	private function createTopHudInfo(aLvlNumber:Int, aLvlString:String):Void {
		//BackGround
		sprBackground = new FlxSprite();
		sprBackground.makeGraphic(FlxG.width, 40, FlxColor.BLACK);
		sprBackground.alpha = 0.2;
		FlxSpriteUtil.drawRect(sprBackground, 0, 37, FlxG.width, 3, FlxColor.WHITE);
		add(sprBackground);
		
		//PLayerHealth
		sprHealthArray = new Array<FlxSprite>();
		var gap: Int = 20;
		for (i in 0...GlobalGameData.player.playerTotalLife) {
			var h = new FlxSprite(gap, 5);
			h.loadGraphic(Assets.getBitmapData("img/sprite_0.png"), false, 32, 32);
			add(h);
			sprHealthArray.insert(i, h);
			gap += 30;
			
		}
		
	}
	
	private function createGunVisualizer() {
		//visualizer BackGround
		visualizerBackground = new FlxSprite(FlxG.width - 200,FlxG.height - 60);
		visualizerBackground.makeGraphic(200, 40, FlxColor.BLACK);
		visualizerBackground.alpha = 0.3;
		add(visualizerBackground);
		
		gunSprite = new FlxSprite(visualizerBackground.x + 5, visualizerBackground.y + 5);
		add(gunSprite);
		
		bulletInChamber = new FlxText(gunSprite.x + 100, gunSprite.y + (gunSprite.height / 2), 0, "", 24);
		bulletInChamber.setFormat(24, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.NONE, FlxColor.WHITE);
		add(bulletInChamber);
	}
	
	public function createPlayMenu(playerWins:Bool):Void 
	{
		btnNextLevel = new FlxButton(0, 200, "Continue >>", nextLevel);
		btnNextLevel.screenCenter(FlxAxes.X);
		if (!playerWins){
			btnNextLevel.visible = false;
		}
		btnNextLevel.allowCollisions = FlxObject.NONE;
			
		btnRetryLevel = new FlxButton(0, 0, "Retry", reloadState);
		btnRetryLevel.screenCenter(FlxAxes.X);
		btnRetryLevel.y = btnNextLevel.y + btnNextLevel.height + buttonGap;
		btnRetryLevel.allowCollisions = FlxObject.NONE;
		
		btnQuit = new FlxButton(0, 0, "Back to Menu", BackToMenu);
		btnQuit.screenCenter(FlxAxes.X);
		btnQuit.y = btnRetryLevel.y + btnRetryLevel.height + buttonGap;
		btnQuit.allowCollisions = FlxObject.NONE;
		
		PlayerMessage = new FlxText(btnNextLevel.x + (btnNextLevel.width / 2) - 250, btnNextLevel.y - 40, 500, "", 18);
		PlayerMessage.setFormat(18, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.NONE, FlxColor.RED);
		PlayerMessage.allowCollisions = FlxObject.NONE;
		PlayerMessage.scrollFactor.set(0, 0);
		if (playerWins){
			PlayerMessage.text = "You win!!";
		}else{
			PlayerMessage.text = "You are dead!!";
		}
		
		backGround = new FlxSprite(btnNextLevel.x + (btnNextLevel.width/2) - backGroundWidth / 2, PlayerMessage.y - 30);
		backGround.makeGraphic(backGroundWidth, backGroundHeigth, FlxColor.BLACK);
		backGround.alpha = 0.4;
		backGround.scrollFactor.set(0, 0);
		backGround.allowCollisions = FlxObject.NONE;
		
		add(backGround);
		add(PlayerMessage);
		add(btnNextLevel);
		add(btnRetryLevel);
		add(btnQuit);
	
	}

	public function updateHUD():Void
	{
		var pLife = GlobalGameData.player.playerCurrentLife;
		var i = 0;
		while (i < sprHealthArray.length){
			if ( i + 1 <= pLife){
				sprHealthArray[i].visible = true;
			}else{
				sprHealthArray[i].visible = false;
			}
			i++;
		}
	}
	
	public function updateVisualizer():Void
	{
		var aGun = GlobalGameData.player.playerCurrentGun;
		if (Type.getClass(aGun) == Pistol){
			gunSprite.loadGraphic(Assets.getBitmapData("img/guns/pistol/p_pick.png"), false, 45, 27);
		}else if (Type.getClass(aGun) == Shotgun){
			gunSprite.loadGraphic(Assets.getBitmapData("img/guns/shotgun/shot_pick.png"), false, 76, 27);
		}else {
			gunSprite.loadGraphic(Assets.getBitmapData("img/guns/smg/smg_pick.png"), false, 76, 27);
		}
		bulletInChamber.text = aGun.currentInChamber + "/" + aGun.chamberLength;
		
	}
	
	
	private function reloadState():Void
	{
		FlxG.switchState(new PlayState());
	}
	
	private function nextLevel():Void
	{
		//FlxG.switchState(new PlayState());
	}
	
	private function BackToMenu():Void
	{
		FlxG.switchState(new MenuState());
	}

	
	
}