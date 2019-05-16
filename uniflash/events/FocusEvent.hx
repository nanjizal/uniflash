package uniflash.events;

#if flash9	
	typedef FocusEvent = flash.events.FocusEvent;
#else	
	class FocusEvent {
		public static var FOCUS_IN = "focusIn";
		public static var FOCUS_OUT = "focusOut";
	}
#end
