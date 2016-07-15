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

	

	public function new(startLevel:Dynamic) {
		super();
		GlobalGameData.levelNbr = startLevel;
	}

	override public function create():Void {
		
		level = new level.LevelManager(GlobalGameData.levelNbr);
		// Add floor
		add(level.floorLayer);
		add(level.decoLayer);
		
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
		
	}
	
	private function changeGamePointer() {
		gamePointer = new Pointer();
		gamePointer.allowCollisions = FlxObject.NONE;
		FlxG.mouse.visible = false;
		FlxG.mouse.hideSystemCursor();
		add(gamePointer);
	}

}
