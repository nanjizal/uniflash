package uniflash.geom;

#if flash9
 typedef Point = flash.geom.Point;
#elseif flash8
 typedef Point = flash.geom.Point<Float>;
#else
class Point {
	public var x : Float;
	public var y : Float;
	
	public function new(x0 : Float, y0 : Float) {
		x = x0;
		y = y0;
	}
	
	static public function distance(p1 : Point, p2 : Point) : Float {
		return Math.sqrt((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y));
	}	
}
#end
