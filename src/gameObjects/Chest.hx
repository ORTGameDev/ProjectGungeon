package gameObjects;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import openfl.Assets;

/**
 * ...
 * @author Gaston // Nacho
 */
class Chest extends FlxSprite
{
	private var gunPerc = 0.30;
	private var healthPerc = 0.10;
	private var explodePerc = 0.05;
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(Assets.getBitmapData("img/chest.png"), true, 64, 64);
		animation.add("closed", [0]);
		animation.add("opened", [1]);
		animation.play("closed");		
	}
	
	public function open():Void{
		animation.play("opened");
		var pickupProb = Math.random();
		if (pickupProb <= healthPerc) {
			var aPickup = PickupFactory.getPickup("health", this.x - 15, this.y - 5);
		} 
		if (pickupProb <= gunPerc) {
			var aPickup = PickupFactory.getPickup("shotgun", this.x + 15, this.y + 5);
		}
		if (pickupProb > gunPerc && pickupProb < explodePerc) {
			var aExplotion = GlobalGameData.explotions.recycle(Explotion);
			aExplotion.reset(this.x + this.width / 2, this.y + this.height);
			this.kill();
		}
		
	}
	
}