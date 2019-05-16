package uniflash.net;
#if flash9	
	typedef LocalConnection = flash.net.LocalConnection;
#else
	class LocalConnection extends flash.LocalConnection {
		public override function connect(id: String): Bool {
			if (!super.connect(id)) throw "Connection with id " + id + " already exists";
			return true;
		}
	}
#end
