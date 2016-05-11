#if !lime_hybrid


package;


import haxe.Timer;
import haxe.Unserializer;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.text.Font;
import openfl.media.Sound;
import openfl.net.URLRequest;
import openfl.utils.ByteArray;
import openfl.Assets;

#if neko
import neko.vm.Deque;
import neko.vm.Thread;
#elseif cpp
import cpp.vm.Deque;
import cpp.vm.Thread;
#end

#if sys
import sys.FileSystem;
#end

#if ios
import openfl._legacy.utils.SystemPath;
#end


@:access(openfl.media.Sound)
class DefaultAssetLibrary extends AssetLibrary {
	
	
	private static var loaded = 0;
	private static var loading = 0;
	private static var workerIncomingQueue = new Deque<Dynamic> ();
	private static var workerResult = new Deque<Dynamic> ();
	private static var workerThread:Thread;
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		
		
		
		Font.registerFont (__ASSET__flixel_fonts_nokiafc22_ttf);
		Font.registerFont (__ASSET__flixel_fonts_monsterrat_ttf);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("flixel/sounds/beep.ogg", __ASSET__flixel_sounds_beep_ogg);
		type.set ("flixel/sounds/beep.ogg", AssetType.SOUND);
		
		className.set ("flixel/sounds/flixel.ogg", __ASSET__flixel_sounds_flixel_ogg);
		type.set ("flixel/sounds/flixel.ogg", AssetType.SOUND);
		
		className.set ("flixel/fonts/nokiafc22.ttf", __ASSET__flixel_fonts_nokiafc22_ttf);
		type.set ("flixel/fonts/nokiafc22.ttf", AssetType.FONT);
		
		className.set ("flixel/fonts/monsterrat.ttf", __ASSET__flixel_fonts_monsterrat_ttf);
		type.set ("flixel/fonts/monsterrat.ttf", AssetType.FONT);
		
		className.set ("flixel/images/ui/button.png", __ASSET__flixel_images_ui_button_png);
		type.set ("flixel/images/ui/button.png", AssetType.IMAGE);
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		
		
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
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		
	}
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == type || ((type == SOUND || type == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			if (type == BINARY || type == null || (assetType == BINARY && type == TEXT)) {
				
				return true;
				
			}
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		if (className.exists (id)) {
			
			return cast (Type.createInstance (className.get (id), []), BitmapData);
			
		} else {
			
			return BitmapData.load (path.get (id));
			
		}
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		if (className.exists (id)) {
			
			return cast (Type.createInstance (className.get (id), []), ByteArray);
			
		} else {
			
			return ByteArray.readFile (path.get (id));
			
		}
		
	}
	
	
	public override function getFont (id:String):Font {
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			Font.registerFont (fontClass);
			return cast (Type.createInstance (fontClass, []), Font);
			
		} else {
			
			return new Font (path.get (id));
			
		}
		
	}
	
	
	public override function getMusic (id:String):Sound {
		
		if (className.exists (id)) {
			
			return cast (Type.createInstance (className.get (id), []), Sound);
			
		} else {
			
			return new Sound (new URLRequest (path.get (id)), null, true);
			
		}
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		if (className.exists (id)) {
			
			return cast (Type.createInstance (className.get (id), []), Sound);
			
		} else {
			
			return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
			
		}
		
	}
	
	
	public override function getText (id:String):String {
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		return true;
		
	}
	
	
	public override function list (type:AssetType):Array<String> {
		
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (type == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		__load (getBitmapData, id, handler);
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		__load (getBytes, id, handler);
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		__load (getFont, id, handler);
		
	}
	
	
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, Type.createEnum (AssetType, asset.type));
								
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
	
	
	public override function loadMusic (id:String, handler:Sound -> Void):Void {
		
		__load (getMusic, id, handler);
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		__load (getSound, id, handler);
		
	}
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
	}
	
	
	private static function __doWork ():Void {
		
		while (true) {
			
			var message = workerIncomingQueue.pop (true);
			
			if (message == "WORK") {
				
				var getMethod = workerIncomingQueue.pop (true);
				var id = workerIncomingQueue.pop (true);
				var handler = workerIncomingQueue.pop (true);
				
				var data = getMethod (id);
				workerResult.add ("RESULT");
				workerResult.add (data);
				workerResult.add (handler);
				
			} else if (message == "EXIT") {
				
				break;
				
			}
			
		}
		
	}
	
	
	private inline function __load<T> (getMethod:String->T, id:String, handler:T->Void):Void {
		
		workerIncomingQueue.add ("WORK");
		workerIncomingQueue.add (getMethod);
		workerIncomingQueue.add (id);
		workerIncomingQueue.add (handler);
		
		loading++;
		
	}
	
	
	public static function __poll ():Void {
		
		if (loading > loaded) {
			
			if (workerThread == null) {
				
				workerThread = Thread.create (__doWork);
				
			}
			
			var message = workerResult.pop (false);
			
			while (message == "RESULT") {
				
				loaded++;
				
				var data = workerResult.pop (true);
				var handler = workerResult.pop (true);
				
				if (handler != null) {
					
					handler (data);
					
				}
				
				message = workerResult.pop (false);
				
			}
			
		} else {
			
			if (workerThread != null) {
				
				workerIncomingQueue.add ("EXIT");
				workerThread = null;
				
			}
			
		}
		
	}
	
	
}


