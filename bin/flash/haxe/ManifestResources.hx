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

		data = '{"name":null,"assets":"aoy4:sizei11560y4:typey4:TEXTy9:classNamey40:__ASSET__data_fonts_opensans_license_txty2:idy37:data%2Ffonts%2Fopensans%2FLICENSE.txtgoR0i217534R1y6:BINARYR3y41:__ASSET__data_fonts_opensans_opensans_eotR5y38:data%2Ffonts%2Fopensans%2Fopensans.eotgoR0i255450R1R2R3y41:__ASSET__data_fonts_opensans_opensans_svgR5y38:data%2Ffonts%2Fopensans%2Fopensans.svggoR0i217360R1y4:FONTR3y41:__ASSET__data_fonts_opensans_opensans_ttfR5y38:data%2Ffonts%2Fopensans%2Fopensans.ttfgoR0i112572R1R7R3y42:__ASSET__data_fonts_opensans_opensans_woffR5y39:data%2Ffonts%2Fopensans%2Fopensans.woffgoR0i18780R1R7R3y43:__ASSET__data_fonts_opensans_opensans_woff2R5y40:data%2Ffonts%2Fopensans%2Fopensans.woff2goR0i6838R1R2R3y35:__ASSET__data_how_to_add_assets_txtR5y34:data%2Fhow%20to%20add%20assets.txtgoR0i62678R1y5:IMAGER3y22:__ASSET__data_icon_pngR5y15:data%2Ficon.pnggh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
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

@:keep @:bind #if display private #end class __ASSET__data_fonts_opensans_license_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__data_fonts_opensans_opensans_eot extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__data_fonts_opensans_opensans_svg extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__data_fonts_opensans_opensans_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__data_fonts_opensans_opensans_woff extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__data_fonts_opensans_opensans_woff2 extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__data_how_to_add_assets_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__data_icon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends flash.utils.ByteArray { }


#elseif (desktop || cpp)

@:keep @:file("data/fonts/opensans/LICENSE.txt") #if display private #end class __ASSET__data_fonts_opensans_license_txt extends haxe.io.Bytes {}
@:keep @:file("data/fonts/opensans/opensans.eot") #if display private #end class __ASSET__data_fonts_opensans_opensans_eot extends haxe.io.Bytes {}
@:keep @:file("data/fonts/opensans/opensans.svg") #if display private #end class __ASSET__data_fonts_opensans_opensans_svg extends haxe.io.Bytes {}
@:keep @:font("data/fonts/opensans/opensans.ttf") #if display private #end class __ASSET__data_fonts_opensans_opensans_ttf extends lime.text.Font {}
@:keep @:file("data/fonts/opensans/opensans.woff") #if display private #end class __ASSET__data_fonts_opensans_opensans_woff extends haxe.io.Bytes {}
@:keep @:file("data/fonts/opensans/opensans.woff2") #if display private #end class __ASSET__data_fonts_opensans_opensans_woff2 extends haxe.io.Bytes {}
@:keep @:file("data/how to add assets.txt") #if display private #end class __ASSET__data_how_to_add_assets_txt extends haxe.io.Bytes {}
@:keep @:image("data/icon.png") #if display private #end class __ASSET__data_icon_png extends lime.graphics.Image {}
@:keep @:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__data_fonts_opensans_opensans_ttf') #if display private #end class __ASSET__data_fonts_opensans_opensans_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "data/fonts/opensans/opensans.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Open Sans"; super (); }}


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
