package uniflash.printing;

#if flash9
	typedef PrintJob = flash.printing.PrintJob
#else
	class PrintJob extends flash.PrintJob {
		public override function addPage(target: Dynamic, ?printArea: Dynamic, ?options: Dynamic, ?frameNum: Float): Bool {
			var pa = { xMin: printArea.left, xMax: printArea.right, yMin: printArea.top, yMax: printArea.bottom };
			var result = super.addPage(target, pa, options, frameNum);
			if (!result) throw "Error: Can't add page for printing";
			return true;
		}
	}
#end
