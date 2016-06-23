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
import openfl.Assets;
import openfl.text.Font;
import states.MenuState;
import states.PlayState;

/**
 * ...
 * @author Gaston Marichal / Ignacio Benedetto
 */
class HUD extends FlxTypedGroup<FlxSprite>
{
	/*______Background______*/
	private var sprBackground: FlxSprite;
	
	/*______Player Health______*/
	private var sprHealthArray: Array<FlxSprite>;
		
	/*_____level details_____*/
	private var txtLvlInfo: FlxText;
	private var lvlDesc:String;

	/*_______Messages and Buttons_______*/
	private var PlayerMessage: FlxText ;
	private var retryButton: FlxButton;
	private var BackToMenuButton: FlxButton;
		
	/*__________Gun visualizer____________*/
	private var visualizerBackground: FlxSprite;
	private var gunSprite: FlxSprite;
	private var bulletInChamber: FlxText;
	
	
	public function new(aLvlNumber:Int, aLvlString:String) 
	{
		super();
		//BackGround
		sprBackground = new FlxSprite();
		sprBackground.makeGraphic(FlxG.width, 40, FlxColor.BLACK);
		sprBackground.alpha = 0.2;
		FlxSpriteUtil.drawRect(sprBackground, 0, 37, FlxG.width, 3, FlxColor.WHITE);
		add(sprBackground);
		
		lvlDesc = "Level: " + aLvlNumber + " (" + aLvlString + ")";
		txtLvlInfo = new FlxText(FlxG.width / 2, 2, 0, lvlDesc, 18);
		txtLvlInfo.color = FlxColor.GRAY;
		txtLvlInfo.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.WHITE, 1, 1);
		add(txtLvlInfo);
		
		//PLayerHealth
		sprHealthArray = new Array<FlxSprite>();
		var gap: Int = 20;
		for (i in 0...GlobalGameData.player.playerTotalLife)
		{
			var h = new FlxSprite(gap, 5);
			h.loadGraphic(Assets.getBitmapData("img/sprite_0.png"), false, 32, 32);
			add(h);
			sprHealthArray.insert(i, h);
			gap += 30;
			
		}
		
		
		PlayerMessage = new FlxText(0, 200, 500, "", 24);
		PlayerMessage.setFormat(24, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.NONE, FlxColor.RED);
		PlayerMessage.screenCenter();
		PlayerMessage.visible = false;
		add(PlayerMessage);
		
		
		retryButton = new FlxButton(0, 0, "Retry", reloadState);
		retryButton.screenCenter(FlxAxes.X);
		retryButton.y = PlayerMessage.y + 50;
		retryButton.visible = false;
		add(retryButton);
		
		BackToMenuButton = new FlxButton(0, 0, "Back to Menu", BackToMenu);
		BackToMenuButton.screenCenter(FlxAxes.X);
		BackToMenuButton.y = retryButton.y + 50;
		BackToMenuButton.visible = false;
		add(retryButton);
		
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
		
		updateVisualizer();
		
		forEach(function(spr:FlxSprite)
		{
			spr.scrollFactor.set(0, 0);
		});
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
		if (GlobalGameData.player.playerCurrentLife <= 0){
			playerIsDead();
		}
		
	}
	
	public function updateVisualizer():Void
	{
		var aGun = GlobalGameData.player.playerCurrentGun;
		if (Type.getClass(aGun) == Pistol){
			gunSprite.loadGraphic(Assets.getBitmapData("img/guns/pistol/p_pick.png"), false, 45, 27);
		}else{
			gunSprite.loadGraphic(Assets.getBitmapData("img/guns/shotgun/shot_pick.png"), false, 76, 27);
		}
		bulletInChamber.text = aGun.currentInChamber + "/" + aGun.chamberLength;
		
	}
	
	public function playerWin():Void
	{
		PlayerMessage.text = "You Win!!";
		showActions();
	}
	
	private function playerIsDead():Void
	{
		PlayerMessage.text = "You are dead!!";
		showActions();
	}
		
		private function reloadState():Void
		{
			FlxG.switchState(new PlayState());
		}
		
		private function BackToMenu():Void
		{
			FlxG.switchState(new MenuState());
		}
	
		private function showActions():Void
		{
			PlayerMessage.visible = true;
			PlayerMessage.alpha = 1;
			retryButton.visible = true;
			retryButton.alpha = 1;
			BackToMenuButton.visible = true;
			BackToMenuButton.alpha = 1;
		}
}