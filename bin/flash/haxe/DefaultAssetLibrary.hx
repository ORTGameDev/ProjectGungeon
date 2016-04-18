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
		className.set ("img/atlas/spritemap.json", __ASSET__img_atlas_spritemap_json);
		type.set ("img/atlas/spritemap.json", AssetType.TEXT);
		className.set ("img/atlas/spritesheet.png", __ASSET__img_atlas_spritesheet_png);
		type.set ("img/atlas/spritesheet.png", AssetType.IMAGE);
		className.set ("img/characters/diagdown1.png", __ASSET__img_characters_diagdown1_png);
		type.set ("img/characters/diagdown1.png", AssetType.IMAGE);
		className.set ("img/characters/diagdown2.png", __ASSET__img_characters_diagdown2_png);
		type.set ("img/characters/diagdown2.png", AssetType.IMAGE);
		className.set ("img/characters/diagdown3.png", __ASSET__img_characters_diagdown3_png);
		type.set ("img/characters/diagdown3.png", AssetType.IMAGE);
		className.set ("img/characters/diagup1.png", __ASSET__img_characters_diagup1_png);
		type.set ("img/characters/diagup1.png", AssetType.IMAGE);
		className.set ("img/characters/diagup2.png", __ASSET__img_characters_diagup2_png);
		type.set ("img/characters/diagup2.png", AssetType.IMAGE);
		className.set ("img/characters/diagup3.png", __ASSET__img_characters_diagup3_png);
		type.set ("img/characters/diagup3.png", AssetType.IMAGE);
		className.set ("img/characters/enemyDead.png", __ASSET__img_characters_enemydead_png);
		type.set ("img/characters/enemyDead.png", AssetType.IMAGE);
		className.set ("img/characters/jason.png", __ASSET__img_characters_jason_png);
		type.set ("img/characters/jason.png", AssetType.IMAGE);
		className.set ("img/characters/north1.png", __ASSET__img_characters_north1_png);
		type.set ("img/characters/north1.png", AssetType.IMAGE);
		className.set ("img/characters/north2.png", __ASSET__img_characters_north2_png);
		type.set ("img/characters/north2.png", AssetType.IMAGE);
		className.set ("img/characters/north3.png", __ASSET__img_characters_north3_png);
		type.set ("img/characters/north3.png", AssetType.IMAGE);
		className.set ("img/characters/side1.png", __ASSET__img_characters_side1_png);
		type.set ("img/characters/side1.png", AssetType.IMAGE);
		className.set ("img/characters/side2.png", __ASSET__img_characters_side2_png);
		type.set ("img/characters/side2.png", AssetType.IMAGE);
		className.set ("img/characters/side3.png", __ASSET__img_characters_side3_png);
		type.set ("img/characters/side3.png", AssetType.IMAGE);
		className.set ("img/characters/south1.png", __ASSET__img_characters_south1_png);
		type.set ("img/characters/south1.png", AssetType.IMAGE);
		className.set ("img/characters/south2.png", __ASSET__img_characters_south2_png);
		type.set ("img/characters/south2.png", AssetType.IMAGE);
		className.set ("img/characters/south21.png", __ASSET__img_characters_south21_png);
		type.set ("img/characters/south21.png", AssetType.IMAGE);
		className.set ("img/characters/south22.png", __ASSET__img_characters_south22_png);
		type.set ("img/characters/south22.png", AssetType.IMAGE);
		className.set ("img/characters/south23.png", __ASSET__img_characters_south23_png);
		type.set ("img/characters/south23.png", AssetType.IMAGE);
		className.set ("img/characters/south3.png", __ASSET__img_characters_south3_png);
		type.set ("img/characters/south3.png", AssetType.IMAGE);
		className.set ("img/characters/start1.png", __ASSET__img_characters_start1_png);
		type.set ("img/characters/start1.png", AssetType.IMAGE);
		className.set ("img/characters/start2.png", __ASSET__img_characters_start2_png);
		type.set ("img/characters/start2.png", AssetType.IMAGE);
		className.set ("img/characters/start3.png", __ASSET__img_characters_start3_png);
		type.set ("img/characters/start3.png", AssetType.IMAGE);
		className.set ("img/guns/pistol/p_diagdown.png", __ASSET__img_guns_pistol_p_diagdown_png);
		type.set ("img/guns/pistol/p_diagdown.png", AssetType.IMAGE);
		className.set ("img/guns/pistol/p_diagup.png", __ASSET__img_guns_pistol_p_diagup_png);
		type.set ("img/guns/pistol/p_diagup.png", AssetType.IMAGE);
		className.set ("img/guns/pistol/p_down.png", __ASSET__img_guns_pistol_p_down_png);
		type.set ("img/guns/pistol/p_down.png", AssetType.IMAGE);
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
		className.set ("img/guns/shotgun/shot_side.png", __ASSET__img_guns_shotgun_shot_side_png);
		type.set ("img/guns/shotgun/shot_side.png", AssetType.IMAGE);
		className.set ("img/guns/shotgun/shot_up.png", __ASSET__img_guns_shotgun_shot_up_png);
		type.set ("img/guns/shotgun/shot_up.png", AssetType.IMAGE);
		className.set ("img/pointer/crosshairBig.png", __ASSET__img_pointer_crosshairbig_png);
		type.set ("img/pointer/crosshairBig.png", AssetType.IMAGE);
		className.set ("img/pointer/crosshairSmall.png", __ASSET__img_pointer_crosshairsmall_png);
		type.set ("img/pointer/crosshairSmall.png", AssetType.IMAGE);
		className.set ("pointer/crosshairBig.png", __ASSET__pointer_crosshairbig_png);
		type.set ("pointer/crosshairBig.png", AssetType.IMAGE);
		className.set ("pointer/crosshairSmall.png", __ASSET__pointer_crosshairsmall_png);
		type.set ("pointer/crosshairSmall.png", AssetType.IMAGE);
		className.set ("characters/diagdown1.png", __ASSET__characters_diagdown1_png);
		type.set ("characters/diagdown1.png", AssetType.IMAGE);
		className.set ("characters/diagdown2.png", __ASSET__characters_diagdown2_png);
		type.set ("characters/diagdown2.png", AssetType.IMAGE);
		className.set ("characters/diagdown3.png", __ASSET__characters_diagdown3_png);
		type.set ("characters/diagdown3.png", AssetType.IMAGE);
		className.set ("characters/diagup1.png", __ASSET__characters_diagup1_png);
		type.set ("characters/diagup1.png", AssetType.IMAGE);
		className.set ("characters/diagup2.png", __ASSET__characters_diagup2_png);
		type.set ("characters/diagup2.png", AssetType.IMAGE);
		className.set ("characters/diagup3.png", __ASSET__characters_diagup3_png);
		type.set ("characters/diagup3.png", AssetType.IMAGE);
		className.set ("characters/enemyDead.png", __ASSET__characters_enemydead_png);
		type.set ("characters/enemyDead.png", AssetType.IMAGE);
		className.set ("characters/jason.png", __ASSET__characters_jason_png);
		type.set ("characters/jason.png", AssetType.IMAGE);
		className.set ("characters/north1.png", __ASSET__characters_north1_png);
		type.set ("characters/north1.png", AssetType.IMAGE);
		className.set ("characters/north2.png", __ASSET__characters_north2_png);
		type.set ("characters/north2.png", AssetType.IMAGE);
		className.set ("characters/north3.png", __ASSET__characters_north3_png);
		type.set ("characters/north3.png", AssetType.IMAGE);
		className.set ("characters/side1.png", __ASSET__characters_side1_png);
		type.set ("characters/side1.png", AssetType.IMAGE);
		className.set ("characters/side2.png", __ASSET__characters_side2_png);
		type.set ("characters/side2.png", AssetType.IMAGE);
		className.set ("characters/side3.png", __ASSET__characters_side3_png);
		type.set ("characters/side3.png", AssetType.IMAGE);
		className.set ("characters/south1.png", __ASSET__characters_south1_png);
		type.set ("characters/south1.png", AssetType.IMAGE);
		className.set ("characters/south2.png", __ASSET__characters_south2_png);
		type.set ("characters/south2.png", AssetType.IMAGE);
		className.set ("characters/south21.png", __ASSET__characters_south21_png);
		type.set ("characters/south21.png", AssetType.IMAGE);
		className.set ("characters/south22.png", __ASSET__characters_south22_png);
		type.set ("characters/south22.png", AssetType.IMAGE);
		className.set ("characters/south23.png", __ASSET__characters_south23_png);
		type.set ("characters/south23.png", AssetType.IMAGE);
		className.set ("characters/south3.png", __ASSET__characters_south3_png);
		type.set ("characters/south3.png", AssetType.IMAGE);
		className.set ("characters/start1.png", __ASSET__characters_start1_png);
		type.set ("characters/start1.png", AssetType.IMAGE);
		className.set ("characters/start2.png", __ASSET__characters_start2_png);
		type.set ("characters/start2.png", AssetType.IMAGE);
		className.set ("characters/start3.png", __ASSET__characters_start3_png);
		type.set ("characters/start3.png", AssetType.IMAGE);
		
		
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
		id = "img/atlas/spritemap.json";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "img/atlas/spritesheet.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/diagdown1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/diagdown2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/diagdown3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/diagup1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/diagup2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/diagup3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/enemyDead.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/jason.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/north1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/north2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/north3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/side1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/side2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/side3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/south1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/south2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/south21.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/south22.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/south23.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/south3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/start1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/start2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/characters/start3.png";
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
		id = "img/guns/shotgun/shot_side.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/guns/shotgun/shot_up.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/pointer/crosshairBig.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/pointer/crosshairSmall.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "pointer/crosshairBig.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "pointer/crosshairSmall.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/diagdown1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/diagdown2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/diagdown3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/diagup1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/diagup2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/diagup3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/enemyDead.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/jason.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/north1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/north2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/north3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/side1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/side2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/side3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/south1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/south2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/south21.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/south22.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/south23.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/south3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/start1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/start2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "characters/start3.png";
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
		
		className.set ("img/atlas/spritemap.json", __ASSET__img_atlas_spritemap_json);
		type.set ("img/atlas/spritemap.json", AssetType.TEXT);
		
		className.set ("img/atlas/spritesheet.png", __ASSET__img_atlas_spritesheet_png);
		type.set ("img/atlas/spritesheet.png", AssetType.IMAGE);
		
		className.set ("img/characters/diagdown1.png", __ASSET__img_characters_diagdown1_png);
		type.set ("img/characters/diagdown1.png", AssetType.IMAGE);
		
		className.set ("img/characters/diagdown2.png", __ASSET__img_characters_diagdown2_png);
		type.set ("img/characters/diagdown2.png", AssetType.IMAGE);
		
		className.set ("img/characters/diagdown3.png", __ASSET__img_characters_diagdown3_png);
		type.set ("img/characters/diagdown3.png", AssetType.IMAGE);
		
		className.set ("img/characters/diagup1.png", __ASSET__img_characters_diagup1_png);
		type.set ("img/characters/diagup1.png", AssetType.IMAGE);
		
		className.set ("img/characters/diagup2.png", __ASSET__img_characters_diagup2_png);
		type.set ("img/characters/diagup2.png", AssetType.IMAGE);
		
		className.set ("img/characters/diagup3.png", __ASSET__img_characters_diagup3_png);
		type.set ("img/characters/diagup3.png", AssetType.IMAGE);
		
		className.set ("img/characters/enemyDead.png", __ASSET__img_characters_enemydead_png);
		type.set ("img/characters/enemyDead.png", AssetType.IMAGE);
		
		className.set ("img/characters/jason.png", __ASSET__img_characters_jason_png);
		type.set ("img/characters/jason.png", AssetType.IMAGE);
		
		className.set ("img/characters/north1.png", __ASSET__img_characters_north1_png);
		type.set ("img/characters/north1.png", AssetType.IMAGE);
		
		className.set ("img/characters/north2.png", __ASSET__img_characters_north2_png);
		type.set ("img/characters/north2.png", AssetType.IMAGE);
		
		className.set ("img/characters/north3.png", __ASSET__img_characters_north3_png);
		type.set ("img/characters/north3.png", AssetType.IMAGE);
		
		className.set ("img/characters/side1.png", __ASSET__img_characters_side1_png);
		type.set ("img/characters/side1.png", AssetType.IMAGE);
		
		className.set ("img/characters/side2.png", __ASSET__img_characters_side2_png);
		type.set ("img/characters/side2.png", AssetType.IMAGE);
		
		className.set ("img/characters/side3.png", __ASSET__img_characters_side3_png);
		type.set ("img/characters/side3.png", AssetType.IMAGE);
		
		className.set ("img/characters/south1.png", __ASSET__img_characters_south1_png);
		type.set ("img/characters/south1.png", AssetType.IMAGE);
		
		className.set ("img/characters/south2.png", __ASSET__img_characters_south2_png);
		type.set ("img/characters/south2.png", AssetType.IMAGE);
		
		className.set ("img/characters/south21.png", __ASSET__img_characters_south21_png);
		type.set ("img/characters/south21.png", AssetType.IMAGE);
		
		className.set ("img/characters/south22.png", __ASSET__img_characters_south22_png);
		type.set ("img/characters/south22.png", AssetType.IMAGE);
		
		className.set ("img/characters/south23.png", __ASSET__img_characters_south23_png);
		type.set ("img/characters/south23.png", AssetType.IMAGE);
		
		className.set ("img/characters/south3.png", __ASSET__img_characters_south3_png);
		type.set ("img/characters/south3.png", AssetType.IMAGE);
		
		className.set ("img/characters/start1.png", __ASSET__img_characters_start1_png);
		type.set ("img/characters/start1.png", AssetType.IMAGE);
		
		className.set ("img/characters/start2.png", __ASSET__img_characters_start2_png);
		type.set ("img/characters/start2.png", AssetType.IMAGE);
		
		className.set ("img/characters/start3.png", __ASSET__img_characters_start3_png);
		type.set ("img/characters/start3.png", AssetType.IMAGE);
		
		className.set ("img/guns/pistol/p_diagdown.png", __ASSET__img_guns_pistol_p_diagdown_png);
		type.set ("img/guns/pistol/p_diagdown.png", AssetType.IMAGE);
		
		className.set ("img/guns/pistol/p_diagup.png", __ASSET__img_guns_pistol_p_diagup_png);
		type.set ("img/guns/pistol/p_diagup.png", AssetType.IMAGE);
		
		className.set ("img/guns/pistol/p_down.png", __ASSET__img_guns_pistol_p_down_png);
		type.set ("img/guns/pistol/p_down.png", AssetType.IMAGE);
		
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
		
		className.set ("img/guns/shotgun/shot_side.png", __ASSET__img_guns_shotgun_shot_side_png);
		type.set ("img/guns/shotgun/shot_side.png", AssetType.IMAGE);
		
		className.set ("img/guns/shotgun/shot_up.png", __ASSET__img_guns_shotgun_shot_up_png);
		type.set ("img/guns/shotgun/shot_up.png", AssetType.IMAGE);
		
		className.set ("img/pointer/crosshairBig.png", __ASSET__img_pointer_crosshairbig_png);
		type.set ("img/pointer/crosshairBig.png", AssetType.IMAGE);
		
		className.set ("img/pointer/crosshairSmall.png", __ASSET__img_pointer_crosshairsmall_png);
		type.set ("img/pointer/crosshairSmall.png", AssetType.IMAGE);
		
		className.set ("pointer/crosshairBig.png", __ASSET__pointer_crosshairbig_png);
		type.set ("pointer/crosshairBig.png", AssetType.IMAGE);
		
		className.set ("pointer/crosshairSmall.png", __ASSET__pointer_crosshairsmall_png);
		type.set ("pointer/crosshairSmall.png", AssetType.IMAGE);
		
		className.set ("characters/diagdown1.png", __ASSET__characters_diagdown1_png);
		type.set ("characters/diagdown1.png", AssetType.IMAGE);
		
		className.set ("characters/diagdown2.png", __ASSET__characters_diagdown2_png);
		type.set ("characters/diagdown2.png", AssetType.IMAGE);
		
		className.set ("characters/diagdown3.png", __ASSET__characters_diagdown3_png);
		type.set ("characters/diagdown3.png", AssetType.IMAGE);
		
		className.set ("characters/diagup1.png", __ASSET__characters_diagup1_png);
		type.set ("characters/diagup1.png", AssetType.IMAGE);
		
		className.set ("characters/diagup2.png", __ASSET__characters_diagup2_png);
		type.set ("characters/diagup2.png", AssetType.IMAGE);
		
		className.set ("characters/diagup3.png", __ASSET__characters_diagup3_png);
		type.set ("characters/diagup3.png", AssetType.IMAGE);
		
		className.set ("characters/enemyDead.png", __ASSET__characters_enemydead_png);
		type.set ("characters/enemyDead.png", AssetType.IMAGE);
		
		className.set ("characters/jason.png", __ASSET__characters_jason_png);
		type.set ("characters/jason.png", AssetType.IMAGE);
		
		className.set ("characters/north1.png", __ASSET__characters_north1_png);
		type.set ("characters/north1.png", AssetType.IMAGE);
		
		className.set ("characters/north2.png", __ASSET__characters_north2_png);
		type.set ("characters/north2.png", AssetType.IMAGE);
		
		className.set ("characters/north3.png", __ASSET__characters_north3_png);
		type.set ("characters/north3.png", AssetType.IMAGE);
		
		className.set ("characters/side1.png", __ASSET__characters_side1_png);
		type.set ("characters/side1.png", AssetType.IMAGE);
		
		className.set ("characters/side2.png", __ASSET__characters_side2_png);
		type.set ("characters/side2.png", AssetType.IMAGE);
		
		className.set ("characters/side3.png", __ASSET__characters_side3_png);
		type.set ("characters/side3.png", AssetType.IMAGE);
		
		className.set ("characters/south1.png", __ASSET__characters_south1_png);
		type.set ("characters/south1.png", AssetType.IMAGE);
		
		className.set ("characters/south2.png", __ASSET__characters_south2_png);
		type.set ("characters/south2.png", AssetType.IMAGE);
		
		className.set ("characters/south21.png", __ASSET__characters_south21_png);
		type.set ("characters/south21.png", AssetType.IMAGE);
		
		className.set ("characters/south22.png", __ASSET__characters_south22_png);
		type.set ("characters/south22.png", AssetType.IMAGE);
		
		className.set ("characters/south23.png", __ASSET__characters_south23_png);
		type.set ("characters/south23.png", AssetType.IMAGE);
		
		className.set ("characters/south3.png", __ASSET__characters_south3_png);
		type.set ("characters/south3.png", AssetType.IMAGE);
		
		className.set ("characters/start1.png", __ASSET__characters_start1_png);
		type.set ("characters/start1.png", AssetType.IMAGE);
		
		className.set ("characters/start2.png", __ASSET__characters_start2_png);
		type.set ("characters/start2.png", AssetType.IMAGE);
		
		className.set ("characters/start3.png", __ASSET__characters_start3_png);
		type.set ("characters/start3.png", AssetType.IMAGE);
		
		
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
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = Bytes.ofString (event.currentTarget.data);
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
@:keep @:bind #if display private #end class __ASSET__img_atlas_spritemap_json extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__img_atlas_spritesheet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_diagdown1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_diagdown2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_diagdown3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_diagup1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_diagup2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_diagup3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_enemydead_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_jason_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_north1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_north2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_north3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_side1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_side2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_side3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_south1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_south2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_south21_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_south22_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_south23_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_south3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_start1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_start2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_characters_start3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_pistol_p_diagdown_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_pistol_p_diagup_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_pistol_p_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_pistol_p_side_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_pistol_p_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_shotgun_shot_diagdown_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_shotgun_shot_diagup_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_shotgun_shot_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_shotgun_shot_side_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_guns_shotgun_shot_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_pointer_crosshairbig_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_pointer_crosshairsmall_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__pointer_crosshairbig_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__pointer_crosshairsmall_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_diagdown1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_diagdown2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_diagdown3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_diagup1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_diagup2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_diagup3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_enemydead_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_jason_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_north1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_north2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_north3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_side1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_side2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_side3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_south1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_south2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_south21_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_south22_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_south23_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_south3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_start1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_start2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__characters_start3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }


