#if !macro


@:access(lime.app.Application)
@:access(lime.Assets)
@:access(openfl.display.Stage)


class ApplicationMain {
	
	
	public static var config:lime.app.Config;
	public static var preloader:openfl.display.Preloader;
	
	
	public static function create ():Void {
		
		var app = new openfl.display.Application ();
		app.create (config);
		
		var display = new NMEPreloader ();
		
		preloader = new openfl.display.Preloader (display);
		app.setPreloader (preloader);
		preloader.onComplete.add (init);
		preloader.create (config);
		
		#if (js && html5)
		var urls = [];
		var types = [];
		
		
		urls.push ("flixel/sounds/beep.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("flixel/sounds/flixel.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("Nokia Cellphone FC Small");
		types.push (lime.Assets.AssetType.FONT);
		
		
		urls.push ("Monsterrat");
		types.push (lime.Assets.AssetType.FONT);
		
		
		urls.push ("flixel/images/ui/button.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/atlas/spritemap.json");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("img/atlas/spritesheet.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/diagdown1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/diagdown2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/diagdown3.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/diagup1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/diagup2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/diagup3.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/enemyDead.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/jason.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/north1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/north2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/north3.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/side1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/side2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/side3.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/south1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/south2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/south21.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/south22.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/south23.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/south3.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/start1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/start2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/characters/start3.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/pistol/p_diagdown.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/pistol/p_diagup.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/pistol/p_down.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/pistol/p_side.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/pistol/p_up.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/shotgun/shot_diagdown.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/shotgun/shot_diagup.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/shotgun/shot_down.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/shotgun/shot_side.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/shotgun/shot_up.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/maps/level1.csv");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("img/maps/level1.oel");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("img/maps/levelOne.oel");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("img/maps/lvl1.csv");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("img/maps/mapTiles.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/maps/mapTiles_olg.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/maps/tilemap.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/maps/tilemapdata.csv");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("img/pointer/crosshairBig.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/pointer/crosshairSmall.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("pointer/crosshairBig.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("pointer/crosshairSmall.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/diagdown1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/diagdown2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/diagdown3.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/diagup1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/diagup2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/diagup3.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/enemyDead.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/jason.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/north1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/north2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/north3.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/side1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/side2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/side3.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/south1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/south2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/south21.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/south22.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/south23.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/south3.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/start1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/start2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("characters/start3.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("sounds/music/01_labyrinth.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("sounds/ShotgunShot.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("sounds/simpleGunShot.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("music/01_labyrinth.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		
		if (config.assetsPrefix != null) {
			
			for (i in 0...urls.length) {
				
				if (types[i] != lime.Assets.AssetType.FONT) {
					
					urls[i] = config.assetsPrefix + urls[i];
					
				}
				
			}
			
		}
		
		preloader.load (urls, types);
		#end
		
		var result = app.exec ();
		
		#if (sys && !nodejs && !emscripten)
		Sys.exit (result);
		#end
		
	}
	
	
	public static function init ():Void {
		
		var loaded = 0;
		var total = 0;
		var library_onLoad = function (__) {
			
			loaded++;
			
			if (loaded == total) {
				
				start ();
				
			}
			
		}
		
		preloader = null;
		
		
		
		
		if (total == 0) {
			
			start ();
			
		}
		
	}
	
	
	public static function main () {
		
		config = {
			
			build: "120",
			company: "GastonIgnacio",
			file: "Obligatorio",
			fps: 60,
			name: "Obligatorio",
			orientation: "",
			packageName: "Obligatorio",
			version: "1.0.0",
			windows: [
				
				{
					antialiasing: 0,
					background: 0,
					borderless: false,
					depthBuffer: false,
					display: 0,
					fullscreen: false,
					hardware: true,
					height: 480,
					parameters: "{}",
					resizable: true,
					stencilBuffer: true,
					title: "Obligatorio",
					vsync: false,
					width: 800,
					x: null,
					y: null
				},
			]
			
		};
		
		#if hxtelemetry
		var telemetry = new hxtelemetry.HxTelemetry.Config ();
		telemetry.allocations = true;
		telemetry.host = "localhost";
		telemetry.app_name = config.name;
		Reflect.setField (config, "telemetry", telemetry);
		#end
		
		#if (js && html5)
		#if (munit || utest)
		openfl.Lib.embed (null, 800, 480, "000000");
		#end
		#else
		create ();
		#end
		
	}
	
	
	public static function start ():Void {
		
		var hasMain = false;
		var entryPoint = Type.resolveClass ("Main");
		
		for (methodName in Type.getClassFields (entryPoint)) {
			
			if (methodName == "main") {
				
				hasMain = true;
				break;
				
			}
			
		}
		
		lime.Assets.initialize ();
		
		if (hasMain) {
			
			Reflect.callMethod (entryPoint, Reflect.field (entryPoint, "main"), []);
			
		} else {
			
			var instance:DocumentClass = Type.createInstance (DocumentClass, []);
			
			/*if (Std.is (instance, openfl.display.DisplayObject)) {
				
				openfl.Lib.current.addChild (cast instance);
				
			}*/
			
		}
		
		#if !flash
		if (openfl.Lib.current.stage.window.fullscreen) {
			
			openfl.Lib.current.stage.dispatchEvent (new openfl.events.FullScreenEvent (openfl.events.FullScreenEvent.FULL_SCREEN, false, false, true, true));
			
		}
		
		openfl.Lib.current.stage.dispatchEvent (new openfl.events.Event (openfl.events.Event.RESIZE, false, false));
		#end
		
	}
	
	
	#if neko
	@:noCompletion @:dox(hide) public static function __init__ () {
		
		var loader = new neko.vm.Loader (untyped $loader);
		loader.addPath (haxe.io.Path.directory (Sys.executablePath ()));
		loader.addPath ("./");
		loader.addPath ("@executable_path/");
		
	}
	#end
	
	
}


@:build(DocumentClass.build())
@:keep class DocumentClass extends Main {}


#else


import haxe.macro.Context;
import haxe.macro.Expr;


class DocumentClass {
	
	
	macro public static function build ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				
				var method = macro {
					
					openfl.Lib.current.addChild (this);
					super ();
					dispatchEvent (new openfl.events.Event (openfl.events.Event.ADDED_TO_STAGE, false, false));
					
				}
				
				fields.push ({ name: "new", access: [ APublic ], kind: FFun({ args: [], expr: method, params: [], ret: macro :Void }), pos: Context.currentPos () });
				
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
}


#end
