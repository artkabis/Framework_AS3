package fr.artkabis.utils {
	import flash.display.DisplayObject;
	import flash.system.Capabilities;
	
	public class Localisation {

		public static function isWeb(location:DisplayObject):Boolean {
			return location.loaderInfo.url.substr(0, 4) == 'http';
		}
		
		public static function isDomain(location:DisplayObject, domain:String):Boolean {
			return Localisation.getDomain(location).slice(-domain.length) == domain;
		}
		public static function getDomain(location:DisplayObject):String {
			var baseUrl:String = location.loaderInfo.url.split('://')[1].split('/')[0];
			return (baseUrl.substr(0, 4) == 'www.') ? baseUrl.substr(4) : baseUrl;
		}
		public static function isPlugin():Boolean {
			return Capabilities.playerType == 'PlugIn' || Capabilities.playerType == 'ActiveX';
		}
		public static function isIde():Boolean {
			return Capabilities.playerType == 'External';
		}
		
		public static function isStandAlone():Boolean {
			return Capabilities.playerType == 'StandAlone';
		}
		
		public static function isAirApplication():Boolean {
			return Capabilities.playerType == 'Desktop';
		}
	}
}