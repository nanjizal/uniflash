package uniflash.ui;
#if flash9	
	typedef ContextMenuItem = flash.ui.ContextMenuItem;
	typedef UniflashContextMenuItem = flash.ui.ContextMenuItem;
#else
	typedef UniflashContextMenuItem = flash.ContextMenuItem;
	import uniflash.events.EventDispatcher;
	class ContextMenuItem extends flash.ContextMenuItem {
		public function new(caption: String, ?separatorBefore: Bool, ?enabled: Bool, ?visible: Bool): Void {
			super(caption, null, separatorBefore, enabled, visible);
		}
		/**
		 * event Listeners 
		 */
		public inline function addEventListener(event: String, handler: Dynamic -> Void): Void {
			EventDispatcher.getInstance().addEventListener(event, handler, this);
		}
		public inline function removeEventListener(event: String, handler: Dynamic -> Void): Void {
			EventDispatcher.getInstance().removeEventListener(event, handler, this);
		}
	}
#end
