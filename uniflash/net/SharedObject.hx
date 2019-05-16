package uniflash.net;
#if flash9	
typedef SharedObject = flash.net.SharedObject;
#else
class SharedObject extends flash.SharedObject {
	public static function getLocal(name: String, ?localPath: String, ?secure: Bool): SharedObject {
		#if flash8
		var so = flash.SharedObject.getLocal(name, localPath, secure);
		#else
		var so = flash.SharedObject.getLocal(name, localPath);
		#end
		untyped so.__proto__ = SharedObject.prototype;
		return cast so;
	}
}
#end
