package fr.placement
{

	import flash.events.Event;
	import flash.display.*;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;

	public class PosObjet 
	{
		protected var _param             :Object;
		protected var _target            :DisplayObject;
		protected var _stage             :Stage;
		protected var _duree             :Number;

		//setter pour les paramètres d'alignements
		public function set param(value:Object):void 
		{
			_param = value;
			reposition();
		}
		//Constructeur
		public function PosObjet($target:DisplayObject , $paramObj:Object) 
		{
			//attribution des paramètres
			_target = $target;
			_param  = $paramObj;
			_stage  = $target.stage;

			//Ecoute de l'évenement rezise sur la scène.
			_stage.addEventListener(Event.RESIZE,$redimScene);
			
			//repositionnement des objets via la fonction reposition
			reposition();
		}

		//foncvtion de repositionement
		protected function reposition():void 
		{
			//recupération de la largeur et de la hauteur de la scène
			var stageW = _stage.stageWidth;
			var stageH = _stage.stageHeight;
			
			//Declaration des nouvelles valeur en x et en y
			var newX = _target.x;
			var newY = _target.y;
			
			//Declaration des nouvelles valeur pour la taille des éléments
			var newW = _target.width;
			var newH = _target.height;
			

			//Calcul de la nouvelle position x en fonctioon de la largeur de la scène
			if (_param.x != undefined) newX = (stageW * _param.x) + _param.offsetX;
			//Calcul de la nouvelle position y en fonctioon de la hauteur de la scène
			if (_param.y != undefined) newY = (stageH * _param.y) + _param.offsetY;
			//Calcul de la nouvelle largeur en fonctioon de la largeur de la scène
			if (_param.width != undefined) newW = stageW ;
			//Calcul de la nouvelle hauteur en fonctioon de la taille de l'objet
			if (_param.height != undefined)newH = _target.height;
			if (_param.duree != undefined) _duree = _param.duree; else _duree = .5;
			
			
			//application des transitions sur le où les objets  avec les les paramètre précédemment créés
			new Tween( _target,"x",Strong.easeOut,_target.x,newX,_duree,true );
			new Tween( _target,"y",Strong.easeOut,_target.y,newY,_duree,true );
			new Tween( _target,"width",Strong.easeOut,_target.width,newW,_duree,true );
			new Tween( _target,"height",Strong.easeOut,_target.height,newH,_duree,true );
		}
		//Repositionnement des éléments si modification de la scène il y a.
		protected function $redimScene(e:Event):void 
		{
			reposition();
		}
	}
}