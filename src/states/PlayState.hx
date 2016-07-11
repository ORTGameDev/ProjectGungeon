package states;
import GlobalGameData;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.effects.particles.FlxParticle;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import gameObjects.Barrel;
import gameObjects.Pointer;
import gameObjects.enemies.Enemy;
import gameObjects.guns.bullets.Bullet;
import gameObjects.pickups.Pickup;
import gameObjects.players.Player;
import level.LevelManager;


/**
 * ...
 * @author Gastón Marichal
 */
class PlayState extends FlxState {
	//level
	public var level:LevelManager;

	//Cursor+
	private var gamePointer:Pointer;

	//HUD + UI
	private var hud:HUD;
	
	private var gameOver: Bool = false;

	public function new() {
		super();
	}

	override public function create():Void {
		level = new level.LevelManager("maps/level4/level4.tmx", this);
		// Add floor
		add(level.floorLayer);
		// Add objects
		add(level.objectsLayer);
		add(level.characterGroup);
		add(level.enemiesGroup);
		// Add foreground tiles after adding level objects, so these tiles render on top of player
		add(level.foregroundLayer);
		add(level.collidableLayer);
		add(level.hud);
		changeGamePointer();
	}

	override public function update(elapsed:Float):Void {
		level.update(elapsed);
		super.update(elapsed);
		if (!gameOver) {
			if (GlobalGameData.player.playerCurrentLife <= 0){
				gameOver = true;
				GlobalGameData.aHud.createPlayMenu(false);
			}else if (GlobalGameData.enemies.countLiving() == 0)
			{
				gameOver = true;
				GlobalGameData.aHud.createPlayMenu(true);
			}
		}
	}
	
	private function changeGamePointer() {
		gamePointer = new Pointer();
		gamePointer.allowCollisions = FlxObject.NONE;
		FlxG.mouse.visible = false;
		FlxG.mouse.hideSystemCursor();
		add(gamePointer);
	}

}
