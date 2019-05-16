package uniflash.display;

#if flash9
	typedef Graphics = flash.display.Graphics;
#end

class GraphicsFactory {
	public static function getGraphics(mc: MovieClip): Graphics {
#if flash9
	return mc.graphics;
#else
	return new Graphics(mc);
#end
	}
}

#if !flash9
class Graphics {
	private var mc: MovieClip;
	public function new(mc: MovieClip) {
		this.mc = mc;
	}
	public function drawRect(x1: Float, y1:Float, x2: Float, y2: Float) {
		mc.moveTo(x1,y1);
		mc.lineTo(x2,y1);
		mc.lineTo(x2,y2);
		mc.lineTo(x1,y2);
		mc.lineTo(x1,y1);
	}

	public function moveTo(x: Float, y:Float) {
		mc.moveTo(x,y);
	}

	public function lineTo(x: Float, y:Float) {
		mc.lineTo(x,y);
	}

	public function curveTo(controlX : Float, controlY : Float, anchorX : Float, anchorY : Float) {
		mc.curveTo(controlX, controlY, anchorX, anchorY);
	}

	public function clear() {
		mc.clear();
	}

	public function lineStyle(?thickness : Float, ?rgb : Int, ?alpha : Float, ?pixelHinting : Bool, ?noScale : String, ?capsStyle : String, ?jointStyle : String, ?miterLimit : Float) {
		mc.lineStyle(thickness, rgb, alpha, pixelHinting, noScale, capsStyle, jointStyle, miterLimit);
	}

	public function beginFill(rgb : Int, ?alpha : Float) {
		mc.beginFill(rgb, alpha);
	}

	public function endFill() {
		mc.endFill();
	}

}
#end
