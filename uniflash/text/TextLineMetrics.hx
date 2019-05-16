package uniflash.text;

#if flash9
	typedef TextLineMetrics = flash.text.TextLineMetrics;
#else
	class TextLineMetrics {
		public var ascent: Float;
		public var descent: Float;
		public var height: Float;
		public var leading: Float;
		public var width: Float;
		public var x: Float;
		
		public function new(x: Float, width: Float, height: Float, ascent: Float, descent: Float, leading: Float): Void {
			this.x = x;
			this.width = width;
			this.height = height;
			this.ascent = ascent;
			this.descent = descent;
			this.leading = leading;
		}
	}
#end
