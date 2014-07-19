/*
AUTEUR : 			BROQUERE Brice
VERSION :			1.0
DATE DE CRÉATION :	06/07/2009
MAJ :				13/07/2009

La classe ULOADER est un chargeur universel, elle permet le chargement de données ou de contenu.
Elle gére les événements flash.events.IOErrorEvent.IO_ERROR, flash.events.ProgressEvent.PROGRESS et flash.events.Event.COMPLETE,
et lance un événement flash.events.Event.INIT lorsque sa propriété bytesTotal est disponible.
*/


package fr.artkabis.chargement
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	
	public final class ULoader extends Sprite
	{
		/* PROPRIÉTÉS
		****************************************************************************************************/
		
		// <lecture> - Nombre d'octets chargés
		private var _bytesLoaded:uint;
		
		// <lecture> - Nombre d'octets totaux
		private var _bytesTotal:uint;
		
		// <lecture> - Contenu
		private var _content:*;
		
		// <lecture-écriture> - Format des données
		private var _dataFormat:String;
		
		// <lecture> - Type de chargeur
		private var _dataLoader:Boolean;		
		
		//................................................................................
		
		// Chargeur
		private var _loader:*;
		
		// Requête
		private var _request:URLRequest;
		
		
		/* CONSTANTES
		****************************************************************************************************/
		
		//  Format de données de type texte
		static public const DATA_FORMAT_TXT:String = "text";
		
		//  Format de données de type variables
		static public const DATA_FORMAT_VAR:String = "variables";
		
		//  Format de données de type XML
		static public const DATA_FORMAT_XML:String = "xml";
		
		
		/* CONSTRUCTEUR
		****************************************************************************************************/
		
		public function ULoader(url:String = null , dataLoader:Boolean = false)
		{
			_dataLoader = dataLoader;
			_request = new URLRequest(url);
			
			// Chargeur de données
			if (dataLoader)
			{
				_loader = new URLLoader();
				_dataFormat = DATA_FORMAT_TXT;
				_request.data = new URLVariables();
				_request.method = URLRequestMethod.POST;	
			}
			// Chargeur de contenu
			else _loader = new Loader();			
		}
		
		
		/* MÉTHODES
		****************************************************************************************************/
		
		/*
		 * FONCTION :		addData
		 * DESCRIPTION :	Ajouter une ou plusieurs données à transmettre
		 * ARGUMENTS :		args : 	Liste de taille indifférente de paires variable / valeur
		 * 							Si la liste est de taille impaire la dernière variable n'est pas transmise
		*/
		public function addData(... args):void
		{
			if (_dataLoader)
			{
				// Longueur paire
				args.length = 2 * Math.floor(args.length / 2);
				
				// Recensement des variables (index pairs)
				for (var i:int = 0 ; i < args.length ; i += 2)
				{
					if(args[i] is String) _request.data[args[i]] = args[i+1];					
				}
			}
		}
		
		
		/*
		 * FONCTION :		load
		 * DESCRIPTION :	Lancement du chargement
		 * ARGUMENTS :		url :	URL du fichier à charger
		*/
		public function load(url:String = null):void
		{
			if (url) _request.url = url;
			
			if (_request.url)
			{
				var t:* = _dataLoader ? _loader as URLLoader : (_loader as Loader).contentLoaderInfo;
				t.addEventListener(IOErrorEvent.IO_ERROR , _IOErrorHandler);		
				t.addEventListener(ProgressEvent.PROGRESS, _progressHandler);
				t.addEventListener(Event.COMPLETE, _completeHandler);
				if (t is URLLoader) t.load(_request);
				else (_loader as Loader).load(_request);
			}
			else throw new Error("La propriété url n'a pas été renseignée.");
		}
	
		
		/* HANDLERS
		****************************************************************************************************/
		
		// Erreur IO
		private function _IOErrorHandler(p_e:IOErrorEvent):void
		{
			p_e.target.removeEventListener(IOErrorEvent.IO_ERROR , _IOErrorHandler);			
			p_e.target.removeEventListener(ProgressEvent.PROGRESS , _progressHandler);
			p_e.target.removeEventListener(Event.COMPLETE, _completeHandler);
			this.dispatchEvent(p_e);
		}
		
		
		// Progression du chargement
		private function _progressHandler(p_e:ProgressEvent):void
		{
			if (!_bytesTotal)
			{
				_bytesTotal = p_e.target.bytesTotal;				
				this.dispatchEvent(new Event(Event.INIT));
			}
			
			if (_dataLoader) _bytesLoaded = (p_e.target as URLLoader).bytesLoaded;			
			else _bytesLoaded = (p_e.target as LoaderInfo).bytesLoaded;
			this.dispatchEvent(p_e);
		}
		
		
		// Fin du chargement
		private function _completeHandler(p_e:Event):void
		{		
			p_e.target.removeEventListener(IOErrorEvent.IO_ERROR , _IOErrorHandler);		
			p_e.target.removeEventListener(ProgressEvent.PROGRESS , _progressHandler);
			p_e.target.removeEventListener(Event.COMPLETE, _completeHandler);
			
			if (!_bytesTotal) 
			{
				_bytesTotal = p_e.target.bytesTotal;				
				this.dispatchEvent(new Event(Event.INIT));
			}
			
			if (_dataLoader)
			{
				var l:URLLoader = p_e.target as URLLoader;
				_bytesLoaded = l.bytesLoaded;
				_content = _dataFormat == DATA_FORMAT_XML ? XML(l.data) : l.data;
			}
			else
			{
				var i:LoaderInfo = p_e.target as LoaderInfo;
				_bytesLoaded = i.bytesLoaded;
				_content = i.content;
				this.addChild(_content);
			}
			
			this.dispatchEvent(p_e);
			_loader = null;
		}
		
		
		/* GETTERS / SETTERS
		****************************************************************************************************/
		
		// Octets chargés
		public function get bytesLoaded():uint { return _bytesLoaded; }
		
		
		// Octets totaux
		public function get bytesTotal():uint { return _bytesTotal; }
		
		
		// Contenu
		public function get content():* { return _content; }
		
		
		// Type de chargeur
		public function get dataLoader():Boolean { return _dataLoader; }
		
		
		// Format des données
		public function get dataFormat():String { return _dataFormat; }
		
		public function set dataFormat(value:String):void 
		{
			if (_dataLoader)
			{
				if (value == DATA_FORMAT_XML)
				{
					_dataFormat = value;
					(_loader as URLLoader).dataFormat = DATA_FORMAT_TXT;
				}
				else if (value == DATA_FORMAT_TXT || value == DATA_FORMAT_VAR) _dataFormat = (_loader as URLLoader).dataFormat = value;				
				else throw new ArgumentError("La valeur affectée à dataFormat n'est pas valide.");
			}
		}
		
		// URL
		public function get url():String { return _request.url; }
		
		public function set url(value:String):void { _request.url = value; }
	}	
}