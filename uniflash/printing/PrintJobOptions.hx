package uniflash.printing;

#if flash9
	typedef PrintJobOptions = flash.printing.PrintJobOptions
#else
	class PrintJobOptions {
		public var printAsBitmap: Bool;
		public function new(?printAsBitmap: Bool) {
			this.printAsBitmap = printAsBitmap;
		}
	}
#end
