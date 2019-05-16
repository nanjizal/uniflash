#if !flash9
package uniflash.events;

typedef Listener = { object: Dynamic, handlers: List < Dynamic -> Void > };

import uniflash.Lib;

class EventDispatcher {

	// We are a singleton
	static private var instance: EventDispatcher;
	static public function getInstance(): EventDispatcher{
		if (null == instance){
			instance = new EventDispatcher();
		}
		return instance;
	}	
	
	private var eventListeners: Hash<List<Listener>> ;
	private var lastMouseEventObjects: Array<Dynamic>;
	
	private function new() {
		eventListeners = new Hash<List<Listener>>();
		lastMouseEventObjects = new Array<Dynamic>();
		flash.Key.addListener({
			onKeyDown: onKeyDownHandler, 
			onKeyUp: onKeyUpHandler 
		});
		flash.Mouse.addListener({
			onMouseDown: onMouseDownHandler, 
			onMouseUp: onMouseUpHandler, 
			onMouseMove: onMouseMoveHandler, 
			onMouseWheel: onMouseWheelHandler
		});
		flash.Stage.addListener({
			onResize: onResizeHandler
		});
		flash.Selection.addListener({
			onSetFocus: onSetFocusHandler			
		});
		MouseUtils.getInstance().init(onDoubleClickHandler, onSingleClickHandler);
	}
	
	private function mouseOverOutHandlers(mouseEventObjects: Array<Dynamic>, e: Dynamic){
		for (object in mouseEventObjects) {
			if (!Lambda.has(lastMouseEventObjects, object)) {
				e.setCurrentTarget(object);
				var handlers: Array<Dynamic->Void> = object.mouseHandlers.get(MouseEvent.MOUSE_OVER);
				for (handler in handlers) {
					handler(e);	
				}
			}
		}
		for (object in lastMouseEventObjects) {
			if (!Lambda.has(mouseEventObjects, object)) {
				e.setCurrentTarget(object);
				var handlers: Array<Dynamic->Void> = object.mouseHandlers.get(MouseEvent.MOUSE_OUT);
				for (handler in handlers) {
					handler(e);	
				}
			}
		}
		lastMouseEventObjects = mouseEventObjects;
	}
	
	private static function getActiveObjects(object: Dynamic, activeObjects: Array<Dynamic>) {
		var y = MouseUtils.getInstance().mouseY;
		var x = MouseUtils.getInstance().mouseX;
		var children: Array<Dynamic> = object.children;
		for (c in children) {
			if ((c.hitArea != null && c.hitArea.hitTestPoint(x, y, true)) ||
				(c.hitArea == null && c.enabled != false && c._visible && c.hitTestPoint(x, y, true))) {
				getActiveObjects(c, activeObjects);
				activeObjects.push(c);
			}
		}
	}
	
	private static function getLevel(mc: Dynamic): Int {
		return if (mc._target == "/") 1 else mc._target.split("/").length;
	}
	
	private function notify(event: String, e: Dynamic) {
		var stopPropagation = false;
		e.stopPropagation = function() {
			stopPropagation = true;
		}
		if (MouseEvent.isMouseEvent(event)) { // is the hardiest part of EventDispatcher
			var activeObjects = [Lib.current];
			getActiveObjects(Lib.current, activeObjects);
			var sortByLevel = function (o1: Dynamic, o2: Dynamic): Int {
				return getLevel(o1) - getLevel(o2);
			}
			activeObjects.sort(sortByLevel);
			var eventObjects = new Array<Dynamic>(); // objects chain on whith event should be applied

			var activeObject: Dynamic = activeObjects[0]; // entry point for event

			for (object in activeObjects) { // NOTE: this array is ordered
				if (getLevel(object) > getLevel(activeObject)) {
					if (StringTools.startsWith(object._target, activeObject._target)) { // child
						eventObjects.unshift(activeObject); // unshift to get reverce order
						activeObject = object;
					}
				} else if (object.getDepth() > activeObject.getDepth()) {
					if (StringTools.startsWith(object._target, activeObject._parent._target)) { // siblings
						activeObject = object;							
					}
				}
			}			
			eventObjects.unshift(activeObject);
			for (object in eventObjects) { // notify ancestors
				e.setCurrentTarget(object);
				var handlers: Array<Dynamic->Void> = object.mouseHandlers.get(event);
				for (handler in handlers) {
					handler(e);	
				}
				if (stopPropagation) break;
			}

			mouseOverOutHandlers(eventObjects, e);
		} else if (KeyboardEvent.isKeyboardEvent(event)) {
			var focus: Dynamic = Lib.current.stage.focus;
			var activeObjects = [];
			while (focus != null) {
				activeObjects.push(focus);
				focus = focus.getParent();
			}
			var listeners = eventListeners.get(event);
			for (listener in listeners) {
				if (Lambda.has(activeObjects, listener.object) ||  listener.object == Lib.current.stage) {
					notifyListener(listener, e);
					if (stopPropagation) break;					
				}
			}			
		} else {
			var listeners = eventListeners.get(event);
			for (listener in listeners) {
				notifyListener(listener, e);
				if (stopPropagation) break;
			}
		}
	}
	
