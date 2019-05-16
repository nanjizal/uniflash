package uniflash.system;
#if flash9
typedef SecurityPanel = flash.system.SecurityPanel;
#else
class SecurityPanel {
	public static var CAMERA = 3;
	//public static var DEFAULT = ;
	public static var LOCAL_STORAGE = 1;
	public static var MICROPHONE = 2;
	public static var PRIVACY = 0;
	//public static var SETTINGS_MANAGER = ;
}
#end
