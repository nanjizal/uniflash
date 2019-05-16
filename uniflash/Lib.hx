package uniflash;

import uniflash.display.MovieClipUtils;

class Lib {
	/**
	 * current
	 */
	public static var current = MovieClipUtils.convert(flash.Lib.current);
	/**
	 * fscommand
	 */	
	static public function fscommand(cmd: String, ?param: Dynamic) {
		flash.Lib.fscommand(cmd, param);
	}
	
	/*
	 *  This method emultate Flash 7,8 flah.Lib.getURL for F9
	 */
	static public function getURL(url: String, ?target:String) {
		#if flash9
			flash.Lib.getURL(new flash.net.URLRequest(url), target);
		#else
			flash.Lib.getURL(url, target);
		#end
	}	
}
