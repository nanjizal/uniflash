package uniflash.display;

#if flash9
	typedef StageScaleMode = flash.display.StageScaleMode;
#else
	class StageScaleMode {
		public static var EXACT_FIT = "exactFit";
		public static var NO_BORDER = "noBorder";
		public static var NO_SCALE = "noScale";
		public static var SHOW_ALL = "showAll";
	}
#end
