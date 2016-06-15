package;

import flixel.FlxSprite;
import gameObjects.pickups.Pickup;
import gameObjects.pickups.HealthPickup;
import gameObjects.pickups.PistolPickup;
import gameObjects.pickups.ShotgunPickup;

/**
*@author Ignacio Benedetto
**/

class PickupFactory
{

    public function new()
    {

    }

    public static function getPickup(type: String, ?X:Float = 0, ?Y:Float = 0):Pickup
    {
	  var ret = null;
      switch(type)
      {
        case "pistol":
            ret = GlobalGameData.pickups.recycle(PistolPickup);
        case "shotgun":
            ret = GlobalGameData.pickups.recycle(ShotgunPickup);
        case "health":
            ret = GlobalGameData.pickups.recycle(HealthPickup);

      }
	  ret.reset(X, Y);
      return ret;
    }
}
