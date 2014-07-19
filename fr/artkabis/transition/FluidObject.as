package fr.placement{

	import flash.events.Event;
	import flash.display.*;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;

	public class FluidObject 
	{
		protected var _param              :Object;
		protected var _target             :DisplayObject;
		protected var _stage              :Stage;
		protected var _time               :Number;
		
		public function set param($value:Object):void 
		{
			_param = $value;
			this.reposition();
		}
		/*****
		*
		*Constructeur
		*
		******/
		public function FluidObject($target:DisplayObject,$paramObj:Object,$time:Number) 
		{
			/* assignation des variables */
			_target      =  $target;
			_param       =  $paramObj;
			_stage       =  $target.stage;
			_time        =  $time;
			

			/* écoute du resize de la scène */
			_stage.addEventListener(Event.RESIZE,onStageResize);

			/* mise en place du repositionnement*/
			this.reposition();
		}
		/* fonction de repositionnement */
		protected function reposition():void 
		{
			var stageW   =  _stage.stageWidth;// récupération des dimensions de la largeur de la scène 
			var stageH   =  _stage.stageHeight;// récupération des dimensions de la hauteur de la scène 
			var duree    =  _time;// duree de la transition 
			var newX     =  _target.x;//nouvelle valeur sur x
			var newY     =  _target.y;//nouvelle valeur sur y
			
			/* calcule de la valeur de x en fonction de la largeur de la scène*/
			if (_param.x!=undefined) newX = (stageW * _param.x) + _param.offsetX;
			/* calcule de la valeur de y en fonction de la hauteur de la scène*/
			if (_param.y!=undefined) newY = (stageH * _param.y) + _param.offsetY;

			/* deplacement des élement en fonction des nouveaux axes */
			new Tween(_target,"x",Strong.easeOut,_target.x,newX,duree,true);
			new Tween(_target,"y",Strong.easeOut,_target.y,newY,duree,true);
		}
		protected function onStageResize(e):void 
		{
			/* repositionnement */
			this.reposition();
		}
	}
}