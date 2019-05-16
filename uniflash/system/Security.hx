package uniflash.system;
#if flash9	
typedef Security = flash.system.Security;
#else
class Security extends flash.system.Security{
	public static var allowDomain = flash.system.Security.allowDomain;
	public static var allowInsecureDomain = flash.system.Security.allowInsecureDomain;
	public static var loadPolicyFile = flash.system.Security.allowInsecureDomain;
	public static var showSettings = flash.System.showSettings;
}
#end
