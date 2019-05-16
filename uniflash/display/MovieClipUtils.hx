package uniflash.display;

import uniflash.display.MovieClip;
import uniflash.geom.Point;

#if flash9
	typedef UniflashMovieClip = flash.display.MovieClip;
	typedef DisplayObjectContainer = flash.display.DisplayObjectContainer;
#else
	typedef UniflashMovieClip = flash.MovieClip;
	typedef DisplayObjectContainer = uniflash.display.MovieClip;
#end

/**
 * Helper class for uniflash.display.MovieClip - contains only static functions
 **/
class MovieClipUtils {
	
	public static var amount: Int = 0; // Total amount of movieclips, used for statistics

	public static function create(parent: DisplayObjectContainer): MovieClip {	
		#if flash9
			amount++;
			var clip = new MovieClip();
			parent.addChild(clip);
			return clip;
		#else
			amount++;
			var d = parent.getNextHighestDepth();
			var clip = parent.createEmptyMovieClip("c" + d, d);
			var mc = MovieClipUtils.convert(clip);
			parent.children.push(mc);
			return mc;
		#end
	}
	
	public static function convert(clip: UniflashMovieClip): MovieClip {
		#if flash9
			return clip;
		#else
			if (Std.is(clip, MovieClip)) return cast clip;
			untyped clip.__proto__ = MovieClip.prototype;
			var mc: MovieClip = cast clip;
			mc.children = new Array<DisplayObject>();
			mc.mouseHandlers = new Hash<Array<Dynamic->Void>>();
			return mc;
		#end
	}
	
	/**
	 *  Remove this clip from it's parent
	 */
	public static function remove(clip: MovieClip): Void {
		amount--;
		#if flash9
			if (clip.parent != null) clip.parent.removeChild(clip);
			if (flash.Lib.current.stage.focus == clip) { // remove clip wich is in focus
				flash.Lib.current.stage.focus = null; // reset focus manually because of flash bug
			}
		#else
			clip.parent.children.remove(clip);
			clip.removeMovieClip();
		#end
	}
	/**
	 *  Attach MovieClip by it's idName from resources
	 */	
	public static function attach(parent: MovieClip, idName: String): MovieClip {
		amount++;
		#if flash9
			if (Type.resolveClass(idName) == null) return null;
			var clip = flash.Lib.attach(idName);
			parent.addChild(clip);
			return clip;
		#else
			var d = parent.getNextHighestDepth();
			var clip = parent.attachMovie(idName, "c" + d, d);
			var mc = MovieClipUtils.convert(clip);
			parent.children.push(mc);
			return mc;
		#end
	}

	public static inline function bringToFront(clip: UniflashMovieClip) {
		#if flash9
			return clip.parent.setChildIndex(clip, clip.parent.numChildren - 1);
		#else
			return clip.swapDepths(clip._parent.getNextHighestDepth());
		#end
	}
	
	public static inline function sendToBack(clip: UniflashMovieClip) {
		#if flash9
			return clip.parent.setChildIndex(clip, 0);
		#else
			return clip.swapDepths(0);
		#end
	}	
	
	public static inline function getMouseXY(): {x: Float, y: Float} {
		#if flash9
			return {x: flash.Lib.current.mouseX, y: flash.Lib.current.mouseY};
		#else
			return {x: flash.Lib.current._xmouse, y: flash.Lib.current._ymouse};
		#end
	}
	
	public static inline function globalToLocal(mc: DisplayObjectContainer, point: Point): Point {
		#if flash9
			return mc.globalToLocal(point);
		#else
			var newPoint = point;
			mc.globalToLocal(newPoint);
			return newPoint;
		#end
	}

	public static inline function localToGlobal(mc: DisplayObjectContainer, point: Point): Point {
		#if flash9
			return mc.localToGlobal(point);
		#else
			var newPoint = point;
			mc.localToGlobal(newPoint);
			return newPoint;
		#end
	}	
	
	// NOTE: Dont't inline this function because it has optional parameter
	public static function mouseHitTest(clip: MovieClip, ?shapeFlag: Bool): Bool {
		var mouseXY = MovieClipUtils.getMouseXY();
	    return clip.hitTestPoint(mouseXY.x, mouseXY.y, shapeFlag);
	}

	/**
	 *  Alpha conversion. Do nothing for flash 9.
	 */		
	public static inline function convertAlpha(alpha: Float): Float {
		#if flash9
			return alpha;
		#else
			return alpha * 100;
		#end		
	}
	#if flash9	
		public static inline function convertAlphas(alphas: Array<Dynamic>): Array<Dynamic> {
			return alphas;
		}
	#else
		// NOTE: Dont't inline this function because it contains closures
		public static function convertAlphas(alphas: Array<Dynamic>): Array<Dynamic> {
				return Lambda.array(Lambda.map(alphas, function(alpha: Dynamic) { return alpha * 100; } ));
		}
	#end	
}