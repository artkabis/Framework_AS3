package classes.utils{ 
	import flash.display.Loader; 
	import flash.display.MovieClip; 
	import flash.errors.IOError; 
	import flash.events.Event; 
	import flash.events.IOErrorEvent; 
	import flash.events.ProgressEvent; 
	import flash.filters.GradientGlowFilter; 
	import flash.net.URLRequest; 
	import flash.events.EventDispatcher; 
     
	/** 
 	* ... 
	* @author Théo Stocchetti pour http://www.blueacacia.com 
	*/ 
  public class MediaCharge extends EventDispatcher{ 
        
        private var _chargeur:Loader 
        private var _taux:Number            = 0; 
        private var _ko:Number              = 0; 
        private var _ko_total:Number        = 0; 
        private var _media:String; 
       
         
        public function MediaCharge(media:String):void 
      { 
			_chargeur   = new Loader(); 
			_media      = media; 
			_chargeur.load(new URLRequest(_media)); 
          
			_chargeur.contentLoaderInfo.addEventListener(Event.COMPLETE, $complete); 
			_chargeur.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, $progression); 
			_chargeur.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, $erreur); 
       } 
        
        private function $complete(e:Event):void 
        { 
           this.dispatchEvent(new Event(Event.COMPLETE)); 
		} 
        
        private function $progression(e:ProgressEvent):void 
		{ 
			_taux       = Math.ceil(e.bytesLoaded / e.bytesTotal * 100); 
			_ko         = Math.ceil(e.bytesLoaded / 1024); 
			_ko_total   = Math.ceil(e.bytesTotal / 1024); 
           this.dispatchEvent(new Event(Event.CHANGE)); 
        } 
        
        private function $erreur(e:IOErrorEvent):void 
		{ 
           trace("ERREUR DE CHARGEMENT SUR LE FICHIER : " + _media); 
           //trace(e.errorID); 
		} 
        
        //GETTER 
         
        //Renvoi l'objet Loader a instancié sur la scène 
        public function get getMedia():Loader 
		{ 
           return _chargeur; 
		} 
        
        //Renvoi Le taux de chargement en % 
     public function get getTaux():String 
        { 
           return _taux.toString(); 
        } 
        
        //Renvoi le taux de chargement en % formater 001 
        public function get getTauxFormat():String 
		{ 
			var taux_format:String = _taux.toString(); 
			if (_taux == 0) 
			{ 
				taux_format = "000"; 
            } 
			if (_taux < 10) 
			{ 
				taux_format = "00" + _taux; 
				return taux_format; 
			} 
			if (_taux < 100) 
			{ 
				taux_format = "0" + _taux; 
				return taux_format; 
			} 
			return taux_format; 
		} 
        
        //Renvoi le taux de chargement en Ko 
        public function get getKo():String 
      { 
           return _ko.toString() 
       } 
        
         
        //Renvoi le poid total de l'élément en Ko 
       public function get getKoTotal():String 
     { 
           if (_ko_total == 0) 
         { 
               return ""; 
          } 
           return _ko_total.toString(); 
        } 
        
    } 