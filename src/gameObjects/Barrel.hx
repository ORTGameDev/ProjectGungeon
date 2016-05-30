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
		loadGraphic(Assets.getBitmapData("barrels/Barrel.png"), true, 19, 25);
		animation.add("idle", [0,], 15);
		animation.add("x", [0,1,2,3,4,], 15,false);
		barrelEmitter = new FlxEmitter(aX + 15, aY + 20);
		barrelEmitter.allowCollisions = FlxObject.ANY;
		FlxG.state.add(this);
		FlxG.state.add(barrelEmitter);
		animation.play("idle");
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
		if (animation.curAnim.name == "x") {  // Si la animación es de activado
			if (animation.curAnim.finished) { // Al finalizar la animación oculto el barril
				this.visible = false;
			}
		}
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
			animation.play("x");
		}
		
		
	}
	
}