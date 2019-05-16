package uniflash.events;

#if flash9
	typedef ContextMenuEvent = flash.events.ContextMenuEvent;
#else
	class ContextMenuEvent extends Event {
		public static var MENU_ITEM_SELECT = "onSelect";
		public static var MENU_SELECT = "onSelect";
	}
#end
