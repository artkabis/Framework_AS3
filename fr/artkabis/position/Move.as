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

package fr.artkabis.position
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import gs.TweenLite;
	import gs.easing.Back;
	
	public class Move extends MovieClip
	{	
	//________________________________________________________________________________○○○--Vars
	public var objet                                   : MovieClip;
	public var duree                                   : uint;
	public var X                                       : int;
	public var Y                                       : int;
	public var dragg                                   : Boolean;
	private var props                                  : Object;
	public var iniPosX                                 : Number;
	public var iniPosY                                 : Number;
		 /*****	//_________________________________________________________________○○○--Constructor
		 * Gestion du Mouvement dynamique avec fragg
		 * @param	pObjet    :: Le movieClip utilisant les fonctionnalités de la classe
		 * @param	pDurre    :: durre en seconde des différentes transitions
		 * @param   pX        :: axe cible de l'objet en x
		 * @param   pY        :: axe cible de l'objet en y
		 * @param   dragg     :: activation du drag
		 *****/
		public function Move (pObjet:MovieClip, pDuree:uint, pX:uint, pY:uint, dragg:Boolean = false):void
		{
			Y = pX;
			X = pY;
			objet = pObjet;
			duree = pDuree;
			objet.buttonMode = true;
			props = new Object()
								   props.x = X,
								   props.y = Y,
								   props.ease = Back.easeOut,
								   props.onComplete = replace,
								   props.onCompleteParams = [objet]
				
			
			if ( !dragg )setTimeout(placer,10);
			if (objet == null ) throw new Error("Error : Object is null");
			if (objet == !null || dragg){
				objet.addEventListener(MouseEvent.MOUSE_DOWN,                       $moveAction);
				objet.addEventListener(MouseEvent.MOUSE_UP,                         $moveAction);
			}
		}
	
	//____________________________________________________________________________○○○--Placement dynamique
		private function placer():void
		{
			TweenLite.to(objet,duree,{x:X, y:Y, ease:Back.easeOut });
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
					TweenLite.to(objet,duree,props);
				break;
			}
		}
	//____________________________________________________________________________○○○--Replacement
		private function replace(objet:MovieClip):void
		{
			TweenLite.to(objet,duree,{x:iniPosX, y:iniPosY,onComplete:reactive, onCompleteParams:[objet]});
		}
		private function reactive(object:MovieClip):void
		{
			objet.mouseEnabled = true;
		}
	}
}