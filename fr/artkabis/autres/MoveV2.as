/*****************************************************************************************************  
* Move (AS3), version 1.0                                                                            * 
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
* @class    :   Move                                                                                 *
* @author   :   Greg.N :: Artkabis                                                                   *
* @version  :   1.0 - class Move (AS3)                                                               *
* @since    :   30-05-2009 08:42                                                                     *
*                                                                                                    *
*****************************************************************************************************/

package fr.artkabis
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import gs.TweenLite;
	import gs.easing.Back;
	import gs.easing.Bounce;
	import gs.easing.Quart;
	import gs.easing.Elastic;
	import gs.easing.Linear;
	
	
	public class MoveV2 extends MovieClip
	{	
	//________________________________________________________________________________○○○--Vars
	public var objet                                   : MovieClip;
	public var duree                                   : Number;
	public var X                                       : int;
	public var Y                                       : int;
	public var dragg                                   : Boolean;
	private var props                                  : Object;
	public var iniPosX                                 : Number;
	public var iniPosY                                 : Number;
	public var mouvement                               : Object;
	public var nbMouv                                  : int;
		 /*****	//_________________________________________________________________○○○--Constructor
		 * Gestion du Mouvement dynamique avec fragg
		 * @props	pObjet    :: Le movieClip utilisant les fonctionnalités de la classe
		 * @props	pDurre    :: durre en seconde des différentes transitions
		 * @props   pX        :: axe cible de l'objet en x
		 * @props   pY        :: axe cible de l'objet en y
		 * @props   dragg     :: activation du drag
		 *****/
		public function MoveV2 (props:Object):void
		{
			objet                         =  props.objet;
			duree                         =  props.duree;
			X                             =  props.X;
			Y                             =  props.Y;
			dragg                         =  props.dragg;
			mouvement                     =  props.mouvement;
			nbMouv                        =  props.nbMouv;
			
			
			switch (nbMouv)
			{
				case 1:
				mouvement = Back.easeOut;
				break;
				case 2:
				mouvement = Bounce.easeOut;
				break;
				case 3:
				mouvement = Quart.easeOut;
				break;
				case 4:
				mouvement = Linear.easeOut
				break;
				case 5:
				mouvement = Elastic.easeOut
				break;
			}
			objet.buttonMode = true;
			if ( !dragg )setTimeout(placer,10);
			if (objet == null ) throw new Error("Error : Object is null");
			if (objet != null || dragg){
				objet.addEventListener(MouseEvent.MOUSE_DOWN,                       $moveAction);
				objet.addEventListener(MouseEvent.MOUSE_UP,                         $moveAction);
			}
		}
	
	//____________________________________________________________________________○○○--Placement dynamique
		private function placer():void
		{
			TweenLite.to(objet,duree,{x:X, y:Y, ease:mouvement });
		}
		
	//____________________________________________________________________________○○○--MoveClip
		private function $moveAction(obj:MouseEvent):void
		{

			iniPosY = mouseY;
			iniPosX = mouseX;
			
			obj.updateAfterEvent();
			switch(obj.type)
			{
				case MouseEvent.MOUSE_DOWN:
					objet.startDrag(true);
				break;
				case MouseEvent.MOUSE_UP:
					objet.stopDrag();
					objet.mouseEnabled = false;
					TweenLite.to(objet,duree,{ x:X, y:Y, ease:mouvement, onComplete:replace, onCompleteParams:[objet]});
				break;
			}
		}
	//____________________________________________________________________________○○○--Replacement
		private function replace(objet:MovieClip):void
		{
			TweenLite.to(objet,duree,{x:iniPosX, y:iniPosY,ease:mouvement, onComplete:reactive, onCompleteParams:[objet]});
		}
		private function reactive(object:MovieClip):void
		{
			objet.mouseEnabled = true;
		}
	}
}