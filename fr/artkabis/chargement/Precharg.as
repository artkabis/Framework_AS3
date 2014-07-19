package fr.artkabis.chargement
{
	/*****************************************************************************************************  
	* Precharg (AS3), version 1.8                                                                            * 
	*                                                                                                    *
	*                                                                                                    *
	*                                                                                                    *
	* <pre>                                                                                              *
	*  ____              _         _      ____                                                           *
	* |  __| _____  ____| |_      | | __ |__  |                                                          *
	* | |   |  _  ||  _||  _| __  | |/ /    | |                                                          *
	* | |   | |_| || |  | |  |__| |   <     | |                                                          *
	* | |__ |_| |_||_|  |_|       |_|\_\  __| |                                                          *
	* |____|                             |____|                                                          *
	*                                                                                                    *
	* </pre>                                                                                             *
	*                                                                                                    *
	* @class    :   Precharg                                                                             *
	* @author   :   Greg.N :: Artkabis                                                                   *
	* @version  :   1.8 - class Precharg (AS3)                                                           *
	* @since    :   10-06-2009 20:22                                                                     *
	*                                                                                                    *
	*****************************************************************************************************/

	//import package display
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.display.DisplayObject;
	
	//import package events
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	//import autres
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.AntiAliasType
	
	import flash.filters.GlowFilter;
	import flash.filters.DropShadowFilter;
	import flash.net.URLRequest;
		
	//la classe Principale
	public class Precharg extends MovieClip
	{
		//variable permettant de modifier l'ensemble des couleur du projet (barre, filtre, texte)
		private var   _couleur                               :uint;
		private var   _cGlow                                 :uint;
		private var   _cOmbre                                :uint;
		private var   _chemin                                :String;
		private var   _glow                                  :GlowFilter;
		private var   _ombre                                 :DropShadowFilter;
		private var   _target                                :DisplayObject;
		private var   _barreCharge                           :MovieClip;
		private var   _infos                                 :TextField;
		private var   _barre                                 :Shape;
		private var   _loader                                :Loader;
		private var   _req                                   :URLRequest;
		private var   _centreY                               :int;
		private var   _stageW                                :int;
		private var   _stageH                                :int;
		private var   _pct                                   :int;
		public  var   _activ                                 :Boolean; 
		
		public function Precharg ($chemin:String , $couleur:uint,$cGlow:uint , $cOmbre:uint , $target:DisplayObject):void
		{
			//initialisation
			_chemin                            = $chemin;
			_couleur                           = $couleur;
			_cOmbre                            = $cOmbre;
			_cGlow                             = $cGlow;
			_stageW                            = $target.width;
			_stageH                            = $target.height;
			_barreCharge                       = new MovieClip();
			_infos                             = new TextField();
			_barre                             = new Shape ();
			_loader                            = new Loader ();
			_glow                              = new GlowFilter( _cGlow,1,7,4,1,3,true,false);
			_ombre                             = new DropShadowFilter(0,45,_cOmbre,1,5,4,2,3,false,false,false)
			_req                               = new URLRequest( _chemin );
			
			_infos.textColor = _couleur;
			_infos.width = 28;
			_infos.filters = [_glow , _ombre];
			_centreY = _stageH/2;
			
			_barre.graphics.beginFill ( _couleur );
			_barre.graphics.drawRect( 0, 0, 1, 4);
			_barreCharge.y = _centreY;
			_barreCharge.filters = [ _glow , _ombre];
			
			this.addChild( _barreCharge );
			this.addChild( _infos );
			this._barreCharge.addChild( _barre );
			
			//chargement et ecoute de l'objet loader
			_loader.load( _req );
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, $progression);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, $chargeComplete);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, $erreur);
			trace('_chemin::'+_chemin+', _couleur::'+ _couleur+', _stageW::'+ _stageW+', _stageH::'+ _stageH);
		}
		//fonction gérant la progression (largeur de la barre et texte contenant le pourcentage).
		public function $progression ( e:ProgressEvent ):int
		{
			_pct = Math.round( e.bytesLoaded / e.bytesTotal * 100 );
			_infos.text = _pct + "%";
			_infos.y = _centreY-5;
			_infos.x = _barreCharge.x + _barreCharge.width + 5;
			_barreCharge.width = _stageW /100 * _pct;
			return int(_pct);
		}
		//fonction joué une fois le chargement complété
		private function $chargeComplete ( e:Event )
		{
			//supression des écouteurs
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, $progression);
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, $chargeComplete);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, $erreur);
			
			//suppresssion des éléments graphiqueqs
			this.removeChild( _infos );
			this.removeChild( _barreCharge );
			_infos = null;
			_barreCharge = null;
			//affichage du loader
			this.addChild( _loader );
			_activ = true;
			return (_activ);
		}
		//fonction gérant les erreurs de chargement  liés au fichier chargé
		private function $erreur ( e:Event ):void
		{
			trace("Erreur de chargement ...");
			//suppression des écouteurs du loader
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, $progression);
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, $chargeComplete);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, $erreur);

			this.removeChild( _barreCharge );
			_barreCharge = null;
			
			//paramètrage du texte et mise en place du message d'erreur
			with (_infos)
			{
				selectable      = false;
				text            = "Erreur de chargement ...";
				autoSize        = TextFieldAutoSize.LEFT;
           		antiAliasType   = AntiAliasType.ADVANCED;
				y               = _centreY;
				x               = (_stageW - _infos.width) /2;
			}
		}
	}//fin classe
}//fin package