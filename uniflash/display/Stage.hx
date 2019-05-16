#if !flash9
package uniflash.display;

import uniflash.events.EventDispatcher;

class Stage {
	
	static private var instance: Stage;
	static public function getInstance(): Stage{
		if (null == instance){
			instance = new Stage();
		}
		return instance;
	}

	private function new() {}
	/*
	 * stageWidth
	 */
	public var stageWidth(getStageWidth, null): Int;
	private inline function getStageWidth(): Int {
		return Math.round(flash.Stage.width);
	}	
	/*
	 * stageHeight
	 */
	public var stageHeight(getStageHeight, null): Int;
	private inline function getStageHeight(): Int {
		return Math.round(flash.Stage.height);
	}
	/*
	 * scaleMode
	 */
	public var scaleMode(getScaleMode, setScaleMode): String;
	private inline function getScaleMode(): String {
		return flash.Stage.scaleMode;
	}
	private inline function setScaleMode(scaleMode: String): String {
		return flash.Stage.scaleMode = scaleMode;
	}	
	/*
	 * align
	 */
	public var align(getAlign, setAlign): String;
	private inline function getAlign(): String {
		return flash.Stage.align;
	}
	private inline function setAlign(align: String): String {
		return flash.Stage.align = align;
	}
	/*
	 * focus
	 */
	public var focus(getFocus, setFocus): Dynamic;
	private inline function getFocus() {
		return flash.Lib.eval(flash.Selection.getFocus());
	}
	private inline function setFocus(object) {
		return if (flash.Selection.setFocus(object)) object else null;
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
