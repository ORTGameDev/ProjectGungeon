package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
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
	//background
	private var sprBackground: FlxSprite;
	
	//player Health
	private var sprHealthArray: Array<FlxSprite>;
	
	
	//level details
	private var txtLvlInfo: FlxText;
	private var lvlDesc:String;

	//Messages and Buttons
	private var PlayerMessage: FlxText ;
	private var retryButton: FlxButton;
	private var BackToMenuButton: FlxButton;
	
	
	public function new(aLvlNumber:Int, aLvlString:String) 
	{
		super();
		//BackGround
		sprBackground = new FlxSprite();
		sprBackground.makeGraphic(FlxG.width, 40, FlxColor.BLACK);
		sprBackground.alpha = 0.2;
		FlxSpriteUtil.drawRect(sprBackground, 0, 37, FlxG.width, 3, FlxColor.WHITE);
		
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
		
		
		lvlDesc = "Level: " + aLvlNumber + " (" + aLvlString + ")";
		txtLvlInfo = new FlxText(FlxG.width/2, 2, 0, lvlDesc, 8);
		txtLvlInfo.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		
		
		add(sprBackground);
		
		add(txtLvlInfo);
		
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
		//txtPlayerHealth.text = "Life: " + GlobalGameData.player.playerCurrentLife + " /" + GlobalGameData.player.playerTotalLife;
		/*var anAtlas = FlxAtlasFrames.fromTexturePackerJson("img/atlas/spritesheet.png", "img/atlas/spritemap.json");
		var playerLife = GlobalGameData.player.playerCurrentLife;
		var heartQty = playerLife / 2;
		var healthX:Float = 10;
		var healthY:Float = 10;
		while (playerLife != 0)
		{
			var sprLife = new FlxSprite();
			sprLife.frames = anAtlas;
			if ( playerLife > 1)
			{
				sprLife.animation.addByPrefix("fullHeart", "heart_full", 0, false);
			}
			else
			{
				sprLife.animation.addByPrefix("halfHeart", "heart_half", 0, false);
			}
			sprLife.y = healthY;
			sprLife.x = healthX;
			sprHealth.add(sprLife);
			healthX += sprLife.width + 2;
		}
		this.add(sprHealth);*/
		if (GlobalGameData.player.playerCurrentLife <= 0){
			playerIsDead();
		}
		
		
		
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