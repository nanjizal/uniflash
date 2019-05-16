package uniflash.events;

#if flash9	
	typedef MouseEvent = flash.events.MouseEvent;
#else	
	class MouseEvent extends Event{
		public var type: String;
		public var delta: Int;		
		public var altKey: Bool;
		public var ctrlKey: Bool;
		public var shiftKey: Bool;
		public var localX: Float;
		public var localY: Float;
		public var stageX(default,null): Float;
		public var stageY(default, null): Float;
		private var currentTarget: Dynamic;
		
		public function new(type: String) {
			this.type = type;
			this.altKey = flash.Key.isDown(flash.Key.ALT);
			this.ctrlKey = flash.Key.isDown(flash.Key.CONTROL);
			this.shiftKey = flash.Key.isDown(flash.Key.SHIFT);
			this.stageX = MouseUtils.getInstance().mouseX;
			this.stageY = MouseUtils.getInstance().mouseY;
			this.currentTarget = null;
		}
		
		public function setCurrentTarget(target: Dynamic): Dynamic {
			this.currentTarget = target;
			var stagePoint = {x: stageX, y: stageY};
			currentTarget.globalToLocal(stagePoint);
			this.localX = stagePoint.x;
			this.localY = stagePoint.y;
		}
		
		static public var MOUSE_WHEEL = "mouseWheel";
		static public var MOUSE_UP = "mouseUp";
		static public var MOUSE_DOWN = "mouseDown";
		static public var MOUSE_MOVE = "mouseMove";
		static public var CLICK = "click";
		static public var DOUBLE_CLICK = "doubleClick";
		
		static public var MOUSE_OUT = "mouseOut";
		static public var MOUSE_OVER = "mouseOver";
		//static public var ROLL_OUT: String = flash.events.MouseEvent.ROLL_OUT;
		//static public var ROLL_OVER: String = flash.events.MouseEvent.ROLL_OVER;
		
		static public function isMouseEvent(event: String): Bool {
			return switch(event) {
				case MOUSE_UP, MOUSE_DOWN, MOUSE_MOVE, MOUSE_WHEEL, MOUSE_OUT, MOUSE_OVER, CLICK, DOUBLE_CLICK: true;
				default: false;
			}
		}	
	}
#end
