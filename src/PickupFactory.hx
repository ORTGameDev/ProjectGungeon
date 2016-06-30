package;

import flixel.FlxSprite;
import gameObjects.pickups.Pickup;
import gameObjects.pickups.HealthPickup;
import gameObjects.pickups.ShotgunPickup;
import gameObjects.pickups.SmgPickup;

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
        //case "pistol":
          //  ret = GlobalGameData.pickups.recycle(PistolPickup);
		  //NO HAY PICKUP DE PISTOL POR SER EL ARMA POR DEFECTO
        case "shotgun":
            ret = GlobalGameData.pickups.recycle(ShotgunPickup);
        case "health":
            ret = GlobalGameData.pickups.recycle(HealthPickup);

      }
	  ret.reset(X, Y);
      return ret;
    }
}
