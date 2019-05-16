package uniflash.display;

#if flash9
	typedef CapsStyle = flash.display.CapsStyle;
#else
	class CapsStyle {
		public static var NONE = "none";
		public static var ROUND = "round";
		public static var SQUARE = "square";
	}
#end
