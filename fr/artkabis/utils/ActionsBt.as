	/**
	* <p>
	*  <pre>
	*
	*	//******************************************************************************************************  
	*	//*                                                                                                    *
	*	//*  ____              _         _      ____                                                           *
	*	//* |  __| _____  ____| |_      | | __ |__  |                                                          *
	*	//* | |   |  _  ||  _||  _| __  | |/ /    | |                                                          *
	*	//* | |   | |_| || |  | |  |__| |   <     | |                                                          *
	*	//* | |__ |_| |_||_|  |_|       |_|\_\  __| |                                                          *
	*	//* |____|                             |____|                                                          *
	*	//*                                                                                                    *
	*	//*                                                                                                    *
	*	//******************************************************************************************************
	*
	*</pre> 
	* </p>
	**/


package fr.artkabis.utils
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	*
	* La classe Pause est prévu pour déclanché pause un temps donné tout en proposant une palette de paramètres non-proposé par la classe Timer de base .
	* Il est possible de convertir une valeur decimale en hexadecimale,  une valeur decimale en RGB, une valeur hexadecimale en decimale, une valeur hexadecimal en RGB (red green blue), une valeur RGB en décimale et une valeur RGB en hexadecimale.
	*
	*	@author			NICOLLE-Gregory - Artkabis
	*	@version		1.0
	*	@date			30.05.2009
	*	@since 			January 12, 2009
	*	@langversion 	ActionScript 3.0
	* 	@playerversion 	Flash 10
	*
	*	@tiptext
	*
	*	@example Dans cet exemple, la classe Pause est utilisé pour créer une pause de 2 seconde, avec activation du mode seconde et une seule repetiton:
	*
	* <listing version="1.0">
	*	import fr.artkabis.utils.ActionBt;
	*	
	*	var params:Object={mc:monClip, mcChilds:false};
	*	var a:ActionBt=new ActionBt(params);
	* 	this.addChild(a);
	*
	* </listing>
	**/
	public class ActionsBt extends MovieClip 
	{
	//________________________________________________________________________________○○○--Vars
		private var mc                     :*;
		private var totalF                 :int;
		private var typeAction             :String;
		private var activArray             :Boolean;
		private var mChilds                :Boolean;
		
		 /**
		 * Gestion du rollOver dynamique
		 * @param	mc			Le movieClip utilisant les rollOver
		 * @param	mcChilds	Desactivation du clip enfant
		 **/
		public function ActionsBt(params:Object):void
		{
			mc              = params.mc;
			mChilds         = params.mChilds;
			totalF          = mc.totalFrames;
			mc.buttonMode   = true;

			mc.stop();
			
			mChilds = (!mChilds) ? mc.mouseChildren=false : mc.mouseChildren=true;
			//switch (mChilds){  case false:mc.mouseChildren = false;break;  case true: mc.mouseChildren = true;break;  default:mc.mouseChildren=false;}
			mc.addEventListener(MouseEvent.MOUSE_OVER, $action)
			mc.addEventListener(MouseEvent.MOUSE_OUT, $action)
			mc.addEventListener(MouseEvent.MOUSE_DOWN,$action)
			mc.addEventListener(MouseEvent.MOUSE_UP,$action)
		}
	//____________________________________________________________________________○○○--Ecoute roll
		private function $action(me:MouseEvent):void
		{
			typeAction = me.type;
			mc.addEventListener(Event.ENTER_FRAME, $roll_active);
			if(typeAction==MouseEvent.MOUSE_DOWN)mc.gotoAndStop(mc.totalFrames);
			if(typeAction==MouseEvent.MOUSE_UP)mc.gotoAndStop(mc.totalFrames-1);
		}
	//____________________________________________________________________________○○○--Gestion rollover
		private function $roll_active(e:Event):void
		{
			switch(typeAction)
			{
				case MouseEvent.MOUSE_OVER :
					mc.nextFrame();
					if(mc.currentFrame==mc.totalFrames-1)mc.stop();
						break;
				case MouseEvent.MOUSE_OUT :
					mc.prevFrame();
						break
			}
			if ((mc.currentFrame == totalF-1) || (mc.currentFrame == 1))
			{
				mc.removeEventListener(Event.ENTER_FRAME, $roll_active);
			}
		}			
	}
}