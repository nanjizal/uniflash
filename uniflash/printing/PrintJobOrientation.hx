package uniflash.printing;

#if flash9
	typedef PrintJobOrientation = flash.printing.PrintJobOrientation
#else
	class PrintJobOrientation {
		public static var PORTRAIT = "portrait";
		public static var LANDSCAPE = "landscape";
	}
#end
