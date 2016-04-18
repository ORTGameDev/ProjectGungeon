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
	private var txtHealth: FlxText;
	private var sprHealth: FlxTypedGroup<FlxSprite>;

	public function new() 
	{
		super();
		sprBack = new FlxSprite().makeGraphic(FlxG.width, 20, FlxColor.TRANSPARENT);
		FlxSpriteUtil.drawRect(sprBack, 0, 19, FlxG.width, 1, FlxColor.WHITE);
		//txtHealth = new FlxText(16, 2, 0, "3 / 3", 8);
		//txtHealth.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		add(sprBack);
		//add(txtHealth);
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