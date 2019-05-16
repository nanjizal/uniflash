package uniflash.display;

#if flash9
	typedef StageAlign = flash.display.StageAlign;
#else
	class StageAlign {
		public static var BOTTOM = "B";
		public static var BOTTOM_LEFT = "BL";
		public static var BOTTOM_RIGHT = "BL";
		public static var LEFT = "L";
		public static var RIGHT = "R";
		public static var TOP = "T";
		public static var TOP_LEFT = "TL";
		public static var TOP_RIGHT = "TR";
	}
#end
