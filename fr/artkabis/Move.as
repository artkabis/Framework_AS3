package fr.artkabis
{
		/*****************************************************************************************************  
	* move (AS3), version 1.5                                                                            * 
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
	* @class    :   move                                                                                 *
	* @author   :   Greg.N :: Artkabis                                                                   *
	* @version  :   1.5 - class move (AS3)                                                               *
	* @since    :   02-06-2009 14:28                                                                     *
	*                                                                                                    *
	*****************************************************************************************************/

	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.display.Stage;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Sine;
	import com.greensock.easing.Strong;


	public class Move extends MovieClip
	{
		/*
		*public vars
		**/
		public var objet                                  :DisplayObject;
		public var X                                      :Number;
		public var Y                                      :Number;
		public var centre                                 :Boolean;
		public var tween                                  :Boolean;
		public var duree                                  :Number;
		private var param                                  :Object;
		private var sceneH                                :Number;
		private var sceneL                                :Number;
		private var ease                                  :uint;
		/*
		*private vars
		**/
		private var centreY                               :Number;
		private var centreX                               :Number;
		private var tweenType                             :Object;
		private var objL                                  :Number;
		private var objH                                  :Number;
		
		 /*****	//_________________________________________________________________○○○--Constructor
		 * Gestion du Mouvement avec possibilité d'activer le mode Tween
		 * @param	objet    :: Le movieClip utilisant les fonctionnalités de la classe
		 * @param   X        :: axe cible de l'objet en x
		 * @param   Y        :: axe cible de l'objet en y
		 * @param   centre   :: activation du placement central à la scène
		 * @param   sceneH   :: si centre est activé, alors sceneH devra être definit (peut être la Hauteur de la scène où d'un clip conteneur
		 * @param   sceneL   :: si centre est activé, alors sceneL devra être definit (peut être la Largeur de la scène où d'un clip conteneur
		 * @param	duree    :: durre en seconde de la transition
		 * @param   tween    :: activation du mode tween (activera la classe TweenMax et le easing
		 * @param   ease     :: si tween et activé, il est possible de préciser 7 type de easing, Strong étant celui par defaut. (Legende>>> 1:Back, 2:Bounce,3:Cubic, 4:Elastic, 5:Linear, 6:Sine). 
		 *****/
		public function Move ( param:Object )
		{
								//ajout des paramètres dans l'objet param
								objet       =  param.objet;
								X           =  param.X;
								Y           =  param.Y;
								centre      =  param.centre;
								sceneH      =  param.sceneH;
								sceneL      =  param.sceneL
								duree       =  param.duree;
								tween       =  param.tween;
								ease        =  param.ease;
								
								//switch pour initialisation des easing
								switch(ease)
								{
									case 1:
									tweenType = Back.easeOut;
									break;
									case 2:
									tweenType = Bounce.easeOut;
									break;
									case 3:
									tweenType = Cubic.easeOut;
									break;
									case 4:
									tweenType = Elastic.easeOut;
									break;
									case 5:
									tweenType = Linear.easeOut;
									break;
									case 6:
									tweenType = Sine.easeOut;
									break;
									default:
									tweenType = Strong.easeOut;
								}
								//Valeur par defaut
								objL   =  objet.width;
								objH   =  objet.height;
								centreX = (sceneL-objL)/2;
								centreY = (sceneH-objH)/2;
								
			if (objet == null ) throw new Error("Erreur : Object null");
			addEventListener("enterFrame",$analyse);
		}
		/**
		* @param $analyse     ::analyse des paramètres pour gestion des déplacements
		*/
		private function $analyse( e:Event ):void
		{
			//informations des paramètres
			trace(
				  	  "  ___________________________________Class move v1.5____________________________________\n" +
				  	  "  objet.name:" + objet.name +
					  ", objet.width:" + objL + 
					  ", objet.height:" + objH + 
					  ", Y:" + Y + 
					  ", X:" + X +
					  ", sceneH:" + sceneH +
					  ", sceneL:" + sceneL +
					  ", duree:" + duree +
					  ", centreY:" +centreY + 
					  ", centreX:" + centreX + 
					  ", tween:" + tween + 
					  ", ease:" + ease + 
					  ", centre:" + centre +
					  "\n::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::\n"
				 );
			//analyses
			if(tween && !centre) $doTween(); 
			if(centre && tween) $doTweenCentre();
			if(centre && !tween) $doCentre();
			if(!centre && !tween) $doDeplace();
			
		}
		/**
		* @param $doTween     ::deplacement simple avec tween
		*/
		private function $doTween(  )
		{
			trace ("TweenSimple");
			if (isNaN(duree))trace("definissez: duree: (temps transition)(1's par defaut)");duree = 1;
			(isNaN(Y) ||isNaN(X)) ? trace("Definissez:  X:(cible en x) et Y:(cible en Y)") : TweenMax.to(objet, duree,{x:X,y:Y,ease:tweenType,onComplete:suppEF})
			suppEF(  );
		}
		/**
		* @param $doTweenCentre     ::deplacement centrale avec tween
		*/
		private function $doTweenCentre(  ):void
		{
			trace ("TweenCentre");
			if(isNaN(duree))duree = 1;
			(isNaN(sceneH) || isNaN(sceneL )) ? trace("Definissez:  sceneL:(largeurScene) et sceneH:(hauteurScene)") : TweenMax.to(objet, duree,{x:centreX,y:centreY,ease:tweenType})
			suppEF(  );
		}
		/**
		* @param $doCentre     ::deplacement centrale simple
		*/
		private function $doCentre(  ):void
		{
			trace ("Centre");
			(isNaN(sceneH) || isNaN(sceneL)) ? trace("Definissez:  sceneL:(largeurScene) et sceneH:(hauteurScene)") : objet.x = centreX; objet.y = centreY;
			suppEF(  )
		}
		/**
		* @param $doDeplace     ::deplacement simple
		*/
		private function $doDeplace():void
		{
			trace ("Deplace");
			(isNaN(Y) || isNaN(X)) ? trace("Definissez:  X:(cible en x) et Y:(cible en y)") : objet.x =X; objet.y = Y;
			suppEF(  );
		}
		/**
		* @param $suppEF     ::suppression enterFrame
		*/
		private function suppEF(  ):void
		{
			removeEventListener("enterFrame",$analyse);
		}
	}
}