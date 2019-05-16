package uniflash.geom;

#if flash9
	typedef Matrix = flash.geom.Matrix;
#elseif flash8
	typedef Matrix = flash.geom.Matrix;
#else
	class Matrix {	
		public var matrixType: String;
		public var w: Float;
		public var h: Float;
		public var r: Float;
		public var x: Float;
		public var y: Float;
		 
		public function new() {
		}	
		public function createGradientBox(width: Float, height: Float, ?rot: Float, ?tx: Float, ?ty: Float): Void {
			matrixType = "box";
			w = width;
			h = height;
			r = rot;
			x = tx;
			y = ty;
		}
	}
 #end