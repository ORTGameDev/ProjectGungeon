package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("flixel/sounds/beep.ogg", "flixel/sounds/beep.ogg");
			type.set ("flixel/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/sounds/flixel.ogg", "flixel/sounds/flixel.ogg");
			type.set ("flixel/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/fonts/nokiafc22.ttf", "flixel/fonts/nokiafc22.ttf");
			type.set ("flixel/fonts/nokiafc22.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/fonts/monsterrat.ttf", "flixel/fonts/monsterrat.ttf");
			type.set ("flixel/fonts/monsterrat.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/images/ui/button.png", "flixel/images/ui/button.png");
			type.set ("flixel/images/ui/button.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/atlas/spritemap.json", "img/atlas/spritemap.json");
			type.set ("img/atlas/spritemap.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/atlas/spritesheet.png", "img/atlas/spritesheet.png");
			type.set ("img/atlas/spritesheet.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/bullets/simpleBullet.png", "img/bullets/simpleBullet.png");
			type.set ("img/bullets/simpleBullet.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/diagdown1.png", "img/characters/diagdown1.png");
			type.set ("img/characters/diagdown1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/diagdown2.png", "img/characters/diagdown2.png");
			type.set ("img/characters/diagdown2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/diagdown3.png", "img/characters/diagdown3.png");
			type.set ("img/characters/diagdown3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/diagup1.png", "img/characters/diagup1.png");
			type.set ("img/characters/diagup1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/diagup2.png", "img/characters/diagup2.png");
			type.set ("img/characters/diagup2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/diagup3.png", "img/characters/diagup3.png");
			type.set ("img/characters/diagup3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/enemyDead.png", "img/characters/enemyDead.png");
			type.set ("img/characters/enemyDead.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/jason.png", "img/characters/jason.png");
			type.set ("img/characters/jason.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/north1.png", "img/characters/north1.png");
			type.set ("img/characters/north1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/north2.png", "img/characters/north2.png");
			type.set ("img/characters/north2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/north3.png", "img/characters/north3.png");
			type.set ("img/characters/north3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/side1.png", "img/characters/side1.png");
			type.set ("img/characters/side1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/side2.png", "img/characters/side2.png");
			type.set ("img/characters/side2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/side3.png", "img/characters/side3.png");
			type.set ("img/characters/side3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/south1.png", "img/characters/south1.png");
			type.set ("img/characters/south1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/south2.png", "img/characters/south2.png");
			type.set ("img/characters/south2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/south21.png", "img/characters/south21.png");
			type.set ("img/characters/south21.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/south22.png", "img/characters/south22.png");
			type.set ("img/characters/south22.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/south23.png", "img/characters/south23.png");
			type.set ("img/characters/south23.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/south3.png", "img/characters/south3.png");
			type.set ("img/characters/south3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/start1.png", "img/characters/start1.png");
			type.set ("img/characters/start1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/start2.png", "img/characters/start2.png");
			type.set ("img/characters/start2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/characters/start3.png", "img/characters/start3.png");
			type.set ("img/characters/start3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/guns/pistol/p_diagdown.png", "img/guns/pistol/p_diagdown.png");
			type.set ("img/guns/pistol/p_diagdown.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/guns/pistol/p_diagup.png", "img/guns/pistol/p_diagup.png");
			type.set ("img/guns/pistol/p_diagup.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/guns/pistol/p_down.png", "img/guns/pistol/p_down.png");
			type.set ("img/guns/pistol/p_down.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/guns/pistol/p_side.png", "img/guns/pistol/p_side.png");
			type.set ("img/guns/pistol/p_side.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/guns/pistol/p_up.png", "img/guns/pistol/p_up.png");
			type.set ("img/guns/pistol/p_up.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/guns/shotgun/shot_diagdown.png", "img/guns/shotgun/shot_diagdown.png");
			type.set ("img/guns/shotgun/shot_diagdown.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/guns/shotgun/shot_diagup.png", "img/guns/shotgun/shot_diagup.png");
			type.set ("img/guns/shotgun/shot_diagup.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/guns/shotgun/shot_down.png", "img/guns/shotgun/shot_down.png");
			type.set ("img/guns/shotgun/shot_down.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/guns/shotgun/shot_side.png", "img/guns/shotgun/shot_side.png");
			type.set ("img/guns/shotgun/shot_side.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/guns/shotgun/shot_up.png", "img/guns/shotgun/shot_up.png");
			type.set ("img/guns/shotgun/shot_up.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/logo.png", "img/logo.png");
			type.set ("img/logo.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/maps/level1.csv", "img/maps/level1.csv");
			type.set ("img/maps/level1.csv", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/maps/level1.oel", "img/maps/level1.oel");
			type.set ("img/maps/level1.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/maps/levelOne.oel", "img/maps/levelOne.oel");
			type.set ("img/maps/levelOne.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/maps/lvl1.csv", "img/maps/lvl1.csv");
			type.set ("img/maps/lvl1.csv", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/maps/mapTiles.png", "img/maps/mapTiles.png");
			type.set ("img/maps/mapTiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/maps/mapTiles_olg.png", "img/maps/mapTiles_olg.png");
			type.set ("img/maps/mapTiles_olg.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/maps/tilemap.png", "img/maps/tilemap.png");
			type.set ("img/maps/tilemap.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/maps/tilemapdata.csv", "img/maps/tilemapdata.csv");
			type.set ("img/maps/tilemapdata.csv", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("img/pointer/crosshairBig.png", "img/pointer/crosshairBig.png");
			type.set ("img/pointer/crosshairBig.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("img/pointer/crosshairSmall.png", "img/pointer/crosshairSmall.png");
			type.set ("img/pointer/crosshairSmall.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("pointer/crosshairBig.png", "pointer/crosshairBig.png");
			type.set ("pointer/crosshairBig.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("pointer/crosshairSmall.png", "pointer/crosshairSmall.png");
			type.set ("pointer/crosshairSmall.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/diagdown1.png", "characters/diagdown1.png");
			type.set ("characters/diagdown1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/diagdown2.png", "characters/diagdown2.png");
			type.set ("characters/diagdown2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/diagdown3.png", "characters/diagdown3.png");
			type.set ("characters/diagdown3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/diagup1.png", "characters/diagup1.png");
			type.set ("characters/diagup1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/diagup2.png", "characters/diagup2.png");
			type.set ("characters/diagup2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/diagup3.png", "characters/diagup3.png");
			type.set ("characters/diagup3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/enemyDead.png", "characters/enemyDead.png");
			type.set ("characters/enemyDead.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/jason.png", "characters/jason.png");
			type.set ("characters/jason.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/north1.png", "characters/north1.png");
			type.set ("characters/north1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/north2.png", "characters/north2.png");
			type.set ("characters/north2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/north3.png", "characters/north3.png");
			type.set ("characters/north3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/side1.png", "characters/side1.png");
			type.set ("characters/side1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/side2.png", "characters/side2.png");
			type.set ("characters/side2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/side3.png", "characters/side3.png");
			type.set ("characters/side3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/south1.png", "characters/south1.png");
			type.set ("characters/south1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/south2.png", "characters/south2.png");
			type.set ("characters/south2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/south21.png", "characters/south21.png");
			type.set ("characters/south21.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/south22.png", "characters/south22.png");
			type.set ("characters/south22.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/south23.png", "characters/south23.png");
			type.set ("characters/south23.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/south3.png", "characters/south3.png");
			type.set ("characters/south3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/start1.png", "characters/start1.png");
			type.set ("characters/start1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/start2.png", "characters/start2.png");
			type.set ("characters/start2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("characters/start3.png", "characters/start3.png");
			type.set ("characters/start3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("sounds/music/01_labyrinth.mp3", "sounds/music/01_labyrinth.mp3");
			type.set ("sounds/music/01_labyrinth.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("sounds/ShotgunShot.mp3", "sounds/ShotgunShot.mp3");
			type.set ("sounds/ShotgunShot.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("sounds/simpleGunShot.mp3", "sounds/simpleGunShot.mp3");
			type.set ("sounds/simpleGunShot.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("music/01_labyrinth.mp3", "music/01_labyrinth.mp3");
			type.set ("music/01_labyrinth.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
