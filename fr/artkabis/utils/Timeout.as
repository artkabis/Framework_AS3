package fr.artkabis.utils
{
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	
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

	public class Timeout
	{
		/**
		* Timer utiliser pour le lancement de la fonction
		*/
		private static var _timer          :Timer;
		
		
		/**
		* Delai utilisé pour lancer la fonction
		*/
		private static var _delai          :Number;
		
		/**
		* Repetion prévut pour un relancement éventuel du Timeout
		*/
		private static var _repetition     :int;
		
		/**
		* Fonction passé en paramètre et joué une fois le delai dépassé
		*/
		private static var _fonction       :Function;
		
		/**
		* Activation du mode seconde, si false le delai est prévut en milliseconde
		*/
		private static var _seconde        :Boolean;
		
		/**
		* Constructor
		*/
		public function Timeout(){}
		
		
		/**
		* Creation d'un Timeout
		*
		* <p>La mise en place du Timeout doit passer par la méthode add.</p>
		*
		* @param $delai 		delai en seconde ou milliseconde écoulé avant le lancement de la fonction.
		* @param $repetition 	Nombre de repetion vers le relancement du delai entrenant l'appel de la fonction.
		* @param $fonction		Fonction appeé une fois le delai imparti dépassé
		* @param $seconde		Activation du mode seconde, si sa valeur est false le délai sera lu en milliseconde
		* @see Timeout
		*/

		public static function add ($delai:Number=0,$repetition:int=1,$fonction:Function=null,$seconde=false)
		{
			_delai      = $delai;
			_repetition = $repetition;
			_fonction   = $fonction
			_seconde    = $seconde;
			
			if(_seconde){_timer = new Timer(_delai* 1000,_repetition);
			}else { _timer = new Timer(_delai,_repetition);}
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE,__completTimer);
		}
		/**
		* Lancement de la fin du Timer
		*/
		public static function __completTimer(te:TimerEvent):void{
			if(_fonction!=null)
			{
				_fonction();
			}
			clear();
		}
		
		
		/**
		* Suppression du Timeout, on l'utilise de cette manière Timeout.clear()
		*/
		public static function clear():void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,__completTimer);
		}
		public static function toString():String
        {
            return "Timeout" ;
        };
	}
}