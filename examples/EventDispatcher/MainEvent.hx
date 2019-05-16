import uniflash.display.MovieClipUtils;
import uniflash.display.MovieClip;
import uniflash.events.MouseEvent;
import uniflash.text.TextFieldUtils;
import uniflash.text.TextField;
import uniflash.Lib;
import arctic.DrawUtils;

class MainEvent {
	
	static function main() {
		var mc1 = MovieClipUtils.create(Lib.current);
		DrawUtils.drawRectangle(mc1, 0, 0, 300, 300, 0, 0x000000, 0x0000ff);
		mc1.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandlerBlue);
		
		var mc3 = MovieClipUtils.create(mc1);
		DrawUtils.drawRectangle(mc3, 0, 0, 100, 100, 0, 0x000000, 0x00ff00);
		mc3.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandlerGreen);		
		
		var mc2 = MovieClipUtils.create(Lib.current);
		DrawUtils.drawRectangle(mc2, 0, 0, 100, 100, 0, 0x000000, 0xff0000);
		mc2.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandlerRed);
		mc2.x = 50;
		mc2.y = 50;
		
		var tf1 = TextFieldUtils.create(mc2, 0, 0, 100, 30);
		tf1.text = "TEST";
		tf1.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandlerText);	
	}
	
	private static function mouseDownHandlerGreen(e: MouseEvent) {
		trace("green");
		e.stopPropagation();
	}
	private static function mouseDownHandlerRed(e: MouseEvent) {
		trace("red");
	}
	private static function mouseDownHandlerBlue(e: MouseEvent) {
		trace("blue");
	}
	private static function mouseDownHandlerText(e: MouseEvent) {
		trace("text");
	}	
}
