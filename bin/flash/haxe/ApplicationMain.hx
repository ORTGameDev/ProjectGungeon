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
		
		
		urls.push ("img/atlas/enemies/Boss.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/atlas/enemies/GreenOrc.json");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("img/atlas/enemies/GreenOrc.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/atlas/enemies/Skeleton.json");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("img/atlas/enemies/Skeleton.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/atlas/enemies/Summoner.json");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("img/atlas/enemies/Summoner.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/atlas/players/PlayerOne.json");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("img/atlas/players/PlayerOne.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/atlas/spritemap.json");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("img/atlas/spritesheet.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/barrels/Barrel.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/barrels/explosion_01.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/barrels/explosion_02.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/barrels/explosion_03.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/bullets/Bullets001.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/bullets/Bullets002.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/bullets/Bullets003.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/pistol/p_diagdown.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/pistol/p_diagup.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/pistol/p_down.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/pistol/p_pick - Copy.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/pistol/p_pick.png");
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
		
		
		urls.push ("img/guns/shotgun/shot_pick - Copy.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/shotgun/shot_pick.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/shotgun/shot_side.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/shotgun/shot_up.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/smg/smg_pick - Copy.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/guns/smg/smg_pick.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/jarBreakable.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/logo.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/pointer/crosshairBig.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/pointer/crosshairSmall.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/sprite_0.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/sprite_1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/sprite_2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("pointer/crosshairBig.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("pointer/crosshairSmall.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("barrels/Barrel.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("barrels/explosion_01.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("barrels/explosion_02.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("barrels/explosion_03.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("sounds/barrelExplotion.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("sounds/gunPickUp.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("sounds/healPickUp.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("sounds/LoadnShot.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("sounds/music/background.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("sounds/pistolShot.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("sounds/shotgunShot.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("music/background.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("maps/level1.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("maps/level2/level2.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("maps/level2/mapTiles.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("maps/level3/level2 - copia.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("maps/level3/level3.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("maps/level3/mapTiles.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("maps/level4/level4.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("maps/level4/mapTiles.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("maps/level4/mapTiles_old.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("maps/mapTiles.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		
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
			
			build: "614",
			company: "GastonIgnacio",
			file: "Obligatorio",
			fps: 60,
			name: "Welcome to the Gungle",
			orientation: "landscape",
			packageName: "com.gastonignacio.obligatorio",
			version: "1.0.0",
			windows: [
				
				{
					antialiasing: 4,
					background: 132360,
					borderless: true,
					depthBuffer: false,
					display: 0,
					fullscreen: false,
					hardware: true,
					height: 600,
					parameters: "{}",
					resizable: false,
					stencilBuffer: true,
					title: "Welcome to the Gungle",
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
		openfl.Lib.embed (null, 800, 600, "020508");
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
