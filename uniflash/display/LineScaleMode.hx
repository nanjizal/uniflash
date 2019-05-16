package uniflash.display;

#if flash9
	typedef LineScaleMode = flash.display.LineScaleMode;
#else
	class LineScaleMode {
		public static var HORIZONTAL = "horizontal";
		public static var NONE = "none";
		public static var NORMAL = "normal";
		public static var VERTICAL = "vertical";
	}
#end
