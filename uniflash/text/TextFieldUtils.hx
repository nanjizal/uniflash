package uniflash.text;

import uniflash.text.TextField;
import uniflash.display.MovieClipUtils;

#if flash9
	typedef UniflashTextField = flash.text.TextField;
#else
	typedef UniflashTextField = flash.TextField;
#end

/**
 * Helper class for uniflash.text.TextField - contains only static functions
 **/
class TextFieldUtils {
	
	public static var amount: Int = 0; // Total amount of textFields, used for statistics
	
	public static function create(parent: UniflashMovieClip, x: Float, y: Float, width: Float, height: Float): TextField {
		amount++;
		#if flash9
			var tf = new TextField();
			tf.x = x;
			tf.y = y;
			tf.width = width;
			tf.height = height;
			parent.addChild(tf);
			return tf;		
		#elseif flash8
			var d = parent.getNextHighestDepth();
			var tf = parent.createTextField("t" + d, d, x, y, width, height);
			tf.html = true; // In ActionScript 3.0, all text fields are treated as HTML text fields.
			var t = convert(tf);
			t.parent.children.push(t);
			return t;
		#elseif flash7
			var d = parent.getNextHighestDepth();
			parent.createTextField("t" + d, d, x, y, width, height);
			var tf: TextField = Reflect.field(parent, "t" + d);
			tf.html = true; // In ActionScript 3.0, all text fields are treated as HTML text fields.
			var t = convert(tf);
			t.parent.children.push(t);			
			return t;
		#end
	}
	
	public static function convert(tf: UniflashTextField): TextField {
		#if flash9
			return cast tf;
		#else
			if (Std.is(tf, TextField)) return cast tf;
			untyped tf.__proto__ = TextField.prototype;
			var t: TextField = cast tf;
			t.children = new Array<uniflash.display.DisplayObject>();
			t.mouseHandlers = new Hash<Array<Dynamic->Void>>();	
			return t;
		#end
	}
	
	/**
	 *  Remove this text field from it's parent
	 */
	public static function remove(field: TextField) {
		amount--;
		#if flash9
			field.parent.removeChild(field);
		#else
			field.parent.children.remove(field);
			field.removeTextField();
		#end
	}
	
	/*
	 * setTextFormat - static helper method. We can't override it with different parameters order.
	 */
	public static function setTextFormat(field: TextField, format: TextFormat, beginIndex: Int, endIndex: Int) {
		#if flash9
			field.setTextFormat(format, beginIndex, endIndex);
		#else
			field.setTextFormat(beginIndex, endIndex, format);
		#end
	}
	/**
	 * setTextRenderingQuality
	 * If sharpness is null, normal rendering is used.
	 * gridFit parameter: 0 is none, 1 is pixel, 2 is subpixel
	 */	
	public static function setTextRenderingQuality(field: TextField, sharpness: Null<Float>, ?gridFit: Int) {
		if (sharpness != null) {
			field.sharpness = sharpness;
			field.antiAliasType = AntiAliasType.ADVANCED;
			field.gridFitType = if (gridFit == 1) { GridFitType.PIXEL; } 
							else if (gridFit == 2) { GridFitType.SUBPIXEL; } else { GridFitType.NONE; };
		} else {
			field.antiAliasType = AntiAliasType.NORMAL;
		}
	}
	/**
	 * mouseHitTest - test wether mouse inside textField or not
	 */		
	public static function mouseHitTest(tf: TextField): Bool {
		return tf.mouseX > 0 && tf.mouseX < tf.width && tf.mouseY > 0 && tf.mouseY < tf.height;
	}	
	
}