package fr.artkabis.utils
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	* La classe Pause est prévu pour déclanché pause un temps donné tout en proposant une palette de paramètres non-proposé par la classe Timer de base .
	*
	*	@author			NICOLLE-Gregory - Artkabis
	*	@version		1.0
	*	@date			28.03.2010
	*	@langversion 		ActionScript 3.0
	* 	@playerversion 		Flash 10
	*	@tiptext
	*
	*	@example Dans cet exemple, la classe Pause est utilisé pour créer une pause de 2 seconde, avec activation du mode seconde et une seule repetiton:
	*
	* <listing version="1.0">
	*	import fr.artkabis.utils.Pause;
	*	
	*	var p:Pause=new Pause(this,2,true,1);
	*	//p.duree = 2;
	*	//p.activSec=true
	*	//p.repetition=1
	* 	this.addChild(p);
	*
	* </listing>
	**/
	
	public class Pause  extends Sprite
	{
		private var _duree              :Number;
		private var _timer              :Timer;
		private var _repet              :int;
		private var _activSec           :Boolean;
		private var _targ               :*;
		private var _func               :*;
		
		/**
		*	Duree total de la pause (en millisecondes ou secondes)
		*	@return Number
		**/
		public function get duree():Number{ return _duree; }
		/**
		*	@private
		**/
		public function set duree(pDuree:Number){ _duree = pDuree; }
		
		
		
		/**
		*	Représente l'activation du mode seconde
		*	@return Boolean
		**/
		public function get activSec():Boolean{ return _activSec; }
		/**
		*	@private
		**/
		public function set activSec(pActivSec:Boolean){ _activSec = pActivSec; }
		
		
		
		/**
		*	Représente le nombre de repetition liée à la pause
		*	@return Boolean
		**/
		public function get repetition():Number{ return _repet; }
		/**
		*	@private
		**/
		public function set repetition(pRepet:Number){ _repet = pRepet; }
		
		
		/**
		*	Création d'une occurrence Pause
		*
		*	@param $target		Element prenant en compte la pause
		*	@param $duree		Duree de pause avant reprise de la lecture de la timeLine
		*	@param $activSec	(optionel activé par defaut) Activation du mode seconde 
		*	@param $repetiton	Nombre de repetiton de la pause
		**/
		public function Pause ($target:*, $duree:Number = 1 , $activSec:Boolean=true , $repetition:int=1 , $func:* = null)
		{
			_repet = $repetition;
			_activSec = $activSec;
			_targ = $target;
			_targ.stop();
			_func = $func;
			
			if(_activSec){_duree = Number($duree * 1000);}else {_duree = $duree;}
			_timer = new Timer( _duree , _repet);
			_timer.start();
			if(_func==null){_timer.addEventListener(TimerEvent.TIMER_COMPLETE,__restart);}else{_timer.addEventListener(TimerEvent.TIMER_COMPLETE,_func)}
			tracer();
		}
		
		/**
		*	@private
		**/
		private function __restart (te:TimerEvent):void
		{
			_targ.play();
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, __restart);	
		}
		
		
		/**
		*	Méthode utilisé pour répéter la pause
		**/
		public function replay():void{
			_targ.stop();
			_timer = new Timer( _duree , _repet);
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE,function(){_targ.play();});
			tracer();
		}
		
		/**
		*	Méthode utilisé pour renvoyer les données lié aux paramètres
		**/
		public function tracer():void{
			var msg:String;
			if( _activSec ) msg='Duree:: ' + (_duree * _repet) /1000 + 'sec';
			else msg='Duree:: ' + (_duree * _repet) + 'ms';
			trace(msg);
		}
		
		/**
		*	Méthode utilisé pour lancer le déroulement de la pause
		**/
		public function start():void{
			_timer.start();
		}
		
		/**
		*	Méthode utilisé pour stopper la pause
		**/
		public function stop():void{
			_timer.stop();
		}
		
		/**
		*	Méthode utilisé pour supprimer la pause
		**/
		public function reset():void{
			_timer.reset();
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,__restart);
		}
	}
}