	private function notifyListener(listener: Listener, e: Dynamic) {
		for (handler in listener.handlers) {
			handler(e);	
		}
	}
	
	private function notifyObject(event: String, object: Dynamic) {
		var listener = getListener(event, object);
		if (listener != null) {
			notifyListener(listener, null);			
		}
	}	
	
	private function isReflectEvent(event: String): Bool {
		return
			switch (event) {
				case Event.ENTER_FRAME: true;
				case Event.CHANGE: true;
				case ContextMenuEvent.MENU_ITEM_SELECT: true;
				default: false;
			}
	}
	
	public function addEventListener(event: String, handler: Dynamic->Void, object: Dynamic): Void {
		if (MouseEvent.isMouseEvent(event)) {
			var eventHandlers = object.mouseHandlers.get(event);
			if (eventHandlers == null) eventHandlers = new Array<Dynamic->Void>();
			eventHandlers.push(handler);			
			object.mouseHandlers.set(event, eventHandlers);
		} else {		
			if (!hasEventListener(event)) {
				eventListeners.set(event, new List<Listener>());
			}
			if (isReflectEvent(event) && !Reflect.hasField(object, event) || Reflect.field(object, event) == null) {
				Reflect.setField(object, event, callback(notifyObject, event, object));
			}
			var listener = getListener(event, object);
			if (listener == null) { // haven't found anything. Create one.
				listener = {object: object, handlers: new List<Dynamic->Void>()};
				eventListeners.get(event).add(listener);
			}	
			listener.handlers.add(handler);
		}
	}
	
	private function getListener(event: String, object: Dynamic): Listener {
		var listeners = eventListeners.get(event);
		for (listener in listeners) {
			if (listener.object == object) {
				return listener;
			}	
		}
		return null;
	}
		
	public function removeEventListener(event: String, handler: Dynamic->Void, object: Dynamic): Void {
		if (MouseEvent.isMouseEvent(event)) {
			var handlers: Array<Dynamic->Void> = object.mouseHandlers.get(event);
			for (h in handlers) {
				if (Reflect.compareMethods(h, handler)) {
					handlers.remove(h);
					return;
				}	
			}
		} else {		
			if (hasEventListener(event)) {
				var listener = getListener(event, object);
				if (listener != null) {
					for (h in listener.handlers) {
						if (Reflect.compareMethods(h, handler)) {
							listener.handlers.remove(h);
							if (isReflectEvent(event) && listener.handlers.length == 0) {
								Reflect.deleteField(object, event);
							}
							return;
						}
					}
				}
			}
		}
		//trace(event + " was NOT removed!");
	}
	
	public function hasEventListener(event: String): Bool {
		return eventListeners.exists(event);
	}
	
	/*
	 * Keyboard
	 */
	private function onKeyDownHandler() {
		notify(KeyboardEvent.KEY_DOWN, new KeyboardEvent(KeyboardEvent.KEY_DOWN));
	} 
	private function onKeyUpHandler() {
		notify(KeyboardEvent.KEY_UP, new KeyboardEvent(KeyboardEvent.KEY_UP));
	}
	
	/*
	 * Mouse
	 */	
	private function onMouseDownHandler() {
		notify(MouseEvent.MOUSE_DOWN, new MouseEvent(MouseEvent.MOUSE_DOWN));
	} 
	private function onMouseUpHandler() {
		notify(MouseEvent.MOUSE_UP, new MouseEvent(MouseEvent.MOUSE_UP));
	} 
	private function onMouseMoveHandler() {
		notify(MouseEvent.MOUSE_MOVE, new MouseEvent(MouseEvent.MOUSE_MOVE));
		//notify(MouseEvent.MOUSE_OUT, new MouseEvent(MouseEvent.MOUSE_OUT));
		//notify(MouseEvent.MOUSE_OVER, new MouseEvent(MouseEvent.MOUSE_OVER));
	}
	private function onDoubleClickHandler() {
		notify(MouseEvent.DOUBLE_CLICK, new MouseEvent(MouseEvent.DOUBLE_CLICK));
	}
	private function onSingleClickHandler() {
		notify(MouseEvent.CLICK, new MouseEvent(MouseEvent.CLICK));
	}
	private function onMouseWheelHandler(delta: Float, scrollTarget: String) {
		var onMouseWheelEvent = new MouseEvent(MouseEvent.MOUSE_WHEEL);
		onMouseWheelEvent.delta = Math.round(delta); // delta is Int in F9
		//TODO: Implement scrollTarget processing
		notify(MouseEvent.MOUSE_WHEEL, onMouseWheelEvent);
	}
	
	/*
	 * Stage
	 */	
	private function onResizeHandler() {
		notify(Event.RESIZE, null);
	}
	
	/*
	 * Selection onSetFocus
	 */
	private function onSetFocusHandler(oldFocus_txt: Dynamic, newFocus_txt: Dynamic) {
		notifyObject(FocusEvent.FOCUS_OUT, oldFocus_txt);		
		notifyObject(FocusEvent.FOCUS_IN, newFocus_txt);		
	}
}
#end
