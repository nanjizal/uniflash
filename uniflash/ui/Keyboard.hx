package uniflash.ui;

#if flash9	
typedef Keyboard = flash.ui.Keyboard;
#else
class Keyboard {
	static public var BACKSPACE = flash.Key.BACKSPACE;
	static public var CAPS_LOCK = flash.Key.CAPSLOCK;
	static public var CONTROL = flash.Key.CONTROL;
	static public var DELETE = flash.Key.DELETEKEY;
	static public var DOWN = flash.Key.DOWN;
	static public var END = flash.Key.END;
	static public var ENTER = flash.Key.ENTER;
	static public var ESCAPE = flash.Key.ESCAPE;
	static public var F1 = 112;
	static public var F10 = 121;
	static public var F11 = 122;
	static public var F12 = 123;
	static public var F13 = 124;
	static public var F14 = 125;
	static public var F15 = 126;
	static public var F2 = 113;
	static public var F3 = 114;
	static public var F4 = 115;
	static public var F5 = 116;
	static public var F6 = 117;
	static public var F7 = 118;
	static public var F8 = 119;
	static public var F9 = 120;
	static public var HOME = flash.Key.HOME;
	static public var INSERT = flash.Key.INSERT;
	static public var LEFT = flash.Key.LEFT;
	/* TODO: Implement
	static public var NUMPAD_0 = flash.Key.BACKSPACE;
	static public var NUMPAD_1 = flash.Key.BACKSPACE;
	static public var NUMPAD_2 = flash.Key.BACKSPACE;
	static public var NUMPAD_3 = flash.Key.BACKSPACE;
	static public var NUMPAD_4 = flash.Key.BACKSPACE;
	static public var NUMPAD_5 = flash.Key.BACKSPACE;
	static public var NUMPAD_6 = flash.Key.BACKSPACE;
	static public var NUMPAD_7 = flash.Key.BACKSPACE;
	static public var NUMPAD_8 = flash.Key.BACKSPACE;
	static public var NUMPAD_9 = flash.Key.BACKSPACE;
	static public var NUMPAD_ADD = flash.Key.BACKSPACE;
	static public var NUMPAD_DECIMAL = flash.Key.BACKSPACE;
	static public var NUMPAD_DIVIDE = flash.Key.BACKSPACE;
	static public var NUMPAD_ENTER = flash.Key.BACKSPACE;
	static public var NUMPAD_MULTIPLY = flash.Key.BACKSPACE;
	static public var NUMPAD_SUBTRACT = flash.Key.BACKSPACE;
	*/
	static public var PAGE_DOWN = flash.Key.PGDN;
	static public var PAGE_UP = flash.Key.PGUP;
	static public var RIGHT = flash.Key.RIGHT;
	static public var SHIFT = flash.Key.SHIFT;
	static public var SPACE = flash.Key.SPACE;
	static public var TAB = flash.Key.TAB;
	static public var UP = flash.Key.UP;
	/* TODO: Implement
	static public var capsLock(default,null) : Bool;
	static public function isAccessible() : Bool;
	static public var numLock(default,null) : Bool;
	*/
	static public var ALT = 18;
}	
#end
