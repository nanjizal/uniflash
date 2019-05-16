package uniflash.geom;

#if flash9
 typedef Rectangle = flash.geom.Rectangle;
#elseif flash8
 typedef Rectangle = flash.geom.Rectangle<Float>;
#else
	class Rectangle {
		public function new(left0 : Float, top0 : Float, width0 : Float, height0 : Float) {
			left = left0;
			top = top0;
			width = width0;
			height = height0;
		}
		public function intersects(r : Rectangle) : Bool {
			var rangeOverlap = function (a1 : Float, a2 : Float, b1 : Float, b2 : Float) : Bool {
				if (a2 < b1) return false;
				if (a1 > b2) return false;
				return true;
			}
			// Rectangles intersect if both X and Y ranges overlap
			return rangeOverlap(left, left + width, r.left, r.left + r.width)
				&& rangeOverlap(top, top + height, r.top, r.top + r.height);
		}
		public function containsPoint(p : Point) : Bool {
			var pointIn = function (a1 : Float, a2 : Float, p : Float) : Bool {
				if (a1 < p) return false;
				if (a2 > p) return false;
				return true;
			}
			return pointIn(left, left + width, p.x) && pointIn(top, top + height, p.y);
		}
		public var left : Float;
		public var top : Float;
		public var width : Float;
		public var height : Float;
		
		public var right(getRight, setRight): Float;
		public var bottom(getBottom, setBottom): Float;
		
		private function getRight(): Float {
			return left + width;
		}
		
		private function setRight(v: Float): Float {
			width = v - left;
			return getRight();
		}
		
		private function getBottom(): Float {
			return top + height;
		}
		
		private function setBottom(v: Float): Float {
			height = v - top;
			return getBottom();
		}
		
		public function clone(): Rectangle {
			return new Rectangle(left, top, width, height);
		}
	}
#end
