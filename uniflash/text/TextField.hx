package uniflash.text;
/**
 * We introduce an alias for MovieClip which works in Flash 7, 8 & 9.
 **/
#if flash9
	typedef TextField = flash.text.TextField;
#else
	import uniflash.events.EventDispatcher;
	import uniflash.events.MouseEvent;	
	import uniflash.display.DisplayObject;
	import uniflash.text.TextFormat;
	import uniflash.display.MovieClipUtils;
	import uniflash.display.MovieClip;

	class TextField extends flash.TextField, implements DisplayObject {
		/**
		 * width
		 */
		public var width(getWidth, setWidth): Float;
		private inline function getWidth(): Float {
				return this._width;
		}
		private inline function setWidth(w: Float): Float {
			return this._width = w;
		}
		/**
		 * height
		 */
		public var height(getHeight, setHeight): Float;
		private inline function getHeight(): Float {
				return this._height;
		}
		private inline function setHeight(h: Float): Float {
			return this._height = h;
		}
		/**
		 * x
		 */	
		public var x(getX, setX): Float;
		private inline function getX(): Float {
			return this._x;
		}
		private inline function setX(x: Float): Float {
			return this._x = x;
		}
		/**
		 * y
		 */		
		public var y(getY, setY): Float;
		private inline function getY(): Float {
			return this._y;
		}
		private inline function setY(y: Float): Float {
			return this._y = y;
		}
		/**
		 * visible
		 */	
		public var visible(isVisible, setVisible): Bool;
		private inline function isVisible(): Bool {
			return this._visible;
		}
		private inline function setVisible(visible: Bool): Bool {
			return this._visible = visible;
		}	
		/**
		 * parent
		 */
		public var parent(getParent, null): MovieClip;
		private inline function getParent(): MovieClip {
			return MovieClipUtils.convert(this._parent);
		}
		/**
		 * alpha - between 0 and 1
		 */
		public var alpha(getAlpha, setAlpha): Float;
		private inline function getAlpha(): Float {
			return this._alpha / 100;
		}
		private inline function setAlpha(alpha: Float): Float {
			this._alpha = alpha * 100;
			return alpha;
		}
		/**
		 * mouseX
		 */		
		public var mouseX(getMouseX, null): Float;
		private inline function getMouseX(): Float {
			return this._xmouse;
		}
		/**
		 * mouseY
		 */		
		public var mouseY(getMouseY, null): Float;
		private inline function getMouseY(): Float {
			return this._ymouse;
		}		
		/**
		 * rotation
		 */
		public var rotation(getRotation, setRotation): Float;
		private inline function getRotation(): Float {
			return this._rotation;
		}
		private inline function setRotation(rotation: Float): Float {
			return this._rotation = rotation;
		}
		/**
		 * name
		 */
		public var name(getName, setName): String;
		private inline function getName(): String {
			return this._name;
		}
		private inline function setName(name: String): String {
			return this._name = name;
		}		
		/**
		 * mouseEnabled
		 */		
		public var mouseEnabled(default, default): Bool;
		/**
		 * defaultTextFormat
		 */			
		public var defaultTextFormat(getDefaultTextFormat, setDefaultTextFormat): TextFormat;
		private inline function getDefaultTextFormat(): TextFormat {
			return this.getNewTextFormat();
		}
		private inline function setDefaultTextFormat(tf: TextFormat): TextFormat {
			this.setNewTextFormat(tf);
			return tf;
		}
		/**
		 * selectionBeginIndex
		 */			
		public var selectionBeginIndex(getSelectionBeginIndex, null): Int;
		private inline function getSelectionBeginIndex(): Int {
			return flash.Selection.getBeginIndex();
		}
		/**
		 * selectionEndIndex
		 */			
		public var selectionEndIndex(getSelectionEndIndex, null): Int;
		private inline function getSelectionEndIndex(): Int {
			return flash.Selection.getEndIndex();
		}	
		/**
		 * caretIndex
		 */			
		public var caretIndex(getCaretIndex, null): Int;
		private inline function getCaretIndex(): Int {
			return flash.Selection.getCaretIndex();
		}
		/**
		 * setSelection
		 */			
		public function setSelection(beginIndex: Int, endIndex: Int): Void {
			flash.Selection.setSelection(beginIndex, endIndex);
		}
		/**
		 * scrollH
		 */
		public var scrollH(getScrollH, setScrollH): Int;
		private inline function getScrollH(): Int {
			return Math.round(this.hscroll);
		}
		private inline function setScrollH(scrollH: Int): Int {
			return Math.round(this.hscroll = scrollH);
		}
		/**
		 * scrollV
		 */					
		public var scrollV(getScrollV, setScrollV): Int;
		private inline function getScrollV(): Int {
			return Math.round(this.scroll);
		}
		private inline function setScrollV(scrollv: Int): Int {
			return Math.round(this.scroll = scrollV);
		}			
		/**
		 * event Listeners 
		 */
		public var children: Array<DisplayObject>;
		public var mouseHandlers: Hash<Array<Dynamic->Void>>;	
		public inline function addEventListener(event: String, handler: Dynamic -> Void): Void {
			EventDispatcher.getInstance().addEventListener(event, handler, this);
		}
		public inline function removeEventListener(event: String, handler: Dynamic -> Void): Void {
			EventDispatcher.getInstance().removeEventListener(event, handler, this);
		}	
		/**
		 * hitTestPoint
		 */
		// NOTE: don't inline this function as it have optional argument shapeFlag
		public function hitTestPoint(stageX: Float, stageY: Float, ?shapeFlag: Bool): Bool {
			var point = {x: stageX, y: stageY};
			parent.globalToLocal(point); 
			return ((point.x > this.x) && (point.x < this.x + this.width) && (point.y > this.y) && (point.y < this.y + this.height));
		}
		#if flash7
			public var antiAliasType: String;
			public var gridFitType: String;
			public var sharpness: Float;
			public var thickness: Float;			
			public var filters: Array<Dynamic>;
		#end		
	}
#end