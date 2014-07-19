/*
//====================================================================================================================================
//================================================ Utilisation =======================================================================
//====================================================================================================================================*/
//import fr.artkabis.utils.Protege
//
//var $message:String = 'message annonçant la mise en place de la protection, si null message = "Licence non valide, autorisation expiré..."';
//var $couleur:String = '#FFFFFF';//choisissez une couleur pour le texte du  message
//var $jour:int=10;//jour pour le debut de la protection
//var $mois:int=9;// mois pour le ...
//var $annee:int=2009;//jour pour le ...
//
//var protection:Protege = new Protege( { message:$message,couleur:$couleur,jour:$jour,mois:$mois,annee:$annee } );//création de la protection
//this.addChild( protection );//mise en place de la protection
//
//====================================================================================================================================

package fr.artkabis.utils 
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import fr.artkabis.text.DrawText;

 	public class Protege extends MovieClip
	{
		//=======================EMBEDING=======================
		[Embed(source="../../../assets/protect.swf", symbol="Bouclier")]
		private var Bouclier:Class;
	 
		[Embed(source="../../../assets/protect.swf", symbol="Croix")]
		private var Croix:Class;
		//===================================================================================================
		
		//======================INSTANCIATION======================
		/**
		* Instance de l'élément bouclier
		**/
		private var bouclier         :Sprite;
		
		/**
		* Instance de l'élément croix
		**/
		private var croix            :Sprite;
		
		/**
		* Instance du paramètre annee
		**/
		private var _annee           :int;
		
		/**
		* Instance du paramètre jour
		**/
		private var _jour            :int;
		
		/**
		* Instance du paramètre mois
		**/
		private var _mois            :int;
		
		/**
		* Instance du paramètre lié au contenu du message affiché en cas de non validité
		**/
		private var _message         :String;
		
		/**
		* Instance du paramètre lié à la couleur du texte
		**/		
		private var _couleur         :String;
		
		/**
		* Instance du paramètre lié à la taille du texte
		**/
		private var _taille          :Number;
		
		/**
		* Instance du paramètre lié à la position x du texte
		**/
		private var _txtX            :Number;

		/**
		* Instance du paramètre lié à la position y du texte
		**/
		private var _txtY            :Number;
		
		/**
		* Instance du paramètre lié à la mise en gras du texte
		**/
		private var _gras            :Boolean;
		
		/**
		* Instance du paramètre lié à la police du texte
		**/
		private var _font            :String;
		
		/**
		* Instance du paramètre lié à l'affichage de l'icone bouclier
		**/
		private var _icProtect       :Boolean;
		
		/**
		* Instance du paramètre lié à l'affichage de l'icone croix
		**/
		private var _icCroix       :Boolean;

		/**
		* Instance du paramètre lié taille de la scene
		**/
		private var _tailleStage     :Array;
		//===================================================================================================
		
		/**
		* @private
		**/
		private var _txtInfo         :DrawText;
		/**
		* @private
		**/
		private var _valide          :Boolean;
		
		/**
		* @private
		**/
		private var _date            :Date;
		/**
		* @private
		**/
		private var params            :Object;
		//===================================================================================================
		
		
		/**
		* Getter setter
		**/
		public function get couleur():String{return _couleur;}
		public function set couleur($c:String){_couleur = $c;}
		
		public function get jour():int{return _jour;}
		public function set jour($j:int){_jour = $j;}

		public function get mois():int{return _mois;}
		public function set mois($m:int){_mois = $m;}

		public function get annee():int{return _annee;}
		public function set annee($a:int){_annee = $a;}
		
		public function get message():String{return _message;}
		public function set message($m:String){_message = $m;}

		public function get taille():Number{return _taille;}
		public function set taille($t:Number){_taille = $t;}

		public function get txtX():Number{return _txtX;}
		public function set txtX($t:Number){_txtX = $t;}

		public function get txtY():Number{return _txtY;}
		public function set txtY($t:Number){_txtY = $t;}

		public function get gras():Boolean{return _gras;}
		public function set gras($g:Boolean){_gras = $g;}
		
		public function get font():String{return _font;}
		public function set font($f:String){_font = $f;}

		public function get tailleStage():Array{return _tailleStage;}
		public function set tailleStage($t:Array){_tailleStage = $t;}

		public function get icProtect():Boolean{return _icProtect;}
		public function set icProtect($i:Boolean){_icProtect = $i;}
		
		public function get icCroix():Boolean{return _icCroix;}
		public function set icCroix($i:Boolean){_icCroix = $i;}
		
		public function get autorise():Boolean{return _valide;}
		public function set autorise($v:Boolean){_valide = $v;}
		//===================================================================================================
		
		/**
		* Instance de l'objet Protect
		**/
		public function Protege(params:Object)
		{		
			
			//Récupération des paramètre du projet
			_message      =  params.message
			_couleur      =  params.couleur;
			_jour         =  params.jour;
			_mois         =  params.mois;
			_annee        =  params.annee;
			_taille       =  params.taille;
			_txtX         =  params.txtX;
			_txtY         =  params.txtY;
			_gras         =  params.gras;
			_font         =  params.font;
			_tailleStage  =  params.tailleStage;
			_icProtect    =  params.icProtect;
			_icCroix      =  params.icCroix;
			
			
			_valide       =  true;
			_date         =  new Date();
			(_message === null) ? 'Licence non valide, autorisation expiré...' : _message;
			(_couleur === null) ? '#000000' : _couleur;
			(_taille === 0) ? 12 : _taille;
			(_font === null) ? 'Vibrocentric' : _font
			
			if( _annee < _date.getFullYear() )_valide = false;
			if( _mois  < _date.getMonth()+1 ) _valide = false;
			if(_jour  < _date.getDate() && _mois == _date.getMonth()+1 )_valide=false;
			if(_icProtect && !_valide){placeIcone();gestionInfo();}
		}
		/**
		* @private
		**/
		private function placeIcone():void
		{
			bouclier = new Bouclier();
			bouclier.name = 'bouclier';
			bouclier.cacheAsBitmap = true;
			bouclier.x = (_tailleStage[0]-(bouclier.width/2));
			bouclier.y = (_tailleStage[1]-(bouclier.height/2));
			addChild(bouclier);
			
			if(_icCroix){
				croix = new Croix();
				croix.name = 'croix';
				croix.cacheAsBitmap = true;
				croix.x = bouclier.x;
				croix.y = bouclier.y;
				addChild(croix);
			}
		}
		private function gestionInfo():void{
			if(!_valide){
				_txtInfo = new DrawText({text:_message, font:_font,color:_couleur,gras:_gras,size:_taille});
				addChild(_txtInfo) ;
				_txtInfo.x=_txtX
				_txtInfo.y=_txtY;
			}
		}
	}
}