package uniflash.text;

#if flash9
	typedef GridFitType = flash.text.GridFitType;
#else
	class GridFitType {
		static public var NONE = "none";
		static public var PIXEL = "pixel";
		static public var SUBPIXEL = "subpixel";		
	}
#end