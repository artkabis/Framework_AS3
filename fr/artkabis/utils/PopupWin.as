package fr.artkabis.utils
{
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	/**
	* La classe Timeout est utilisable dans un contexte de retardement lié au lancement de fonction
	*
	* @author		NICOLLE-Gregory - Artkabis
	* @version		1.0
	* @date 		26.03.2010
	*
	* @example Dans cet exemple il est créé un Timeout de 2 seconde faisant appel à la fonction Tested
	* 
	*
	* <listing version="1.0">
	*     Timeout.add( 2, 1, Tested, true );
	*		// autre méthode:
	*	  var myTimeout:Timeout = Timeout.add(2,1,Tested,true);
	*	  function Tested() : void { trace("Timeout testé");myTimeout.clear(); }
	*  </listing>
	*/
	public class PopupWin
	{
		/**
		* Variable contenant l'adresse (url) complète à utiliser pour la navigation
		*/
		public static var baseURL:String = '';
		
		/**
		* Récupération du navigateur de l'utilisateur
		*/
		public static var browserName:String = '';
		
		/**
		* Constante regroupant le lancement de la fonction window.open
		*/
		public static const WINDOW_OPEN_FUNCTION:String = "window.open";

		/**
		* Mise en place d'une popup paramètré
		*
		* <p>La mise en place de la popup doit débuter par l'utilisation de la méthode openWindow avec le passage des paramètres, comme ceci :  PopupWin.openWindow(url:String, target:String, options:String) </p>
		*
		* @param $url 		Adresse vers laquelle se fera la popup pointera
		* @param $target 	Mode d'ouverture de la fenêtre :  '_top,_blank, _self'
		* @param $options	Regroupe l'ensemble des options lié à la popup: options:String = "menubar=yes, status=no, toolbar=yes, location=1, scrollbars=yes, resizable=1";
		* @see PopupWin
		*/
		public static function openWindow(url:String="", target:String = '_blank', options:String=""):void
		{
			if (PopupWin.baseURL != ''){url = PopupWin.baseURL + url;}
			var myURL:URLRequest = new URLRequest(url);
			if (PopupWin.browserName == ''){PopupWin.browserName = PopupWin.getBrowserName();}
			
			switch (PopupWin.browserName)
			{
				// Si FF detécté
				case "Firefox":
					ExternalInterface.call(WINDOW_OPEN_FUNCTION, url, target, options);
				   break;
				// Si IE detécté
				case "IE":
					ExternalInterface.call("function setWMWindow() {window.open('" + url + "', '"+target+"', '"+options+"');}");
					break;
				// Si Safari ou Opera detécté
				case "Safari":
				case "Opera":
				//sinon l'ouverture standare est appelé
				default:
					navigateToURL(myURL, target);
					break;
			}
		}
		
		private static function getBrowserName():String
		{
			var browser:String;
			var browserAgent:String = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");
			
			if(browserAgent != null && browserAgent.indexOf("Firefox")>= 0) {
				browser = "Firefox";
			}
			else if(browserAgent != null && browserAgent.indexOf("Safari")>= 0){
				browser = "Safari";
			}
			else if(browserAgent != null && browserAgent.indexOf("MSIE")>= 0){
				browser = "IE";
			}
			else if(browserAgent != null && browserAgent.indexOf("Opera")>= 0){
				browser = "Opera";
			}
			else {
				browser = "Undefined";
			}
			return (browser);
		}
		/**
		* Gestion des fenêtre d'aide
		* <p>Méthode utilisé pour récupérer la fenêtre d'aide</p>
		*
		* @param $screen 		paramètre lié à l'écran de la popup, par défaut le paramètre est sur "home"
		**/
		public static function showHelp(screen:String = 'home') :void
		{
			//var options:String = "menubar=yes,status=no,toolbar=yes,location=1,scrollbars=yes,resizable=1";
			PopupWin.openWindow(screen, '_help');
		}
	}
}