#if (windows || mac || linux)


@:sound("E:/HaxeToolkit/haxe/lib/flixel/4,0,1/assets/sounds/beep.ogg") @:keep #if display private #end class __ASSET__flixel_sounds_beep_ogg extends flash.media.Sound {}
@:sound("E:/HaxeToolkit/haxe/lib/flixel/4,0,1/assets/sounds/flixel.ogg") @:keep #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends flash.media.Sound {}
@:font("E:/HaxeToolkit/haxe/lib/flixel/4,0,1/assets/fonts/nokiafc22.ttf") @:keep #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends flash.text.Font {}
@:font("E:/HaxeToolkit/haxe/lib/flixel/4,0,1/assets/fonts/monsterrat.ttf") @:keep #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends flash.text.Font {}
@:bitmap("E:/HaxeToolkit/haxe/lib/flixel/4,0,1/assets/images/ui/button.png") @:keep #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData {}





#else


class __ASSET__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "flixel/fonts/nokiafc22.ttf"; fontName = "Nokia Cellphone FC Small";  }}
class __ASSET__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "flixel/fonts/monsterrat.ttf"; fontName = "Monsterrat";  }}


#end


#else


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
import lime.text.Font;
import lime.utils.ByteArray;
import lime.utils.UInt8Array;
import lime.Assets;

#if sys
import sys.FileSystem;
#end

