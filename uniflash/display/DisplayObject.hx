#if !flash9
package uniflash.display;

interface DisplayObject {
	/**
	 * width
	 */
	public var width(getWidth, setWidth): Float;
	private function getWidth(): Float;
	private function setWidth(w: Float): Float;
	/**
	 * height
	 */
	public var height(getHeight, setHeight): Float;
	private function getHeight(): Float;
	private function setHeight(h: Float): Float;
	/**
	 * x
	 */	
	public var x(getX, setX): Float;
	private function getX(): Float;
	private function setX(x: Float): Float;
	/**
	 * y
	 */		
	public var y(getY, setY): Float;
	private function getY(): Float;
	private function setY(y: Float): Float;
	/**
	 * visible
	 */	
	public var visible(isVisible, setVisible): Bool;
	private function isVisible(): Bool;
	private function setVisible(visible: Bool): Bool;
	/**
	 * parent
	 */
	public var parent(getParent, null): MovieClip;
	private function getParent(): MovieClip;
	/**
	 * alpha - between 0 and 1
	 */
	public var alpha(getAlpha, setAlpha): Float;
	private function getAlpha(): Float;
	private function setAlpha(alpha: Float): Float;
	/**
	 * mouseX
	 */		
	public var mouseX(getMouseX, null): Float;
	private function getMouseX(): Float;
	/**
	 * mouseY
	 */		
	public var mouseY(getMouseY, null): Float;
	private function getMouseY(): Float;
	/**
	 * rotation
	 */	
	public var rotation(getRotation, setRotation): Float;
	private function getRotation(): Float;
	private function setRotation(rotation: Float): Float;
	/**
	 * name
	 */	
	public var name(getName, setName): String;
	private function getName(): String;
	private function setName(name: String): String;	
}
#end
