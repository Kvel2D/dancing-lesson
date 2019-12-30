package;


import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#elseif (sys && windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end

		}

		Assets.defaultRootPath = rootPath;

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__data_fonts_opensans_opensans_ttf);
		
		#end

		var data, manifest, library;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy37:data%2Ffonts%2Fopensans%2FLICENSE.txty4:sizei11560y4:typey4:TEXTy2:idR1y7:preloadtgoR0y38:data%2Ffonts%2Fopensans%2Fopensans.eotR2i217534R3y6:BINARYR5R7R6tgoR0y38:data%2Ffonts%2Fopensans%2Fopensans.svgR2i255450R3R4R5R9R6tgoR2i217360R3y4:FONTy9:classNamey41:__ASSET__data_fonts_opensans_opensans_ttfR5y38:data%2Ffonts%2Fopensans%2Fopensans.ttfR6tgoR0y39:data%2Ffonts%2Fopensans%2Fopensans.woffR2i112572R3R8R5R14R6tgoR0y40:data%2Ffonts%2Fopensans%2Fopensans.woff2R2i18780R3R8R5R15R6tgoR0y34:data%2Fhow%20to%20add%20assets.txtR2i6838R3R4R5R16R6tgoR0y15:data%2Ficon.pngR2i62678R3y5:IMAGER5R17R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__data_fonts_opensans_license_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__data_fonts_opensans_opensans_eot extends null { }
@:keep @:bind #if display private #end class __ASSET__data_fonts_opensans_opensans_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__data_fonts_opensans_opensans_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__data_fonts_opensans_opensans_woff extends null { }
@:keep @:bind #if display private #end class __ASSET__data_fonts_opensans_opensans_woff2 extends null { }
@:keep @:bind #if display private #end class __ASSET__data_how_to_add_assets_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__data_icon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("data/fonts/opensans/LICENSE.txt") #if display private #end class __ASSET__data_fonts_opensans_license_txt extends haxe.io.Bytes {}
@:keep @:file("data/fonts/opensans/opensans.eot") #if display private #end class __ASSET__data_fonts_opensans_opensans_eot extends haxe.io.Bytes {}
@:keep @:file("data/fonts/opensans/opensans.svg") #if display private #end class __ASSET__data_fonts_opensans_opensans_svg extends haxe.io.Bytes {}
@:keep @:font("bin/html5/obj/webfont/opensans.ttf") #if display private #end class __ASSET__data_fonts_opensans_opensans_ttf extends lime.text.Font {}
@:keep @:file("data/fonts/opensans/opensans.woff") #if display private #end class __ASSET__data_fonts_opensans_opensans_woff extends haxe.io.Bytes {}
@:keep @:file("data/fonts/opensans/opensans.woff2") #if display private #end class __ASSET__data_fonts_opensans_opensans_woff2 extends haxe.io.Bytes {}
@:keep @:file("data/how to add assets.txt") #if display private #end class __ASSET__data_how_to_add_assets_txt extends haxe.io.Bytes {}
@:keep @:image("data/icon.png") #if display private #end class __ASSET__data_icon_png extends lime.graphics.Image {}
@:keep @:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__data_fonts_opensans_opensans_ttf') #if display private #end class __ASSET__data_fonts_opensans_opensans_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "data/fonts/opensans/opensans"; #else ascender = 2189; descender = -600; height = 2789; numGlyphs = 938; underlinePosition = -205; underlineThickness = 102; unitsPerEM = 2048; #end name = "Open Sans"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__data_fonts_opensans_opensans_ttf') #if display private #end class __ASSET__OPENFL__data_fonts_opensans_opensans_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__data_fonts_opensans_opensans_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__data_fonts_opensans_opensans_ttf') #if display private #end class __ASSET__OPENFL__data_fonts_opensans_opensans_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__data_fonts_opensans_opensans_ttf ()); super (); }}

#end

#end
#end

#end
