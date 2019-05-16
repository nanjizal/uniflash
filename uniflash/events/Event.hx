package uniflash.events;

#if flash9
	typedef Event = flash.events.Event;
#else
	class Event {
		public static var ENTER_FRAME = "onEnterFrame";
		public static var RESIZE = "onResize";
		public static var CHANGE = "onChanged";
		
		public var stopPropagation: Void -> Void;
	}
#end
