/*****************************************************************************************************  
* Rollover (AS3), version 1.0                                                                        * 
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
* @class    :   Rollover                                                                             *
* @author   :   Greg.N :: Artkabis                                                                   *
* @version  :   1.0 - class Rollover (AS3)                                                           *
* @since    :   30-05-2009 17:10                                                                     *
*                                                                                                    *
*****************************************************************************************************/

package fr.artkabis{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Rollover extends MovieClip {
	//________________________________________________________________________________○○○--Vars
		private var bouton:MovieClip
		private var totalF:int;
		private var typeAction:String
		 /*****	_______________________________________________________________○○○--Constructeur
		 * Gestion du rollOver dynamique
		 * @param	pbouton    :: Le movieClip utilisant les rollOver
		 * @param	clicEnfant :: Desactivation du clip enfant
		 *****/
		public function Rollover(pbouton:MovieClip,clicEnfant:Boolean):void
		{
			bouton = pbouton;
			totalF = bouton.totalFrames;
			bouton.stop();
			bouton.buttonMode = true;
			
			if (!clicEnfant) bouton.mouseChildren = true;
			else bouton.mouseChildren = false;
			bouton.addEventListener(MouseEvent.MOUSE_OVER, $action)
			bouton.addEventListener(MouseEvent.MOUSE_OUT, $action)
		}
	//____________________________________________________________________________○○○--Ecoute roll
		private function $action(me:MouseEvent):void
		{
			typeAction = me.type;
			bouton.addEventListener(Event.ENTER_FRAME, $roll_active);
		}
	//____________________________________________________________________________○○○--Gestion rollover
		private function $roll_active(e:Event):void
		{
			switch(typeAction)
			{
				case MouseEvent.MOUSE_OVER :
					bouton.nextFrame();
						break;
				case MouseEvent.MOUSE_OUT :
					bouton.prevFrame();
						break
			}
			if ((bouton.currentFrame == totalF) || (bouton.currentFrame == 1))
			{
				bouton.removeEventListener(Event.ENTER_FRAME, $roll_active);
			}
		}			
	}
}