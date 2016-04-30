package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Gaston Marichal / Ignacio Benedetto
 */
class HUD extends FlxTypedGroup<FlxSprite>
{
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
		
		txtPlayerHealth = new FlxText(16, 2, 0, "Life: 3 / 3", 8);
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
		forEach(function(spr:FlxSprite)
		{
			spr.scrollFactor.set(0, 0);
		});
		
	}
	
	public function updateHUD(health:Int = 0, totalHealth = 0):Void
	{
		var anAtlas = FlxAtlasFrames.fromTexturePackerJson("img/atlas/spritesheet.png", "img/atlas/spritemap.json");
		var playerLife = GlobalGameData.player.playerLife;
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
		//this.add(sprHealth);
		
	}
	
	
	
	
}