#elseif html5



@:keep #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { super (); name = "Nokia Cellphone FC Small"; } } 
@:keep #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { super (); name = "Monsterrat"; } } 

































































#else



#if (windows || mac || linux || cpp)


@:file("C:/HaxeToolkit/haxe/lib/flixel/4,0,0/assets/sounds/beep.mp3") #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends lime.utils.Bytes {}
@:file("C:/HaxeToolkit/haxe/lib/flixel/4,0,0/assets/sounds/flixel.mp3") #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends lime.utils.Bytes {}
@:font("C:/HaxeToolkit/haxe/lib/flixel/4,0,0/assets/fonts/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:font("C:/HaxeToolkit/haxe/lib/flixel/4,0,0/assets/fonts/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:image("C:/HaxeToolkit/haxe/lib/flixel/4,0,0/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:file("assets/img/atlas/spritemap.json") #if display private #end class __ASSET__img_atlas_spritemap_json extends lime.utils.Bytes {}
@:image("assets/img/atlas/spritesheet.png") #if display private #end class __ASSET__img_atlas_spritesheet_png extends lime.graphics.Image {}
@:image("assets/img/characters/diagdown1.png") #if display private #end class __ASSET__img_characters_diagdown1_png extends lime.graphics.Image {}
@:image("assets/img/characters/diagdown2.png") #if display private #end class __ASSET__img_characters_diagdown2_png extends lime.graphics.Image {}
@:image("assets/img/characters/diagdown3.png") #if display private #end class __ASSET__img_characters_diagdown3_png extends lime.graphics.Image {}
@:image("assets/img/characters/diagup1.png") #if display private #end class __ASSET__img_characters_diagup1_png extends lime.graphics.Image {}
@:image("assets/img/characters/diagup2.png") #if display private #end class __ASSET__img_characters_diagup2_png extends lime.graphics.Image {}
@:image("assets/img/characters/diagup3.png") #if display private #end class __ASSET__img_characters_diagup3_png extends lime.graphics.Image {}
@:image("assets/img/characters/enemyDead.png") #if display private #end class __ASSET__img_characters_enemydead_png extends lime.graphics.Image {}
@:image("assets/img/characters/jason.png") #if display private #end class __ASSET__img_characters_jason_png extends lime.graphics.Image {}
@:image("assets/img/characters/north1.png") #if display private #end class __ASSET__img_characters_north1_png extends lime.graphics.Image {}
@:image("assets/img/characters/north2.png") #if display private #end class __ASSET__img_characters_north2_png extends lime.graphics.Image {}
@:image("assets/img/characters/north3.png") #if display private #end class __ASSET__img_characters_north3_png extends lime.graphics.Image {}
@:image("assets/img/characters/side1.png") #if display private #end class __ASSET__img_characters_side1_png extends lime.graphics.Image {}
@:image("assets/img/characters/side2.png") #if display private #end class __ASSET__img_characters_side2_png extends lime.graphics.Image {}
@:image("assets/img/characters/side3.png") #if display private #end class __ASSET__img_characters_side3_png extends lime.graphics.Image {}
@:image("assets/img/characters/south1.png") #if display private #end class __ASSET__img_characters_south1_png extends lime.graphics.Image {}
@:image("assets/img/characters/south2.png") #if display private #end class __ASSET__img_characters_south2_png extends lime.graphics.Image {}
@:image("assets/img/characters/south21.png") #if display private #end class __ASSET__img_characters_south21_png extends lime.graphics.Image {}
@:image("assets/img/characters/south22.png") #if display private #end class __ASSET__img_characters_south22_png extends lime.graphics.Image {}
@:image("assets/img/characters/south23.png") #if display private #end class __ASSET__img_characters_south23_png extends lime.graphics.Image {}
@:image("assets/img/characters/south3.png") #if display private #end class __ASSET__img_characters_south3_png extends lime.graphics.Image {}
@:image("assets/img/characters/start1.png") #if display private #end class __ASSET__img_characters_start1_png extends lime.graphics.Image {}
@:image("assets/img/characters/start2.png") #if display private #end class __ASSET__img_characters_start2_png extends lime.graphics.Image {}
@:image("assets/img/characters/start3.png") #if display private #end class __ASSET__img_characters_start3_png extends lime.graphics.Image {}
@:image("assets/img/guns/pistol/p_diagdown.png") #if display private #end class __ASSET__img_guns_pistol_p_diagdown_png extends lime.graphics.Image {}
@:image("assets/img/guns/pistol/p_diagup.png") #if display private #end class __ASSET__img_guns_pistol_p_diagup_png extends lime.graphics.Image {}
@:image("assets/img/guns/pistol/p_down.png") #if display private #end class __ASSET__img_guns_pistol_p_down_png extends lime.graphics.Image {}
@:image("assets/img/guns/pistol/p_side.png") #if display private #end class __ASSET__img_guns_pistol_p_side_png extends lime.graphics.Image {}
@:image("assets/img/guns/pistol/p_up.png") #if display private #end class __ASSET__img_guns_pistol_p_up_png extends lime.graphics.Image {}
@:image("assets/img/guns/shotgun/shot_diagdown.png") #if display private #end class __ASSET__img_guns_shotgun_shot_diagdown_png extends lime.graphics.Image {}
@:image("assets/img/guns/shotgun/shot_diagup.png") #if display private #end class __ASSET__img_guns_shotgun_shot_diagup_png extends lime.graphics.Image {}
@:image("assets/img/guns/shotgun/shot_down.png") #if display private #end class __ASSET__img_guns_shotgun_shot_down_png extends lime.graphics.Image {}
@:image("assets/img/guns/shotgun/shot_side.png") #if display private #end class __ASSET__img_guns_shotgun_shot_side_png extends lime.graphics.Image {}
@:image("assets/img/guns/shotgun/shot_up.png") #if display private #end class __ASSET__img_guns_shotgun_shot_up_png extends lime.graphics.Image {}
@:image("assets/img/pointer/crosshairBig.png") #if display private #end class __ASSET__img_pointer_crosshairbig_png extends lime.graphics.Image {}
@:image("assets/img/pointer/crosshairSmall.png") #if display private #end class __ASSET__img_pointer_crosshairsmall_png extends lime.graphics.Image {}
@:image("assets/img/pointer/crosshairBig.png") #if display private #end class __ASSET__pointer_crosshairbig_png extends lime.graphics.Image {}
@:image("assets/img/pointer/crosshairSmall.png") #if display private #end class __ASSET__pointer_crosshairsmall_png extends lime.graphics.Image {}
@:image("assets/img/characters/diagdown1.png") #if display private #end class __ASSET__characters_diagdown1_png extends lime.graphics.Image {}
@:image("assets/img/characters/diagdown2.png") #if display private #end class __ASSET__characters_diagdown2_png extends lime.graphics.Image {}
@:image("assets/img/characters/diagdown3.png") #if display private #end class __ASSET__characters_diagdown3_png extends lime.graphics.Image {}
@:image("assets/img/characters/diagup1.png") #if display private #end class __ASSET__characters_diagup1_png extends lime.graphics.Image {}
@:image("assets/img/characters/diagup2.png") #if display private #end class __ASSET__characters_diagup2_png extends lime.graphics.Image {}
@:image("assets/img/characters/diagup3.png") #if display private #end class __ASSET__characters_diagup3_png extends lime.graphics.Image {}
@:image("assets/img/characters/enemyDead.png") #if display private #end class __ASSET__characters_enemydead_png extends lime.graphics.Image {}
@:image("assets/img/characters/jason.png") #if display private #end class __ASSET__characters_jason_png extends lime.graphics.Image {}
@:image("assets/img/characters/north1.png") #if display private #end class __ASSET__characters_north1_png extends lime.graphics.Image {}
@:image("assets/img/characters/north2.png") #if display private #end class __ASSET__characters_north2_png extends lime.graphics.Image {}
@:image("assets/img/characters/north3.png") #if display private #end class __ASSET__characters_north3_png extends lime.graphics.Image {}
@:image("assets/img/characters/side1.png") #if display private #end class __ASSET__characters_side1_png extends lime.graphics.Image {}
@:image("assets/img/characters/side2.png") #if display private #end class __ASSET__characters_side2_png extends lime.graphics.Image {}
@:image("assets/img/characters/side3.png") #if display private #end class __ASSET__characters_side3_png extends lime.graphics.Image {}
@:image("assets/img/characters/south1.png") #if display private #end class __ASSET__characters_south1_png extends lime.graphics.Image {}
@:image("assets/img/characters/south2.png") #if display private #end class __ASSET__characters_south2_png extends lime.graphics.Image {}
@:image("assets/img/characters/south21.png") #if display private #end class __ASSET__characters_south21_png extends lime.graphics.Image {}
@:image("assets/img/characters/south22.png") #if display private #end class __ASSET__characters_south22_png extends lime.graphics.Image {}
@:image("assets/img/characters/south23.png") #if display private #end class __ASSET__characters_south23_png extends lime.graphics.Image {}
@:image("assets/img/characters/south3.png") #if display private #end class __ASSET__characters_south3_png extends lime.graphics.Image {}
@:image("assets/img/characters/start1.png") #if display private #end class __ASSET__characters_start1_png extends lime.graphics.Image {}
@:image("assets/img/characters/start2.png") #if display private #end class __ASSET__characters_start2_png extends lime.graphics.Image {}
@:image("assets/img/characters/start3.png") #if display private #end class __ASSET__characters_start3_png extends lime.graphics.Image {}



#end
#end

#if (openfl && !flash)
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_nokiafc22_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_monsterrat_ttf (); src = font.src; name = font.name; super (); }}

#end

#end