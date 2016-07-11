package;

import gameObjects.enemies.Enemy;
import gameObjects.enemies.BossEnemy;
import gameObjects.enemies.GreenOrc;
import gameObjects.enemies.PistolPete;
import gameObjects.enemies.Skeleton;
import gameObjects.enemies.Summoner;

/**
*@author Ignacio Benedetto
**/

class EnemyFactory
{

    public function new()
    {

    }

    public static function getEnemy(type: String, X:Int = 0, Y:Int = 0):Enemy
    {
      switch(type)
      {
        case "greenOrc":
            return new GreenOrc(X,Y);
        case "skelleton":
            return new Skeleton(X,Y);
        case "summoner":
            return new Summoner(X, Y);
		case "boss":
			return new BossEnemy(X,Y);
      }
      return null;
    }
}
