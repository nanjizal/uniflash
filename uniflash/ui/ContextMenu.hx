package uniflash.ui;
#if flash9
	typedef ContextMenu = flash.ui.ContextMenu;
#else
	import uniflash.events.EventDispatcher;
	class ContextMenu extends flash.ContextMenu {
		public function new() {
			super(null);
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
