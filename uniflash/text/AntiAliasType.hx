package uniflash.text;

#if flash9
	typedef AntiAliasType = flash.text.AntiAliasType;
#else
	class AntiAliasType {
		static public var ADVANCED = "advanced";
		static public var NORMAL = "normal";
	}
#end