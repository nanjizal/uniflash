package uniflash.events;

#if flash9	
typedef KeyboardEvent = flash.events.KeyboardEvent;	
#else
class KeyboardEvent extends Event{
	static public var KEY_DOWN = "onKeyDown";
	static public var KEY_UP = "onKeyUp";	
	
	public var type: String;	
	public var keyCode: Int;
	public var altKey: Bool;
	public var ctrlKey: Bool;
	public var shiftKey: Bool;
	
	public function new(type: String) {
		this.type = type;
		this.keyCode = flash.Key.getCode();
		this.altKey = flash.Key.isDown(flash.Key.ALT);
		this.ctrlKey = flash.Key.isDown(flash.Key.CONTROL);
		this.shiftKey = flash.Key.isDown(flash.Key.SHIFT);
	}
	
	static public function isKeyboardEvent(event: String): Bool {
		return switch(event) {
			case KEY_DOWN, KEY_UP: true;
			default: false;
		}
	}	
}
#end
