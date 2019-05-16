package uniflash.display;
/**
 * We introduce an alias for MovieClip which works in Flash 7, 8 & 9.
 **/
#if flash9
	typedef MovieClip = flash.display.MovieClip;
#else
	import uniflash.events.EventDispatcher;
	import uniflash.events.MouseEvent;

	class MovieClip extends flash.MovieClip, implements DisplayObject {
		
		public var root(getRoot, null): MovieClip;
		private inline function getRoot(): MovieClip {
				return uniflash.display.MovieClipUtils.convert(flash.Lib._root);
		}
		
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
		public var mouseEnabled(isMouseEnabled, setMouseEnabled): Bool;
		private inline function isMouseEnabled(): Bool {
			return this.enabled;
		}
		private inline function setMouseEnabled(enabled: Bool): Bool {
			return this.enabled = enabled;
		}		
		/**
		 * scaleX - between 0 and 1
		 */		
		public var scaleX(getScaleX, setScaleX): Float;
		private inline function getScaleX(): Float {
			return this._xscale / 100.0;
		}
		private inline function setScaleX(scaleX: Float): Float {
			this._xscale = scaleX * 100.0;
			return scaleX;
		}
		/**
		 * scaleY - between 0 and 1
		 */		
		public var scaleY(getScaleY, setScaleY): Float;
		private inline function getScaleY(): Float {
			return this._yscale / 100.0;
		}
		private inline function setScaleY(scaleY: Float): Float {
			this._yscale = scaleY * 100.0;
			return scaleY;
		}
		/**
		 * buttonMode - fake property used to set hand mouse cursor to movieClip
		 * Cursor will appear only if useHandCursor is true (default value)
		 */	
		public var buttonMode(getButtonMode, setButtonMode): Bool;
		private inline function getButtonMode(): Bool {
			return Reflect.hasField(this, "onPress");
		}
		private inline function setButtonMode(buttonMode: Bool): Bool {
			if (buttonMode) Reflect.setField(this, "onPress", null) else Reflect.deleteField(this, "onPress");
			return buttonMode;
		}
		/**
		 * contextMenu
		 */
		public var contextMenu(getContextMenu, setContextMenu): flash.ContextMenu;
		private inline function getContextMenu(): flash.ContextMenu {
			return Reflect.field(this, "menu");
		}
		private inline function setContextMenu(contextMenu: flash.ContextMenu): flash.ContextMenu {
			Reflect.setField(this, "menu", contextMenu);
			return contextMenu;
		}
		/**
		 * Get the object on which graphics should be drawn.
		 * I.e. clear(), moveTo(x,y), lineTo(x,y) and so on are
		 * done on this object.
		 */	
		public var graphics(getGraphics, null): flash.MovieClip;
		private inline function getGraphics(): flash.MovieClip {
			return this;
		}
		/**
		 * stage
		 */
		public var stage(getStage, null): Stage;
		private inline function getStage(): Stage {
			return uniflash.display.Stage.getInstance();
		}
		/**
		 * hitTestPoint
		 * Test whether the point is in the given clip. Notice! Pixels with an alpha
		 * channel of 0 are hit! Only exception is vector-based graphics where it
		 * correctly detects misses.
		 */
		// NOTE: don't inline this function as it have optional argument shapeFlag
		public function hitTestPoint(x: Float, y: Float, ?shapeFlag: Bool): Bool {
			return this.hitTest(x, y, shapeFlag);
		}
		/**
		 * event Listeners 
		 */
		public var children: Array<DisplayObject>;	
		public var mouseHandlers: Hash<Array<Dynamic->Void>>;	
		public inline function addEventListener(event: String, handler: Dynamic -> Void): Void {
			EventDispatcher.getInstance().addEventListener(event, handler, this);
		}
		public function removeEventListener(event: String, handler: Dynamic -> Void): Void {
			EventDispatcher.getInstance().removeEventListener(event, handler, this);
		}
		
		/**
		 *  Graphics methods - beginFill
		 */
		public override function beginFill(rgb: Int, ?alpha: Float): Void {
			if (alpha == null) alpha = 100 else alpha = MovieClipUtils.convertAlpha(alpha);
			super.beginFill(rgb, alpha);
		}
		/**
		 *  Graphics methods - beginGradientFill
		 */
		#if flash8
			public override function beginGradientFill(fillType: String, colors: Array<Int>, alphas: Array<Dynamic>, ratios: Array<Dynamic>, matrix: Dynamic, ?spreadMethod: String, ?interpolationMethod: String, ?focalPointRatio: Float ): Void {
				alphas = MovieClipUtils.convertAlphas(alphas);
				super.beginGradientFill(fillType, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
			}
		#elseif flash7
			public override function beginGradientFill(fillType: String, colors: Array<Int>, alphas: Array<Dynamic>, ratios: Array<Dynamic>, matrix: Dynamic): Void {
				alphas = MovieClipUtils.convertAlphas(alphas);
				super.beginGradientFill(fillType, colors, alphas, ratios, matrix);			
			}
		#end
		/**
		 *  Graphics methods - lineStyle
		 */	
		#if flash8	
			public override function lineStyle(?thickness: Float, ?rgb: Int, ?alpha: Float, ?pixelHinting: Bool, ?noScale: String, ?capsStyle: String, ?jointStyle: String, ?miterLimit: Float): Void {
				if (alpha == null) alpha = 100 else alpha = MovieClipUtils.convertAlpha(alpha);
				super.lineStyle(thickness, rgb, alpha, pixelHinting, noScale, capsStyle, jointStyle, miterLimit);
			}
		#elseif flash7
			public override function lineStyle(?thickness: Float, ?rgb: Int, ?alpha: Float): Void {
				if (alpha == null) alpha = 100 else alpha = MovieClipUtils.convertAlpha(alpha);
				alpha = MovieClipUtils.convertAlpha(alpha);
				super.lineStyle(thickness, rgb, alpha);			
			}
		#end	
		
		#if flash7
			public var cacheAsBitmap: Bool;
			/**
			 * ScrollRect
			 */
			public var scrollRect(getScrollRect, setScrollRect): uniflash.geom.Rectangle;
			private function getScrollRect(): uniflash.geom.Rectangle {
				var rect = Reflect.field(this, "scrollRect");
				return rect.clone();
			}
			private function setScrollRect(rect: uniflash.geom.Rectangle): uniflash.geom.Rectangle {
				var oldRect = scrollRect;
				if (oldRect != null) {
					this.x += oldRect.left;
					this.y += oldRect.top;
				}
				Reflect.setField(this, "scrollRect", rect);
				var maskClip = Reflect.field(this, "scrollMask");
				if (rect == null) {
					if (maskClip == null) {
						return rect;
					}
					MovieClipUtils.remove(maskClip);
					Reflect.setField(this, "scrollMask", null);
					return rect;
				}
				if (maskClip == null) {
					maskClip = MovieClipUtils.create(this);
					Reflect.setField(this, "scrollMask", maskClip);
				}
				var g = maskClip.graphics;
				g.clear();
				g.beginFill(0xffffff);				
				g.moveTo(rect.left, rect.top);
				g.lineTo(rect.left + rect.width, rect.top);
				g.lineTo(rect.left + rect.width, rect.top + rect.height);
				g.lineTo(rect.left, rect.top + rect.height);
				g.lineTo(rect.left, rect.top);
				g.endFill();
				this.setMask(maskClip);
				this.x -= rect.left;
				this.y -= rect.top;
				return rect;
			}			
		#end

	}
#end