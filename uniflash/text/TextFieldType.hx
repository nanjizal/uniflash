package uniflash.text;

#if flash9
	typedef TextFieldType = flash.text.TextFieldType;
#else
	class TextFieldType {
		public static var INPUT = "input";
		public static var DYNAMIC = "dynamic";
	}
#end
