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
import openfl.text.Font;
import states.PlayState;

/**
 * ...
 * @author Gaston Marichal / Ignacio Benedetto
 */
class HUD extends FlxTypedGroup<FlxSprite>
{
	
	private var PlayerMessage: FlxText ;
	private var retryButton: FlxButton;
	
	private var sprBack: FlxSprite;
	private var txtPlayerHealth: FlxText;
	private var txtLvlInfo: FlxText;
	
	private var sprHealth: FlxTypedGroup<FlxSprite>;
	
	private var lvlDesc:String;

	public function new(aLvlNumber:Int, aLvlString:String) 
	{
		super();
		sprBack = new FlxSprite().makeGraphic(FlxG.width, 20, FlxColor.TRANSPARENT);
		FlxSpriteUtil.drawRect(sprBack, 0, 19, FlxG.width, 2, FlxColor.WHITE);
		
		txtPlayerHealth = new FlxText(16, 2, 0, "Life: ", 8);
		txtPlayerHealth.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		lvlDesc = "Level: " + aLvlNumber + " (" + aLvlString + ")";
		txtLvlInfo = new FlxText(FlxG.width/2, 2, 0, lvlDesc, 8);
		txtLvlInfo.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		
		sprHealth = new FlxTypedGroup<FlxSprite>();
		sprHealth.add(sprBack);
		sprHealth.add(txtPlayerHealth);
		sprHealth.add(txtLvlInfo);
		add(sprBack);
		add(txtPlayerHealth);
		add(txtLvlInfo);
		
		PlayerMessage = new FlxText(0, 200, 500, "", 24);
		PlayerMessage.setFormat(24, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.NONE, FlxColor.RED);
		PlayerMessage.screenCenter();
		PlayerMessage.visible = false;
		sprHealth.add(PlayerMessage);
		add(PlayerMessage);
		
		retryButton = new FlxButton(0, 0, "Retry", reloadState);
		retryButton.screenCenter(FlxAxes.X);
		retryButton.y = PlayerMessage.y + 50;
		retryButton.visible = false;
		sprHealth.add(retryButton);
		add(retryButton);
		
		forEach(function(spr:FlxSprite)
		{
			spr.scrollFactor.set(0, 0);
		});
		
	}
	
	public function playerWin():Void
	{
		PlayerMessage.text = "You Win!!";
		PlayerMessage.visible = true;
		retryButton.visible = true;
	}
	
	public function updateHUD():Void
	{
		txtPlayerHealth.text = "Life: " + GlobalGameData.player.playerCurrentLife + " /" + GlobalGameData.player.playerTotalLife;
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
	
		private function playerIsDead():Void
		{
			PlayerMessage.text = "You are dead!!";
				PlayerMessage.visible = true;
				PlayerMessage.alpha = 1;
				retryButton.visible = true;
				retryButton.alpha = 1;
		}
		
		private function reloadState():Void
		{
			FlxG.switchState(new PlayState());
		}
	
}