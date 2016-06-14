package;

import flixel.FlxSprite;
import gameObjects.pickups.IPickable;
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

    public static function getPickup(type: String, X:Int = 0, Y:Int = 0):FlxSprite
    {
      switch(type)
      {
        case "pistol":
            return new PistolPickup(X,Y);
        case "shotgun":
            return new ShotgunPickup(X,Y);
        case "health":
            return new HealthPickup(X,Y);

      }
      return null;
    }
}
