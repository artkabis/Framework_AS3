package fr.artkabis.net
{
	import flash.external.ExternalInterface;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import  fr.artkabis.errors.ErreurArgument;
	import fr.artkabis.utils.Localisation;
	
	public class NavigURL 
	{
		public static const WINDOW_SELF:String   = '_self';
		public static const WINDOW_BLANK:String  = '_blank';
		public static const WINDOW_PARENT:String = '_parent';
		public static const WINDOW_TOP:String    = '_top';
		
		
		public static function ouvreUrl(request:*, window:String = NavigURL.WINDOW_SELF):void 
		{
			if (request is String)
				request = new URLRequest(request);
			else if (!(request is URLRequest))
				throw new ErreurArgument('request');
			
			if (window == NavigURL.WINDOW_BLANK && ExternalInterface.available && !Localisation.isIde() && request.data == null)
				if (NavigURL.ouvreWindow(request.url, window))
					return;
			
			navigateToURL(request, window);
		}
		
		public static function ouvreWindow(url:String, window:String = NavigURL.WINDOW_BLANK, features:String = ""):Boolean 
		{
			return ExternalInterface.call("function ouvrirWindow(url, windowOrName, features) { return window.open(url, windowOrName, features) != null; }", url, (window == NavigURL.WINDOW_BLANK) ? 'casaWindow' + int(1000 * Math.random()) : window, features);
		}
	}
}