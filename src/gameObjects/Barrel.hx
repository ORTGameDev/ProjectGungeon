package gameObjects;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import openfl.Assets;
import openfl.Lib;

/**
 * ...
 * @author Gastón Marichal
 */
class Barrel extends FlxSprite
{
	private var barrelEmitter: FlxEmitter;
	private var activated: Bool = false;
	
	
	private static inline var damage: Int = 1;
	private var lifeTime: Int = 0;	
	private var barrelSound: FlxSound;

	public function new(aX:Float, aY:Float) 
	{
		super(aX, aY);
		barrelSound = FlxG.sound.load("sounds/barrelExplotion.mp3");
		barrelEmitter = new FlxEmitter(aX + 15, aY + 20);
		barrelEmitter.allowCollisions = FlxObject.ANY;
		this.makeGraphic(30, 40, FlxColor.BROWN);
		FlxG.state.add(this);
		FlxG.state.add(barrelEmitter);
		
		for (i in 0 ... 10)
        {
        	var p = new FlxParticle();
			p.lifespan = 10;
			p.set_allowCollisions(1);
			p.loadGraphic(Assets.getBitmapData("img/bullets/Bullets002.png"), true, 11, 11);
        	//p.exists = false;
        	barrelEmitter.add(p);
			GlobalGameData.particles.add(p);
        }
		FlxG.state.add(this);
		
		
	}
	
	override public function update (elapsed: Float):Void
	{
		super.update(elapsed);
		if (activated && (Lib.getTimer() > lifeTime + 3000)) { //Emitter ends
			barrelEmitter.destroy();
			this.destroy();
		}
		
	}
	
	public function explote(): Void
	{
		if (!activated) {
			activated = true;
			lifeTime = Lib.getTimer();
			barrelSound.play();
			barrelEmitter.start(true, 1, 10);
			this.visible = false;
		}
		
		
	}
	
}