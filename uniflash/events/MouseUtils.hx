#if !flash9
package uniflash.events;

/* This class emulate onClick, onDoubleClick, onRollOver and onRollOut event in Flash 8 */
class MouseUtils {
	
	// We are a singleton
	static private var instance: MouseUtils;
	static public function getInstance(): MouseUtils{
		if (null == instance){
			instance = new MouseUtils();
		}
		return instance;
	}
	private function new() {
		this.mouseDownCounter = 0;
		this.mouseUpCounter = 0;

		var mouseListener = {
			onMouseDown: processMouseDown,
			onMouseMove: processMouseMove,
			onMouseUp: processMouseUp,
			onMouseWheel: null
		}
		flash.Mouse.addListener(mouseListener);		
	}
	
	private var onDoubleClick: Void -> Void;
	private var onSingleClick: Void -> Void;
	
	private var mouseDownCounter: Int;
	private var mouseUpCounter: Int;
	
	private var mouseTimer: haxe.Timer;
	
	public var mouseX: Float;
	public var mouseY: Float;	
	
	public function init(onDoubleClick: Void -> Void, onSingleClick: Void -> Void) {
		this.onDoubleClick = onDoubleClick;
		this.onSingleClick = onSingleClick;
	}
	
	private function processMouseDown() {
		mouseDownCounter++;
		if (mouseDownCounter == 2) {
			reset();
			onDoubleClick();		
		}
	}
	
	private function processMouseUp() {
		mouseUpCounter++;
		if (mouseUpCounter == 1 && mouseDownCounter == 1) {
			onSingleClick();	
			mouseTimer = new haxe.Timer(300);
			mouseTimer.run = reset;
		} else {
			reset();
		}
	}
	
	public function processMouseMove() {
		mouseX = flash.Lib.current._xmouse;
		mouseY = flash.Lib.current._ymouse;
	}	
	
	public function reset() {
		mouseTimer.stop();	
		mouseDownCounter = 0;
		mouseUpCounter = 0;
	}
	
	public function isListening(): Bool {
		return mouseDownCounter != 0 || mouseUpCounter!=0;
	}
}
#end
