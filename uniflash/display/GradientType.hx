package uniflash.display;

#if flash9
	typedef GradientType = flash.display.GradientType;
#else
	class GradientType {
		static public var LINEAR = "linear";	
		static public var RADIAL = "radial";
	}
#end
