package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Future;
import lime.app.Preloader;
import lime.app.Promise;
import lime.audio.AudioSource;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Image;
import lime.net.HTTPRequest;
import lime.system.CFFI;
import lime.text.Font;
import lime.utils.Bytes;
import lime.utils.UInt8Array;
import lime.Assets;

#if sys
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if (openfl && !flash)
		
		
		
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		#end
		
		#if flash
		
		className.set ("flixel/sounds/beep.mp3", __ASSET__flixel_sounds_beep_mp3);
		type.set ("flixel/sounds/beep.mp3", AssetType.MUSIC);
		className.set ("flixel/sounds/flixel.mp3", __ASSET__flixel_sounds_flixel_mp3);
		type.set ("flixel/sounds/flixel.mp3", AssetType.MUSIC);
		className.set ("flixel/fonts/nokiafc22.ttf", __ASSET__flixel_fonts_nokiafc22_ttf);
		type.set ("flixel/fonts/nokiafc22.ttf", AssetType.FONT);
		className.set ("flixel/fonts/monsterrat.ttf", __ASSET__flixel_fonts_monsterrat_ttf);
		type.set ("flixel/fonts/monsterrat.ttf", AssetType.FONT);
		className.set ("flixel/images/ui/button.png", __ASSET__flixel_images_ui_button_png);
		type.set ("flixel/images/ui/button.png", AssetType.IMAGE);
		className.set ("img/atlas/enemies/Boss.png", __ASSET__img_atlas_enemies_boss_png);
		type.set ("img/atlas/enemies/Boss.png", AssetType.IMAGE);
		className.set ("img/atlas/enemies/GreenOrc.json", __ASSET__img_atlas_enemies_greenorc_json);
		type.set ("img/atlas/enemies/GreenOrc.json", AssetType.TEXT);
		className.set ("img/atlas/enemies/GreenOrc.png", __ASSET__img_atlas_enemies_greenorc_png);
		type.set ("img/atlas/enemies/GreenOrc.png", AssetType.IMAGE);
		className.set ("img/atlas/enemies/Skeleton.json", __ASSET__img_atlas_enemies_skeleton_json);
		type.set ("img/atlas/enemies/Skeleton.json", AssetType.TEXT);
		className.set ("img/atlas/enemies/Skeleton.png", __ASSET__img_atlas_enemies_skeleton_png);
		type.set ("img/atlas/enemies/Skeleton.png", AssetType.IMAGE);
		className.set ("img/atlas/enemies/Summoner.json", __ASSET__img_atlas_enemies_summoner_json);
		type.set ("img/atlas/enemies/Summoner.json", AssetType.TEXT);
		className.set ("img/atlas/enemies/Summoner.png", __ASSET__img_atlas_enemies_summoner_png);
		type.set ("img/atlas/enemies/Summoner.png", AssetType.IMAGE);
		className.set ("img/atlas/players/PlayerOne.json", __ASSET__img_atlas_players_playerone_json);
		type.set ("img/atlas/players/PlayerOne.json", AssetType.TEXT);
		className.set ("img/atlas/players/PlayerOne.png", __ASSET__img_atlas_players_playerone_png);
		type.set ("img/atlas/players/PlayerOne.png", AssetType.IMAGE);
		className.set ("img/atlas/spritemap.json", __ASSET__img_atlas_spritemap_json);
		type.set ("img/atlas/spritemap.json", AssetType.TEXT);
		className.set ("img/atlas/spritesheet.png", __ASSET__img_atlas_spritesheet_png);
		type.set ("img/atlas/spritesheet.png", AssetType.IMAGE);
		className.set ("img/barrels/Barrel.png", __ASSET__img_barrels_barrel_png);
		type.set ("img/barrels/Barrel.png", AssetType.IMAGE);
		className.set ("img/barrels/explosion_01.png", __ASSET__img_barrels_explosion_01_png);
		type.set ("img/barrels/explosion_01.png", AssetType.IMAGE);
		className.set ("img/barrels/explosion_02.png", __ASSET__img_barrels_explosion_02_png);
		type.set ("img/barrels/explosion_02.png", AssetType.IMAGE);
		className.set ("img/barrels/explosion_03.png", __ASSET__img_barrels_explosion_03_png);
		type.set ("img/barrels/explosion_03.png", AssetType.IMAGE);
		className.set ("img/bullets/Bullets001.png", __ASSET__img_bullets_bullets001_png);
		type.set ("img/bullets/Bullets001.png", AssetType.IMAGE);
		className.set ("img/bullets/Bullets002.png", __ASSET__img_bullets_bullets002_png);
		type.set ("img/bullets/Bullets002.png", AssetType.IMAGE);
		className.set ("img/bullets/Bullets003.png", __ASSET__img_bullets_bullets003_png);
		type.set ("img/bullets/Bullets003.png", AssetType.IMAGE);
		className.set ("img/guns/pistol/p_diagdown.png", __ASSET__img_guns_pistol_p_diagdown_png);
		type.set ("img/guns/pistol/p_diagdown.png", AssetType.IMAGE);
		className.set ("img/guns/pistol/p_diagup.png", __ASSET__img_guns_pistol_p_diagup_png);
		type.set ("img/guns/pistol/p_diagup.png", AssetType.IMAGE);
		className.set ("img/guns/pistol/p_down.png", __ASSET__img_guns_pistol_p_down_png);
		type.set ("img/guns/pistol/p_down.png", AssetType.IMAGE);
		className.set ("img/guns/pistol/p_pick - Copy.png", __ASSET__img_guns_pistol_p_pick___copy_png);
		type.set ("img/guns/pistol/p_pick - Copy.png", AssetType.IMAGE);
		className.set ("img/guns/pistol/p_pick.png", __ASSET__img_guns_pistol_p_pick_png);
		type.set ("img/guns/pistol/p_pick.png", AssetType.IMAGE);
		className.set ("img/guns/pistol/p_side.png", __ASSET__img_guns_pistol_p_side_png);
		type.set ("img/guns/pistol/p_side.png", AssetType.IMAGE);
		className.set ("img/guns/pistol/p_up.png", __ASSET__img_guns_pistol_p_up_png);
		type.set ("img/guns/pistol/p_up.png", AssetType.IMAGE);
		className.set ("img/guns/shotgun/shot_diagdown.png", __ASSET__img_guns_shotgun_shot_diagdown_png);
		type.set ("img/guns/shotgun/shot_diagdown.png", AssetType.IMAGE);
		className.set ("img/guns/shotgun/shot_diagup.png", __ASSET__img_guns_shotgun_shot_diagup_png);
		type.set ("img/guns/shotgun/shot_diagup.png", AssetType.IMAGE);
		className.set ("img/guns/shotgun/shot_down.png", __ASSET__img_guns_shotgun_shot_down_png);
		type.set ("img/guns/shotgun/shot_down.png", AssetType.IMAGE);
		className.set ("img/guns/shotgun/shot_pick - Copy.png", __ASSET__img_guns_shotgun_shot_pick___copy_png);
		type.set ("img/guns/shotgun/shot_pick - Copy.png", AssetType.IMAGE);
		className.set ("img/guns/shotgun/shot_pick.png", __ASSET__img_guns_shotgun_shot_pick_png);
		type.set ("img/guns/shotgun/shot_pick.png", AssetType.IMAGE);
		className.set ("img/guns/shotgun/shot_side.png", __ASSET__img_guns_shotgun_shot_side_png);
		type.set ("img/guns/shotgun/shot_side.png", AssetType.IMAGE);
		className.set ("img/guns/shotgun/shot_up.png", __ASSET__img_guns_shotgun_shot_up_png);
		type.set ("img/guns/shotgun/shot_up.png", AssetType.IMAGE);
		className.set ("img/guns/smg/smg_pick - Copy.png", __ASSET__img_guns_smg_smg_pick___copy_png);
		type.set ("img/guns/smg/smg_pick - Copy.png", AssetType.IMAGE);
		className.set ("img/guns/smg/smg_pick.png", __ASSET__img_guns_smg_smg_pick_png);
		type.set ("img/guns/smg/smg_pick.png", AssetType.IMAGE);
		className.set ("img/jarBreakable.png", __ASSET__img_jarbreakable_png);
		type.set ("img/jarBreakable.png", AssetType.IMAGE);
		className.set ("img/logo.png", __ASSET__img_logo_png);
		type.set ("img/logo.png", AssetType.IMAGE);
		className.set ("img/pointer/crosshairBig.png", __ASSET__img_pointer_crosshairbig_png);
		type.set ("img/pointer/crosshairBig.png", AssetType.IMAGE);
		className.set ("img/pointer/crosshairSmall.png", __ASSET__img_pointer_crosshairsmall_png);
		type.set ("img/pointer/crosshairSmall.png", AssetType.IMAGE);
		className.set ("img/sprite_0.png", __ASSET__img_sprite_0_png);
		type.set ("img/sprite_0.png", AssetType.IMAGE);
		className.set ("img/sprite_1.png", __ASSET__img_sprite_1_png);
		type.set ("img/sprite_1.png", AssetType.IMAGE);
		className.set ("img/sprite_2.png", __ASSET__img_sprite_2_png);
		type.set ("img/sprite_2.png", AssetType.IMAGE);
		className.set ("pointer/crosshairBig.png", __ASSET__pointer_crosshairbig_png);
		type.set ("pointer/crosshairBig.png", AssetType.IMAGE);
		className.set ("pointer/crosshairSmall.png", __ASSET__pointer_crosshairsmall_png);
		type.set ("pointer/crosshairSmall.png", AssetType.IMAGE);
		className.set ("barrels/Barrel.png", __ASSET__barrels_barrel_png);
		type.set ("barrels/Barrel.png", AssetType.IMAGE);
		className.set ("barrels/explosion_01.png", __ASSET__barrels_explosion_01_png);
		type.set ("barrels/explosion_01.png", AssetType.IMAGE);
		className.set ("barrels/explosion_02.png", __ASSET__barrels_explosion_02_png);
		type.set ("barrels/explosion_02.png", AssetType.IMAGE);
		className.set ("barrels/explosion_03.png", __ASSET__barrels_explosion_03_png);
		type.set ("barrels/explosion_03.png", AssetType.IMAGE);
		className.set ("sounds/barrelExplotion.mp3", __ASSET__sounds_barrelexplotion_mp3);
		type.set ("sounds/barrelExplotion.mp3", AssetType.MUSIC);
		className.set ("sounds/gunPickUp.mp3", __ASSET__sounds_gunpickup_mp3);
		type.set ("sounds/gunPickUp.mp3", AssetType.MUSIC);
		className.set ("sounds/healPickUp.mp3", __ASSET__sounds_healpickup_mp3);
		type.set ("sounds/healPickUp.mp3", AssetType.MUSIC);
		className.set ("sounds/LoadnShot.mp3", __ASSET__sounds_loadnshot_mp3);
		type.set ("sounds/LoadnShot.mp3", AssetType.MUSIC);
		className.set ("sounds/music/background.mp3", __ASSET__sounds_music_background_mp3);
		type.set ("sounds/music/background.mp3", AssetType.MUSIC);
		className.set ("sounds/pistolShot.mp3", __ASSET__sounds_pistolshot_mp3);
		type.set ("sounds/pistolShot.mp3", AssetType.MUSIC);
		className.set ("sounds/shotgunShot.mp3", __ASSET__sounds_shotgunshot_mp3);
		type.set ("sounds/shotgunShot.mp3", AssetType.MUSIC);
		className.set ("music/background.mp3", __ASSET__music_background_mp3);
		type.set ("music/background.mp3", AssetType.MUSIC);
		className.set ("maps/level1.tmx", __ASSET__maps_level1_tmx);
		type.set ("maps/level1.tmx", AssetType.TEXT);
		className.set ("maps/level2/level2.tmx", __ASSET__maps_level2_level2_tmx);
		type.set ("maps/level2/level2.tmx", AssetType.TEXT);
		className.set ("maps/level2/mapTiles.png", __ASSET__maps_level2_maptiles_png);
		type.set ("maps/level2/mapTiles.png", AssetType.IMAGE);
		className.set ("maps/level3/level2 - copia.tmx", __ASSET__maps_level3_level2___copia_tmx);
		type.set ("maps/level3/level2 - copia.tmx", AssetType.TEXT);
		className.set ("maps/level3/level3.tmx", __ASSET__maps_level3_level3_tmx);
		type.set ("maps/level3/level3.tmx", AssetType.TEXT);
		className.set ("maps/level3/mapTiles.png", __ASSET__maps_level3_maptiles_png);
		type.set ("maps/level3/mapTiles.png", AssetType.IMAGE);
		className.set ("maps/level4/level4.tmx", __ASSET__maps_level4_level4_tmx);
		type.set ("maps/level4/level4.tmx", AssetType.TEXT);
		className.set ("maps/level4/mapTiles.png", __ASSET__maps_level4_maptiles_png);
		type.set ("maps/level4/mapTiles.png", AssetType.IMAGE);
		className.set ("maps/level4/mapTiles_old.png", __ASSET__maps_level4_maptiles_old_png);
		type.set ("maps/level4/mapTiles_old.png", AssetType.IMAGE);
		className.set ("maps/mapTiles.png", __ASSET__maps_maptiles_png);
		type.set ("maps/mapTiles.png", AssetType.IMAGE);
		
		
		#elseif html5
		
		var id;
		id = "flixel/sounds/beep.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "flixel/sounds/flixel.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "flixel/fonts/nokiafc22.ttf";
		className.set (id, __ASSET__flixel_fonts_nokiafc22_ttf);
		
		type.set (id, AssetType.FONT);
		id = "flixel/fonts/monsterrat.ttf";
		className.set (id, __ASSET__flixel_fonts_monsterrat_ttf);
		
		type.set (id, AssetType.FONT);
		id = "flixel/images/ui/button.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/atlas/enemies/Boss.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/atlas/enemies/GreenOrc.json";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "img/atlas/enemies/GreenOrc.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/atlas/enemies/Skeleton.json";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "img/atlas/enemies/Skeleton.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/atlas/enemies/Summoner.json";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "img/atlas/enemies/Summoner.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/atlas/players/PlayerOne.json";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "img/atlas/players/PlayerOne.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/atlas/spritemap.json";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "img/atlas/spritesheet.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/barrels/Barrel.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/barrels/explosion_01.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/barrels/explosion_02.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/barrels/explosion_03.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/bullets/Bullets001.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/bullets/Bullets002.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/bullets/Bullets003.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/guns/pistol/p_diagdown.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/guns/pistol/p_diagup.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/guns/pistol/p_down.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/guns/pistol/p_pick - Copy.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/guns/pistol/p_pick.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/guns/pistol/p_side.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/guns/pistol/p_up.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/guns/shotgun/shot_diagdown.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/guns/shotgun/shot_diagup.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/guns/shotgun/shot_down.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/guns/shotgun/shot_pick - Copy.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/guns/shotgun/shot_pick.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/guns/shotgun/shot_side.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/guns/shotgun/shot_up.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/guns/smg/smg_pick - Copy.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/guns/smg/smg_pick.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/jarBreakable.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/logo.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/pointer/crosshairBig.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/pointer/crosshairSmall.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/sprite_0.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/sprite_1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/sprite_2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "pointer/crosshairBig.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "pointer/crosshairSmall.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "barrels/Barrel.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "barrels/explosion_01.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "barrels/explosion_02.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "barrels/explosion_03.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "sounds/barrelExplotion.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "sounds/gunPickUp.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "sounds/healPickUp.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "sounds/LoadnShot.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "sounds/music/background.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "sounds/pistolShot.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "sounds/shotgunShot.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "music/background.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "maps/level1.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "maps/level2/level2.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "maps/level2/mapTiles.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "maps/level3/level2 - copia.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "maps/level3/level3.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "maps/level3/mapTiles.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "maps/level4/level4.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "maps/level4/mapTiles.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "maps/level4/mapTiles_old.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "maps/mapTiles.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		
		
		var assetsPrefix = null;
		if (ApplicationMain.config != null && Reflect.hasField (ApplicationMain.config, "assetsPrefix")) {
			assetsPrefix = ApplicationMain.config.assetsPrefix;
		}
		if (assetsPrefix != null) {
			for (k in path.keys()) {
				path.set(k, assetsPrefix + path[k]);
			}
		}
		
		#else
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("flixel/sounds/beep.mp3", __ASSET__flixel_sounds_beep_mp3);
		type.set ("flixel/sounds/beep.mp3", AssetType.MUSIC);
		
		className.set ("flixel/sounds/flixel.mp3", __ASSET__flixel_sounds_flixel_mp3);
		type.set ("flixel/sounds/flixel.mp3", AssetType.MUSIC);
		
		className.set ("flixel/fonts/nokiafc22.ttf", __ASSET__flixel_fonts_nokiafc22_ttf);
		type.set ("flixel/fonts/nokiafc22.ttf", AssetType.FONT);
		
		className.set ("flixel/fonts/monsterrat.ttf", __ASSET__flixel_fonts_monsterrat_ttf);
		type.set ("flixel/fonts/monsterrat.ttf", AssetType.FONT);
		
		className.set ("flixel/images/ui/button.png", __ASSET__flixel_images_ui_button_png);
		type.set ("flixel/images/ui/button.png", AssetType.IMAGE);
		
		className.set ("img/atlas/enemies/Boss.png", __ASSET__img_atlas_enemies_boss_png);
		type.set ("img/atlas/enemies/Boss.png", AssetType.IMAGE);
		
		className.set ("img/atlas/enemies/GreenOrc.json", __ASSET__img_atlas_enemies_greenorc_json);
		type.set ("img/atlas/enemies/GreenOrc.json", AssetType.TEXT);
		
		className.set ("img/atlas/enemies/GreenOrc.png", __ASSET__img_atlas_enemies_greenorc_png);
		type.set ("img/atlas/enemies/GreenOrc.png", AssetType.IMAGE);
		
		className.set ("img/atlas/enemies/Skeleton.json", __ASSET__img_atlas_enemies_skeleton_json);
		type.set ("img/atlas/enemies/Skeleton.json", AssetType.TEXT);
		
		className.set ("img/atlas/enemies/Skeleton.png", __ASSET__img_atlas_enemies_skeleton_png);
		type.set ("img/atlas/enemies/Skeleton.png", AssetType.IMAGE);
		
		className.set ("img/atlas/enemies/Summoner.json", __ASSET__img_atlas_enemies_summoner_json);
		type.set ("img/atlas/enemies/Summoner.json", AssetType.TEXT);
		
		className.set ("img/atlas/enemies/Summoner.png", __ASSET__img_atlas_enemies_summoner_png);
		type.set ("img/atlas/enemies/Summoner.png", AssetType.IMAGE);
		
		className.set ("img/atlas/players/PlayerOne.json", __ASSET__img_atlas_players_playerone_json);
		type.set ("img/atlas/players/PlayerOne.json", AssetType.TEXT);
		
		className.set ("img/atlas/players/PlayerOne.png", __ASSET__img_atlas_players_playerone_png);
		type.set ("img/atlas/players/PlayerOne.png", AssetType.IMAGE);
		
		className.set ("img/atlas/spritemap.json", __ASSET__img_atlas_spritemap_json);
		type.set ("img/atlas/spritemap.json", AssetType.TEXT);
		
		className.set ("img/atlas/spritesheet.png", __ASSET__img_atlas_spritesheet_png);
		type.set ("img/atlas/spritesheet.png", AssetType.IMAGE);
		
		className.set ("img/barrels/Barrel.png", __ASSET__img_barrels_barrel_png);
		type.set ("img/barrels/Barrel.png", AssetType.IMAGE);
		
		className.set ("img/barrels/explosion_01.png", __ASSET__img_barrels_explosion_01_png);
		type.set ("img/barrels/explosion_01.png", AssetType.IMAGE);
		
		className.set ("img/barrels/explosion_02.png", __ASSET__img_barrels_explosion_02_png);
		type.set ("img/barrels/explosion_02.png", AssetType.IMAGE);
		
		className.set ("img/barrels/explosion_03.png", __ASSET__img_barrels_explosion_03_png);
		type.set ("img/barrels/explosion_03.png", AssetType.IMAGE);
		
		className.set ("img/bullets/Bullets001.png", __ASSET__img_bullets_bullets001_png);
		type.set ("img/bullets/Bullets001.png", AssetType.IMAGE);
		
		className.set ("img/bullets/Bullets002.png", __ASSET__img_bullets_bullets002_png);
		type.set ("img/bullets/Bullets002.png", AssetType.IMAGE);
		
		className.set ("img/bullets/Bullets003.png", __ASSET__img_bullets_bullets003_png);
		type.set ("img/bullets/Bullets003.png", AssetType.IMAGE);
		
		className.set ("img/guns/pistol/p_diagdown.png", __ASSET__img_guns_pistol_p_diagdown_png);
		type.set ("img/guns/pistol/p_diagdown.png", AssetType.IMAGE);
		
		className.set ("img/guns/pistol/p_diagup.png", __ASSET__img_guns_pistol_p_diagup_png);
		type.set ("img/guns/pistol/p_diagup.png", AssetType.IMAGE);
		
		className.set ("img/guns/pistol/p_down.png", __ASSET__img_guns_pistol_p_down_png);
		type.set ("img/guns/pistol/p_down.png", AssetType.IMAGE);
		
		className.set ("img/guns/pistol/p_pick - Copy.png", __ASSET__img_guns_pistol_p_pick___copy_png);
		type.set ("img/guns/pistol/p_pick - Copy.png", AssetType.IMAGE);
		
		className.set ("img/guns/pistol/p_pick.png", __ASSET__img_guns_pistol_p_pick_png);
		type.set ("img/guns/pistol/p_pick.png", AssetType.IMAGE);
		
		className.set ("img/guns/pistol/p_side.png", __ASSET__img_guns_pistol_p_side_png);
		type.set ("img/guns/pistol/p_side.png", AssetType.IMAGE);
		
		className.set ("img/guns/pistol/p_up.png", __ASSET__img_guns_pistol_p_up_png);
		type.set ("img/guns/pistol/p_up.png", AssetType.IMAGE);
		
		className.set ("img/guns/shotgun/shot_diagdown.png", __ASSET__img_guns_shotgun_shot_diagdown_png);
		type.set ("img/guns/shotgun/shot_diagdown.png", AssetType.IMAGE);
		
		className.set ("img/guns/shotgun/shot_diagup.png", __ASSET__img_guns_shotgun_shot_diagup_png);
		type.set ("img/guns/shotgun/shot_diagup.png", AssetType.IMAGE);
		
		className.set ("img/guns/shotgun/shot_down.png", __ASSET__img_guns_shotgun_shot_down_png);
		type.set ("img/guns/shotgun/shot_down.png", AssetType.IMAGE);
		
		className.set ("img/guns/shotgun/shot_pick - Copy.png", __ASSET__img_guns_shotgun_shot_pick___copy_png);
		type.set ("img/guns/shotgun/shot_pick - Copy.png", AssetType.IMAGE);
		
		className.set ("img/guns/shotgun/shot_pick.png", __ASSET__img_guns_shotgun_shot_pick_png);
		type.set ("img/guns/shotgun/shot_pick.png", AssetType.IMAGE);
		
		className.set ("img/guns/shotgun/shot_side.png", __ASSET__img_guns_shotgun_shot_side_png);
		type.set ("img/guns/shotgun/shot_side.png", AssetType.IMAGE);
		
		className.set ("img/guns/shotgun/shot_up.png", __ASSET__img_guns_shotgun_shot_up_png);
		type.set ("img/guns/shotgun/shot_up.png", AssetType.IMAGE);
		
		className.set ("img/guns/smg/smg_pick - Copy.png", __ASSET__img_guns_smg_smg_pick___copy_png);
		type.set ("img/guns/smg/smg_pick - Copy.png", AssetType.IMAGE);
		
		className.set ("img/guns/smg/smg_pick.png", __ASSET__img_guns_smg_smg_pick_png);
		type.set ("img/guns/smg/smg_pick.png", AssetType.IMAGE);
		
		className.set ("img/jarBreakable.png", __ASSET__img_jarbreakable_png);
		type.set ("img/jarBreakable.png", AssetType.IMAGE);
		
		className.set ("img/logo.png", __ASSET__img_logo_png);
		type.set ("img/logo.png", AssetType.IMAGE);
		
		className.set ("img/pointer/crosshairBig.png", __ASSET__img_pointer_crosshairbig_png);
		type.set ("img/pointer/crosshairBig.png", AssetType.IMAGE);
		
		className.set ("img/pointer/crosshairSmall.png", __ASSET__img_pointer_crosshairsmall_png);
		type.set ("img/pointer/crosshairSmall.png", AssetType.IMAGE);
		
		className.set ("img/sprite_0.png", __ASSET__img_sprite_0_png);
		type.set ("img/sprite_0.png", AssetType.IMAGE);
		
		className.set ("img/sprite_1.png", __ASSET__img_sprite_1_png);
		type.set ("img/sprite_1.png", AssetType.IMAGE);
		
		className.set ("img/sprite_2.png", __ASSET__img_sprite_2_png);
		type.set ("img/sprite_2.png", AssetType.IMAGE);
		
		className.set ("pointer/crosshairBig.png", __ASSET__pointer_crosshairbig_png);
		type.set ("pointer/crosshairBig.png", AssetType.IMAGE);
		
		className.set ("pointer/crosshairSmall.png", __ASSET__pointer_crosshairsmall_png);
		type.set ("pointer/crosshairSmall.png", AssetType.IMAGE);
		
		className.set ("barrels/Barrel.png", __ASSET__barrels_barrel_png);
		type.set ("barrels/Barrel.png", AssetType.IMAGE);
		
		className.set ("barrels/explosion_01.png", __ASSET__barrels_explosion_01_png);
		type.set ("barrels/explosion_01.png", AssetType.IMAGE);
		
		className.set ("barrels/explosion_02.png", __ASSET__barrels_explosion_02_png);
		type.set ("barrels/explosion_02.png", AssetType.IMAGE);
		
		className.set ("barrels/explosion_03.png", __ASSET__barrels_explosion_03_png);
		type.set ("barrels/explosion_03.png", AssetType.IMAGE);
		
		className.set ("sounds/barrelExplotion.mp3", __ASSET__sounds_barrelexplotion_mp3);
		type.set ("sounds/barrelExplotion.mp3", AssetType.MUSIC);
		
		className.set ("sounds/gunPickUp.mp3", __ASSET__sounds_gunpickup_mp3);
		type.set ("sounds/gunPickUp.mp3", AssetType.MUSIC);
		
		className.set ("sounds/healPickUp.mp3", __ASSET__sounds_healpickup_mp3);
		type.set ("sounds/healPickUp.mp3", AssetType.MUSIC);
		
		className.set ("sounds/LoadnShot.mp3", __ASSET__sounds_loadnshot_mp3);
		type.set ("sounds/LoadnShot.mp3", AssetType.MUSIC);
		
		className.set ("sounds/music/background.mp3", __ASSET__sounds_music_background_mp3);
		type.set ("sounds/music/background.mp3", AssetType.MUSIC);
		
		className.set ("sounds/pistolShot.mp3", __ASSET__sounds_pistolshot_mp3);
		type.set ("sounds/pistolShot.mp3", AssetType.MUSIC);
		
		className.set ("sounds/shotgunShot.mp3", __ASSET__sounds_shotgunshot_mp3);
		type.set ("sounds/shotgunShot.mp3", AssetType.MUSIC);
		
		className.set ("music/background.mp3", __ASSET__music_background_mp3);
		type.set ("music/background.mp3", AssetType.MUSIC);
		
		className.set ("maps/level1.tmx", __ASSET__maps_level1_tmx);
		type.set ("maps/level1.tmx", AssetType.TEXT);
		
		className.set ("maps/level2/level2.tmx", __ASSET__maps_level2_level2_tmx);
		type.set ("maps/level2/level2.tmx", AssetType.TEXT);
		
		className.set ("maps/level2/mapTiles.png", __ASSET__maps_level2_maptiles_png);
		type.set ("maps/level2/mapTiles.png", AssetType.IMAGE);
		
		className.set ("maps/level3/level2 - copia.tmx", __ASSET__maps_level3_level2___copia_tmx);
		type.set ("maps/level3/level2 - copia.tmx", AssetType.TEXT);
		
		className.set ("maps/level3/level3.tmx", __ASSET__maps_level3_level3_tmx);
		type.set ("maps/level3/level3.tmx", AssetType.TEXT);
		
		className.set ("maps/level3/mapTiles.png", __ASSET__maps_level3_maptiles_png);
		type.set ("maps/level3/mapTiles.png", AssetType.IMAGE);
		
		className.set ("maps/level4/level4.tmx", __ASSET__maps_level4_level4_tmx);
		type.set ("maps/level4/level4.tmx", AssetType.TEXT);
		
		className.set ("maps/level4/mapTiles.png", __ASSET__maps_level4_maptiles_png);
		type.set ("maps/level4/mapTiles.png", AssetType.IMAGE);
		
		className.set ("maps/level4/mapTiles_old.png", __ASSET__maps_level4_maptiles_old_png);
		type.set ("maps/level4/mapTiles_old.png", AssetType.IMAGE);
		
		className.set ("maps/mapTiles.png", __ASSET__maps_maptiles_png);
		type.set ("maps/mapTiles.png", AssetType.IMAGE);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						onChange.dispatch ();
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if (requestedType == BINARY && (assetType == BINARY || assetType == TEXT || assetType == IMAGE)) {
				
				return true;
				
			} else if (requestedType == TEXT && assetType == BINARY) {
				
				return true;
				
			} else if (requestedType == null || path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return AudioBuffer.fromBytes (cast (Type.createInstance (className.get (id), []), Bytes));
		else return AudioBuffer.fromFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):Bytes {
		
		#if flash
		
		switch (type.get (id)) {
			
			case TEXT, BINARY:
				
				return Bytes.ofData (cast (Type.createInstance (className.get (id), []), flash.utils.ByteArray));
			
			case IMAGE:
				
				var bitmapData = cast (Type.createInstance (className.get (id), []), BitmapData);
				return Bytes.ofData (bitmapData.getPixels (bitmapData.rect));
			
			default:
				
				return null;
			
		}
		
		return cast (Type.createInstance (className.get (id), []), Bytes);
		
		#elseif html5
		
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var bytes = loader.bytes;
		
		if (bytes != null) {
			
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Bytes);
		else return Bytes.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if flash
		
		var src = Type.createInstance (className.get (id), []);
		
		var font = new Font (src.fontName);
		font.src = src;
		return font;
		
		#elseif html5
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Font);
			
		} else {
			
			return Font.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Image);
			
		} else {
			
			return Image.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var bytes = loader.bytes;
		
		if (bytes != null) {
			
			return bytes.getString (0, bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.getString (0, bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		//if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		//}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String):Future<AudioBuffer> {
		
		var promise = new Promise<AudioBuffer> ();
		
		#if (flash)
		
		if (path.exists (id)) {
			
			var soundLoader = new Sound ();
			soundLoader.addEventListener (Event.COMPLETE, function (event) {
				
				var audioBuffer:AudioBuffer = new AudioBuffer();
				audioBuffer.src = event.currentTarget;
				promise.complete (audioBuffer);
				
			});
			soundLoader.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			soundLoader.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			soundLoader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getAudioBuffer (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<AudioBuffer> (function () return getAudioBuffer (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	public override function loadBytes (id:String):Future<Bytes> {
		
		var promise = new Promise<Bytes> ();
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.dataFormat = flash.net.URLLoaderDataFormat.BINARY;
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = Bytes.ofData (event.currentTarget.data);
				promise.complete (bytes);
				
			});
			loader.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			loader.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getBytes (id));
			
		}
		
		#elseif html5
		
		if (path.exists (id)) {
			
			var request = new HTTPRequest ();
			promise.completeWith (request.load (path.get (id) + "?" + Assets.cache.version));
			
		} else {
			
			promise.complete (getBytes (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<Bytes> (function () return getBytes (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	public override function loadImage (id:String):Future<Image> {
		
		var promise = new Promise<Image> ();
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				promise.complete (Image.fromBitmapData (bitmapData));
				
			});
			loader.contentLoaderInfo.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			loader.contentLoaderInfo.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getImage (id));
			
		}
		
		#elseif html5
		
		if (path.exists (id)) {
			
			var image = new js.html.Image ();
			image.onload = function (_):Void {
				
				promise.complete (Image.fromImageElement (image));
				
			}
			image.onerror = promise.error;
			image.src = path.get (id) + "?" + Assets.cache.version;
			
		} else {
			
			promise.complete (getImage (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<Image> (function () return getImage (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = Bytes.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = Bytes.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = Bytes.readFile ("assets/manifest");
			#elseif (mac && java)
			var bytes = Bytes.readFile ("../Resources/manifest");
			#elseif (ios || tvos)
			var bytes = Bytes.readFile ("assets/manifest");
			#else
			var bytes = Bytes.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				if (bytes.length > 0) {
					
					var data = bytes.getString (0, bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								#if (ios || tvos)
								path.set (asset.id, "assets/" + asset.path);
								#else
								path.set (asset.id, asset.path);
								#end
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadText (id:String):Future<String> {
		
		var promise = new Promise<String> ();
		
		#if html5
		
		if (path.exists (id)) {
			
			var request = new HTTPRequest ();
			var future = request.load (path.get (id) + "?" + Assets.cache.version);
			future.onProgress (function (progress) promise.progress (progress));
			future.onError (function (msg) promise.error (msg));
			future.onComplete (function (bytes) promise.complete (bytes.getString (0, bytes.length)));
			
		} else {
			
			promise.complete (getText (id));
			
		}
		
		#else
		
		promise.completeWith (loadBytes (id).then (function (bytes) {
			
			return new Future<String> (function () {
				
				if (bytes == null) {
					
					return null;
					
				} else {
					
					return bytes.getString (0, bytes.length);
					
				}
				
			});
			
		}));
		
		#end
		
		return promise.future;
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_atlas_enemies_boss_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_atlas_enemies_greenorc_json extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__img_atlas_enemies_greenorc_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_atlas_enemies_skeleton_json extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__img_atlas_enemies_skeleton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_atlas_enemies_summoner_json extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__img_atlas_enemies_summoner_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_atlas_players_playerone_json extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__img_atlas_players_playerone_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_atlas_spritemap_json extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__img_atlas_spritesheet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_barrels_barrel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_barrels_explosion_01_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_barrels_explosion_02_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_barrels_explosion_03_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_bullets_bullets001_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_bullets_bullets002_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_bullets_bullets003_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_pistol_p_diagdown_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_pistol_p_diagup_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_pistol_p_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_pistol_p_pick___copy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_pistol_p_pick_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_pistol_p_side_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_pistol_p_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_shotgun_shot_diagdown_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_shotgun_shot_diagup_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_shotgun_shot_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_shotgun_shot_pick___copy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_shotgun_shot_pick_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_shotgun_shot_side_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_shotgun_shot_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_smg_smg_pick___copy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_smg_smg_pick_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_jarbreakable_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_logo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_pointer_crosshairbig_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_pointer_crosshairsmall_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_sprite_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_sprite_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_sprite_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__pointer_crosshairbig_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__pointer_crosshairsmall_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__barrels_barrel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__barrels_explosion_01_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__barrels_explosion_02_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__barrels_explosion_03_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__sounds_barrelexplotion_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__sounds_gunpickup_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__sounds_healpickup_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__sounds_loadnshot_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__sounds_music_background_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__sounds_pistolshot_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__sounds_shotgunshot_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__music_background_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__maps_level1_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__maps_level2_level2_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__maps_level2_maptiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__maps_level3_level2___copia_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__maps_level3_level3_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__maps_level3_maptiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__maps_level4_level4_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__maps_level4_maptiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__maps_level4_maptiles_old_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__maps_maptiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }


#elseif html5



@:keep #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { super (); name = "Nokia Cellphone FC Small"; } } 
@:keep #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { super (); name = "Monsterrat"; } } 




































































#else



#if (windows || mac || linux || cpp)


@:file("C:/HaxeToolkit/haxe/lib/flixel/4,0,1/assets/sounds/beep.mp3") #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends lime.utils.Bytes {}
@:file("C:/HaxeToolkit/haxe/lib/flixel/4,0,1/assets/sounds/flixel.mp3") #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends lime.utils.Bytes {}
@:font("C:/HaxeToolkit/haxe/lib/flixel/4,0,1/assets/fonts/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:font("C:/HaxeToolkit/haxe/lib/flixel/4,0,1/assets/fonts/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:image("C:/HaxeToolkit/haxe/lib/flixel/4,0,1/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:image("assets/img/atlas/enemies/Boss.png") #if display private #end class __ASSET__img_atlas_enemies_boss_png extends lime.graphics.Image {}
@:file("assets/img/atlas/enemies/GreenOrc.json") #if display private #end class __ASSET__img_atlas_enemies_greenorc_json extends lime.utils.Bytes {}
@:image("assets/img/atlas/enemies/GreenOrc.png") #if display private #end class __ASSET__img_atlas_enemies_greenorc_png extends lime.graphics.Image {}
@:file("assets/img/atlas/enemies/Skeleton.json") #if display private #end class __ASSET__img_atlas_enemies_skeleton_json extends lime.utils.Bytes {}
@:image("assets/img/atlas/enemies/Skeleton.png") #if display private #end class __ASSET__img_atlas_enemies_skeleton_png extends lime.graphics.Image {}
@:file("assets/img/atlas/enemies/Summoner.json") #if display private #end class __ASSET__img_atlas_enemies_summoner_json extends lime.utils.Bytes {}
@:image("assets/img/atlas/enemies/Summoner.png") #if display private #end class __ASSET__img_atlas_enemies_summoner_png extends lime.graphics.Image {}
@:file("assets/img/atlas/players/PlayerOne.json") #if display private #end class __ASSET__img_atlas_players_playerone_json extends lime.utils.Bytes {}
@:image("assets/img/atlas/players/PlayerOne.png") #if display private #end class __ASSET__img_atlas_players_playerone_png extends lime.graphics.Image {}
@:file("assets/img/atlas/spritemap.json") #if display private #end class __ASSET__img_atlas_spritemap_json extends lime.utils.Bytes {}
@:image("assets/img/atlas/spritesheet.png") #if display private #end class __ASSET__img_atlas_spritesheet_png extends lime.graphics.Image {}
@:image("assets/img/barrels/Barrel.png") #if display private #end class __ASSET__img_barrels_barrel_png extends lime.graphics.Image {}
@:image("assets/img/barrels/explosion_01.png") #if display private #end class __ASSET__img_barrels_explosion_01_png extends lime.graphics.Image {}
@:image("assets/img/barrels/explosion_02.png") #if display private #end class __ASSET__img_barrels_explosion_02_png extends lime.graphics.Image {}
@:image("assets/img/barrels/explosion_03.png") #if display private #end class __ASSET__img_barrels_explosion_03_png extends lime.graphics.Image {}
@:image("assets/img/bullets/Bullets001.png") #if display private #end class __ASSET__img_bullets_bullets001_png extends lime.graphics.Image {}
@:image("assets/img/bullets/Bullets002.png") #if display private #end class __ASSET__img_bullets_bullets002_png extends lime.graphics.Image {}
@:image("assets/img/bullets/Bullets003.png") #if display private #end class __ASSET__img_bullets_bullets003_png extends lime.graphics.Image {}
@:image("assets/img/guns/pistol/p_diagdown.png") #if display private #end class __ASSET__img_guns_pistol_p_diagdown_png extends lime.graphics.Image {}
@:image("assets/img/guns/pistol/p_diagup.png") #if display private #end class __ASSET__img_guns_pistol_p_diagup_png extends lime.graphics.Image {}
@:image("assets/img/guns/pistol/p_down.png") #if display private #end class __ASSET__img_guns_pistol_p_down_png extends lime.graphics.Image {}
@:image("assets/img/guns/pistol/p_pick - Copy.png") #if display private #end class __ASSET__img_guns_pistol_p_pick___copy_png extends lime.graphics.Image {}
@:image("assets/img/guns/pistol/p_pick.png") #if display private #end class __ASSET__img_guns_pistol_p_pick_png extends lime.graphics.Image {}
@:image("assets/img/guns/pistol/p_side.png") #if display private #end class __ASSET__img_guns_pistol_p_side_png extends lime.graphics.Image {}
@:image("assets/img/guns/pistol/p_up.png") #if display private #end class __ASSET__img_guns_pistol_p_up_png extends lime.graphics.Image {}
@:image("assets/img/guns/shotgun/shot_diagdown.png") #if display private #end class __ASSET__img_guns_shotgun_shot_diagdown_png extends lime.graphics.Image {}
@:image("assets/img/guns/shotgun/shot_diagup.png") #if display private #end class __ASSET__img_guns_shotgun_shot_diagup_png extends lime.graphics.Image {}
@:image("assets/img/guns/shotgun/shot_down.png") #if display private #end class __ASSET__img_guns_shotgun_shot_down_png extends lime.graphics.Image {}
@:image("assets/img/guns/shotgun/shot_pick - Copy.png") #if display private #end class __ASSET__img_guns_shotgun_shot_pick___copy_png extends lime.graphics.Image {}
@:image("assets/img/guns/shotgun/shot_pick.png") #if display private #end class __ASSET__img_guns_shotgun_shot_pick_png extends lime.graphics.Image {}
@:image("assets/img/guns/shotgun/shot_side.png") #if display private #end class __ASSET__img_guns_shotgun_shot_side_png extends lime.graphics.Image {}
@:image("assets/img/guns/shotgun/shot_up.png") #if display private #end class __ASSET__img_guns_shotgun_shot_up_png extends lime.graphics.Image {}
@:image("assets/img/guns/smg/smg_pick - Copy.png") #if display private #end class __ASSET__img_guns_smg_smg_pick___copy_png extends lime.graphics.Image {}
@:image("assets/img/guns/smg/smg_pick.png") #if display private #end class __ASSET__img_guns_smg_smg_pick_png extends lime.graphics.Image {}
@:image("assets/img/jarBreakable.png") #if display private #end class __ASSET__img_jarbreakable_png extends lime.graphics.Image {}
@:image("assets/img/logo.png") #if display private #end class __ASSET__img_logo_png extends lime.graphics.Image {}
@:image("assets/img/pointer/crosshairBig.png") #if display private #end class __ASSET__img_pointer_crosshairbig_png extends lime.graphics.Image {}
@:image("assets/img/pointer/crosshairSmall.png") #if display private #end class __ASSET__img_pointer_crosshairsmall_png extends lime.graphics.Image {}
@:image("assets/img/sprite_0.png") #if display private #end class __ASSET__img_sprite_0_png extends lime.graphics.Image {}
@:image("assets/img/sprite_1.png") #if display private #end class __ASSET__img_sprite_1_png extends lime.graphics.Image {}
@:image("assets/img/sprite_2.png") #if display private #end class __ASSET__img_sprite_2_png extends lime.graphics.Image {}
@:image("assets/img/pointer/crosshairBig.png") #if display private #end class __ASSET__pointer_crosshairbig_png extends lime.graphics.Image {}
@:image("assets/img/pointer/crosshairSmall.png") #if display private #end class __ASSET__pointer_crosshairsmall_png extends lime.graphics.Image {}
@:image("assets/img/barrels/Barrel.png") #if display private #end class __ASSET__barrels_barrel_png extends lime.graphics.Image {}
@:image("assets/img/barrels/explosion_01.png") #if display private #end class __ASSET__barrels_explosion_01_png extends lime.graphics.Image {}
@:image("assets/img/barrels/explosion_02.png") #if display private #end class __ASSET__barrels_explosion_02_png extends lime.graphics.Image {}
@:image("assets/img/barrels/explosion_03.png") #if display private #end class __ASSET__barrels_explosion_03_png extends lime.graphics.Image {}
@:file("assets/sounds/barrelExplotion.mp3") #if display private #end class __ASSET__sounds_barrelexplotion_mp3 extends lime.utils.Bytes {}
@:file("assets/sounds/gunPickUp.mp3") #if display private #end class __ASSET__sounds_gunpickup_mp3 extends lime.utils.Bytes {}
@:file("assets/sounds/healPickUp.mp3") #if display private #end class __ASSET__sounds_healpickup_mp3 extends lime.utils.Bytes {}
@:file("assets/sounds/LoadnShot.mp3") #if display private #end class __ASSET__sounds_loadnshot_mp3 extends lime.utils.Bytes {}
@:file("assets/sounds/music/background.mp3") #if display private #end class __ASSET__sounds_music_background_mp3 extends lime.utils.Bytes {}
@:file("assets/sounds/pistolShot.mp3") #if display private #end class __ASSET__sounds_pistolshot_mp3 extends lime.utils.Bytes {}
@:file("assets/sounds/shotgunShot.mp3") #if display private #end class __ASSET__sounds_shotgunshot_mp3 extends lime.utils.Bytes {}
@:file("assets/sounds/music/background.mp3") #if display private #end class __ASSET__music_background_mp3 extends lime.utils.Bytes {}
@:file("assets/maps/level1.tmx") #if display private #end class __ASSET__maps_level1_tmx extends lime.utils.Bytes {}
@:file("assets/maps/level2/level2.tmx") #if display private #end class __ASSET__maps_level2_level2_tmx extends lime.utils.Bytes {}
@:image("assets/maps/level2/mapTiles.png") #if display private #end class __ASSET__maps_level2_maptiles_png extends lime.graphics.Image {}
@:file("assets/maps/level3/level2 - copia.tmx") #if display private #end class __ASSET__maps_level3_level2___copia_tmx extends lime.utils.Bytes {}
@:file("assets/maps/level3/level3.tmx") #if display private #end class __ASSET__maps_level3_level3_tmx extends lime.utils.Bytes {}
@:image("assets/maps/level3/mapTiles.png") #if display private #end class __ASSET__maps_level3_maptiles_png extends lime.graphics.Image {}
@:file("assets/maps/level4/level4.tmx") #if display private #end class __ASSET__maps_level4_level4_tmx extends lime.utils.Bytes {}
@:image("assets/maps/level4/mapTiles.png") #if display private #end class __ASSET__maps_level4_maptiles_png extends lime.graphics.Image {}
@:image("assets/maps/level4/mapTiles_old.png") #if display private #end class __ASSET__maps_level4_maptiles_old_png extends lime.graphics.Image {}
@:image("assets/maps/mapTiles.png") #if display private #end class __ASSET__maps_maptiles_png extends lime.graphics.Image {}



#end
#end

#if (openfl && !flash)
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_nokiafc22_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_monsterrat_ttf (); src = font.src; name = font.name; super (); }}

#end

#end