package uniflash.text;

#if flash9
	typedef TextFieldAutoSize = flash.text.TextFieldAutoSize;
#else
	class TextFieldAutoSize {
		public static var CENTER = "center";
		public static var LEFT = "left";
		public static var NONE = "none";
		public static var RIGHT = "right";
	}
#end