#if (js && html5)
import lime.net.URLLoader;
import lime.net.URLRequest;
#elseif flash
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
		
		className.set ("flixel/sounds/beep.ogg", __ASSET__flixel_sounds_beep_ogg);
		type.set ("flixel/sounds/beep.ogg", AssetType.SOUND);
		className.set ("flixel/sounds/flixel.ogg", __ASSET__flixel_sounds_flixel_ogg);
		type.set ("flixel/sounds/flixel.ogg", AssetType.SOUND);
		className.set ("flixel/fonts/nokiafc22.ttf", __ASSET__flixel_fonts_nokiafc22_ttf);
		type.set ("flixel/fonts/nokiafc22.ttf", AssetType.FONT);
		className.set ("flixel/fonts/monsterrat.ttf", __ASSET__flixel_fonts_monsterrat_ttf);
		type.set ("flixel/fonts/monsterrat.ttf", AssetType.FONT);
		className.set ("flixel/images/ui/button.png", __ASSET__flixel_images_ui_button_png);
		type.set ("flixel/images/ui/button.png", AssetType.IMAGE);
		path.set ("img/atlas/spritemap.json", "img/atlas/spritemap.json");
		type.set ("img/atlas/spritemap.json", AssetType.TEXT);
		path.set ("img/atlas/spritesheet.png", "img/atlas/spritesheet.png");
		type.set ("img/atlas/spritesheet.png", AssetType.IMAGE);
		path.set ("img/bullets/simpleBullet.png", "img/bullets/simpleBullet.png");
		type.set ("img/bullets/simpleBullet.png", AssetType.IMAGE);
		path.set ("img/characters/diagdown1.png", "img/characters/diagdown1.png");
		type.set ("img/characters/diagdown1.png", AssetType.IMAGE);
		path.set ("img/characters/diagdown2.png", "img/characters/diagdown2.png");
		type.set ("img/characters/diagdown2.png", AssetType.IMAGE);
		path.set ("img/characters/diagdown3.png", "img/characters/diagdown3.png");
		type.set ("img/characters/diagdown3.png", AssetType.IMAGE);
		path.set ("img/characters/diagup1.png", "img/characters/diagup1.png");
		type.set ("img/characters/diagup1.png", AssetType.IMAGE);
		path.set ("img/characters/diagup2.png", "img/characters/diagup2.png");
		type.set ("img/characters/diagup2.png", AssetType.IMAGE);
		path.set ("img/characters/diagup3.png", "img/characters/diagup3.png");
		type.set ("img/characters/diagup3.png", AssetType.IMAGE);
		path.set ("img/characters/enemyDead.png", "img/characters/enemyDead.png");
		type.set ("img/characters/enemyDead.png", AssetType.IMAGE);
		path.set ("img/characters/jason.png", "img/characters/jason.png");
		type.set ("img/characters/jason.png", AssetType.IMAGE);
		path.set ("img/characters/north1.png", "img/characters/north1.png");
		type.set ("img/characters/north1.png", AssetType.IMAGE);
		path.set ("img/characters/north2.png", "img/characters/north2.png");
		type.set ("img/characters/north2.png", AssetType.IMAGE);
		path.set ("img/characters/north3.png", "img/characters/north3.png");
		type.set ("img/characters/north3.png", AssetType.IMAGE);
		path.set ("img/characters/side1.png", "img/characters/side1.png");
		type.set ("img/characters/side1.png", AssetType.IMAGE);
		path.set ("img/characters/side2.png", "img/characters/side2.png");
		type.set ("img/characters/side2.png", AssetType.IMAGE);
		path.set ("img/characters/side3.png", "img/characters/side3.png");
		type.set ("img/characters/side3.png", AssetType.IMAGE);
		path.set ("img/characters/south1.png", "img/characters/south1.png");
		type.set ("img/characters/south1.png", AssetType.IMAGE);
		path.set ("img/characters/south2.png", "img/characters/south2.png");
		type.set ("img/characters/south2.png", AssetType.IMAGE);
		path.set ("img/characters/south21.png", "img/characters/south21.png");
		type.set ("img/characters/south21.png", AssetType.IMAGE);
		path.set ("img/characters/south22.png", "img/characters/south22.png");
		type.set ("img/characters/south22.png", AssetType.IMAGE);
		path.set ("img/characters/south23.png", "img/characters/south23.png");
		type.set ("img/characters/south23.png", AssetType.IMAGE);
		path.set ("img/characters/south3.png", "img/characters/south3.png");
		type.set ("img/characters/south3.png", AssetType.IMAGE);
		path.set ("img/characters/start1.png", "img/characters/start1.png");
		type.set ("img/characters/start1.png", AssetType.IMAGE);
		path.set ("img/characters/start2.png", "img/characters/start2.png");
		type.set ("img/characters/start2.png", AssetType.IMAGE);
		path.set ("img/characters/start3.png", "img/characters/start3.png");
		type.set ("img/characters/start3.png", AssetType.IMAGE);
		path.set ("img/guns/pistol/p_diagdown.png", "img/guns/pistol/p_diagdown.png");
		type.set ("img/guns/pistol/p_diagdown.png", AssetType.IMAGE);
		path.set ("img/guns/pistol/p_diagup.png", "img/guns/pistol/p_diagup.png");
		type.set ("img/guns/pistol/p_diagup.png", AssetType.IMAGE);
		path.set ("img/guns/pistol/p_down.png", "img/guns/pistol/p_down.png");
		type.set ("img/guns/pistol/p_down.png", AssetType.IMAGE);
		path.set ("img/guns/pistol/p_side.png", "img/guns/pistol/p_side.png");
		type.set ("img/guns/pistol/p_side.png", AssetType.IMAGE);
		path.set ("img/guns/pistol/p_up.png", "img/guns/pistol/p_up.png");
		type.set ("img/guns/pistol/p_up.png", AssetType.IMAGE);
		path.set ("img/guns/shotgun/shot_diagdown.png", "img/guns/shotgun/shot_diagdown.png");
		type.set ("img/guns/shotgun/shot_diagdown.png", AssetType.IMAGE);
		path.set ("img/guns/shotgun/shot_diagup.png", "img/guns/shotgun/shot_diagup.png");
		type.set ("img/guns/shotgun/shot_diagup.png", AssetType.IMAGE);
		path.set ("img/guns/shotgun/shot_down.png", "img/guns/shotgun/shot_down.png");
		type.set ("img/guns/shotgun/shot_down.png", AssetType.IMAGE);
		path.set ("img/guns/shotgun/shot_side.png", "img/guns/shotgun/shot_side.png");
		type.set ("img/guns/shotgun/shot_side.png", AssetType.IMAGE);
		path.set ("img/guns/shotgun/shot_up.png", "img/guns/shotgun/shot_up.png");
		type.set ("img/guns/shotgun/shot_up.png", AssetType.IMAGE);
		path.set ("img/logo.png", "img/logo.png");
		type.set ("img/logo.png", AssetType.IMAGE);
		path.set ("img/maps/level1.csv", "img/maps/level1.csv");
		type.set ("img/maps/level1.csv", AssetType.TEXT);
		path.set ("img/maps/level1.oel", "img/maps/level1.oel");
		type.set ("img/maps/level1.oel", AssetType.TEXT);
		path.set ("img/maps/levelOne.oel", "img/maps/levelOne.oel");
		type.set ("img/maps/levelOne.oel", AssetType.TEXT);
		path.set ("img/maps/lvl1.csv", "img/maps/lvl1.csv");
		type.set ("img/maps/lvl1.csv", AssetType.TEXT);
		path.set ("img/maps/mapTiles.png", "img/maps/mapTiles.png");
		type.set ("img/maps/mapTiles.png", AssetType.IMAGE);
		path.set ("img/maps/mapTiles_olg.png", "img/maps/mapTiles_olg.png");
		type.set ("img/maps/mapTiles_olg.png", AssetType.IMAGE);
		path.set ("img/maps/tilemap.png", "img/maps/tilemap.png");
		type.set ("img/maps/tilemap.png", AssetType.IMAGE);
		path.set ("img/maps/tilemapdata.csv", "img/maps/tilemapdata.csv");
		type.set ("img/maps/tilemapdata.csv", AssetType.TEXT);
		path.set ("img/pointer/crosshairBig.png", "img/pointer/crosshairBig.png");
		type.set ("img/pointer/crosshairBig.png", AssetType.IMAGE);
		path.set ("img/pointer/crosshairSmall.png", "img/pointer/crosshairSmall.png");
		type.set ("img/pointer/crosshairSmall.png", AssetType.IMAGE);
		path.set ("pointer/crosshairBig.png", "pointer/crosshairBig.png");
		type.set ("pointer/crosshairBig.png", AssetType.IMAGE);
		path.set ("pointer/crosshairSmall.png", "pointer/crosshairSmall.png");
		type.set ("pointer/crosshairSmall.png", AssetType.IMAGE);
		path.set ("characters/diagdown1.png", "characters/diagdown1.png");
		type.set ("characters/diagdown1.png", AssetType.IMAGE);
		path.set ("characters/diagdown2.png", "characters/diagdown2.png");
		type.set ("characters/diagdown2.png", AssetType.IMAGE);
		path.set ("characters/diagdown3.png", "characters/diagdown3.png");
		type.set ("characters/diagdown3.png", AssetType.IMAGE);
		path.set ("characters/diagup1.png", "characters/diagup1.png");
		type.set ("characters/diagup1.png", AssetType.IMAGE);
		path.set ("characters/diagup2.png", "characters/diagup2.png");
		type.set ("characters/diagup2.png", AssetType.IMAGE);
		path.set ("characters/diagup3.png", "characters/diagup3.png");
		type.set ("characters/diagup3.png", AssetType.IMAGE);
		path.set ("characters/enemyDead.png", "characters/enemyDead.png");
		type.set ("characters/enemyDead.png", AssetType.IMAGE);
		path.set ("characters/jason.png", "characters/jason.png");
		type.set ("characters/jason.png", AssetType.IMAGE);
		path.set ("characters/north1.png", "characters/north1.png");
		type.set ("characters/north1.png", AssetType.IMAGE);
		path.set ("characters/north2.png", "characters/north2.png");
		type.set ("characters/north2.png", AssetType.IMAGE);
		path.set ("characters/north3.png", "characters/north3.png");
		type.set ("characters/north3.png", AssetType.IMAGE);
		path.set ("characters/side1.png", "characters/side1.png");
		type.set ("characters/side1.png", AssetType.IMAGE);
		path.set ("characters/side2.png", "characters/side2.png");
		type.set ("characters/side2.png", AssetType.IMAGE);
		path.set ("characters/side3.png", "characters/side3.png");
		type.set ("characters/side3.png", AssetType.IMAGE);
		path.set ("characters/south1.png", "characters/south1.png");
		type.set ("characters/south1.png", AssetType.IMAGE);
		path.set ("characters/south2.png", "characters/south2.png");
		type.set ("characters/south2.png", AssetType.IMAGE);
		path.set ("characters/south21.png", "characters/south21.png");
		type.set ("characters/south21.png", AssetType.IMAGE);
		path.set ("characters/south22.png", "characters/south22.png");
		type.set ("characters/south22.png", AssetType.IMAGE);
		path.set ("characters/south23.png", "characters/south23.png");
		type.set ("characters/south23.png", AssetType.IMAGE);
		path.set ("characters/south3.png", "characters/south3.png");
		type.set ("characters/south3.png", AssetType.IMAGE);
		path.set ("characters/start1.png", "characters/start1.png");
		type.set ("characters/start1.png", AssetType.IMAGE);
		path.set ("characters/start2.png", "characters/start2.png");
		type.set ("characters/start2.png", AssetType.IMAGE);
		path.set ("characters/start3.png", "characters/start3.png");
		type.set ("characters/start3.png", AssetType.IMAGE);
		path.set ("sounds/music/01_labyrinth.mp3", "sounds/music/01_labyrinth.mp3");
		type.set ("sounds/music/01_labyrinth.mp3", AssetType.MUSIC);
		path.set ("sounds/ShotgunShot.mp3", "sounds/ShotgunShot.mp3");
		type.set ("sounds/ShotgunShot.mp3", AssetType.MUSIC);
		path.set ("sounds/simpleGunShot.mp3", "sounds/simpleGunShot.mp3");
		type.set ("sounds/simpleGunShot.mp3", AssetType.MUSIC);
		path.set ("music/01_labyrinth.mp3", "music/01_labyrinth.mp3");
		type.set ("music/01_labyrinth.mp3", AssetType.MUSIC);
		
		
		#elseif html5
		
		var id;
		id = "flixel/sounds/beep.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "flixel/sounds/flixel.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
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
		id = "img/bullets/simpleBullet.png";
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
		id = "img/logo.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "img/maps/level1.csv";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "img/maps/level1.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "img/maps/levelOne.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "img/maps/lvl1.csv";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "img/maps/mapTiles.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "img/maps/mapTiles_olg.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "img/maps/tilemap.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "img/maps/tilemapdata.csv";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
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
		id = "sounds/music/01_labyrinth.mp3";
		path.set (id, id);
		type.set (id, AssetType.MUSIC);
		id = "sounds/ShotgunShot.mp3";
		path.set (id, id);
		type.set (id, AssetType.MUSIC);
		id = "sounds/simpleGunShot.mp3";
		path.set (id, id);
		type.set (id, AssetType.MUSIC);
		id = "music/01_labyrinth.mp3";
		path.set (id, id);
		type.set (id, AssetType.MUSIC);
		
		
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
		
		className.set ("flixel/sounds/beep.ogg", __ASSET__flixel_sounds_beep_ogg);
		type.set ("flixel/sounds/beep.ogg", AssetType.SOUND);
		
		className.set ("flixel/sounds/flixel.ogg", __ASSET__flixel_sounds_flixel_ogg);
		type.set ("flixel/sounds/flixel.ogg", AssetType.SOUND);
		
		className.set ("flixel/fonts/nokiafc22.ttf", __ASSET__flixel_fonts_nokiafc22_ttf);
		type.set ("flixel/fonts/nokiafc22.ttf", AssetType.FONT);
		
		className.set ("flixel/fonts/monsterrat.ttf", __ASSET__flixel_fonts_monsterrat_ttf);
		type.set ("flixel/fonts/monsterrat.ttf", AssetType.FONT);
		
		className.set ("flixel/images/ui/button.png", __ASSET__flixel_images_ui_button_png);
		type.set ("flixel/images/ui/button.png", AssetType.IMAGE);
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		useManifest = true;
		
		
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
		
		if (className.exists(id)) return AudioBuffer.fromBytes (cast (Type.createInstance (className.get (id), []), ByteArray));
		else return AudioBuffer.fromFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if flash
		
		switch (type.get (id)) {
			
			case TEXT, BINARY:
				
				return cast (Type.createInstance (className.get (id), []), ByteArray);
			
			case IMAGE:
				
				var bitmapData = cast (Type.createInstance (className.get (id), []), BitmapData);
				return bitmapData.getPixels (bitmapData.rect);
			
			default:
				
				return null;
			
		}
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif html5
		
		var bytes:ByteArray = null;
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var data = loader.data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
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
		
		var bytes:ByteArray = null;
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var data = loader.data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
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
	
	
	public override function loadBytes (id:String):Future<ByteArray> {
		
		var promise = new Promise<ByteArray> ();
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
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
			
			var loader = new URLLoader ();
			loader.dataFormat = BINARY;
			loader.onComplete.add (function (_):Void {
				
				promise.complete (loader.data);
				
			});
			loader.onProgress.add (function (_, loaded, total) {
				
				if (total == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (loaded / total);
					
				}
				
			});
			loader.onIOError.add (function (_, e) {
				
				promise.error (e);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getBytes (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<ByteArray> (function () return getBytes (id)));
		
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
			image.src = path.get (id);
			
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
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#elseif (mac && java)
			var bytes = ByteArray.readFile ("../Resources/manifest");
			#elseif ios
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								#if ios
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
			
			var loader = new URLLoader ();
			loader.onComplete.add (function (_):Void {
				
				promise.complete (loader.data);
				
			});
			loader.onProgress.add (function (_, loaded, total) {
				
				if (total == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (loaded / total);
					
				}
				
			});
			loader.onIOError.add (function (_, msg) promise.error (msg));
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getText (id));
			
		}
		
		#else
		
		promise.completeWith (loadBytes (id).then (function (bytes) {
			
			return new Future<String> (function () {
				
				if (bytes == null) {
					
					return null;
					
				} else {
					
					return bytes.readUTFBytes (bytes.length);
					
				}
				
			});
			
		}));
		
		#end
		
		return promise.future;
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }














































































#elseif html5



@:keep #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { super (); name = "Nokia Cellphone FC Small"; } } 
@:keep #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { super (); name = "Monsterrat"; } } 















































































#else



#if (windows || mac || linux || cpp)


@:file("E:/HaxeToolkit/haxe/lib/flixel/4,0,1/assets/sounds/beep.ogg") #if display private #end class __ASSET__flixel_sounds_beep_ogg extends lime.utils.ByteArray {}
@:file("E:/HaxeToolkit/haxe/lib/flixel/4,0,1/assets/sounds/flixel.ogg") #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends lime.utils.ByteArray {}
@:font("E:/HaxeToolkit/haxe/lib/flixel/4,0,1/assets/fonts/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:font("E:/HaxeToolkit/haxe/lib/flixel/4,0,1/assets/fonts/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:image("E:/HaxeToolkit/haxe/lib/flixel/4,0,1/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}



#end
#end

#if (openfl && !flash)
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_nokiafc22_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_monsterrat_ttf (); src = font.src; name = font.name; super (); }}

#end

#end


#end