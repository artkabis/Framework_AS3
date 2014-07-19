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

package fr.artkabis.utils
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Rollover extends MovieClip 
	{
	//________________________________________________________________________________○○○--Vars
		private var mc                     :*;
		private var totalF                 :int;
		private var typeAction             :String;
		private var activArray             :Boolean;
		private var mChilds                :Boolean;
		private var targetBt;
		 /*****	_______________________________________________________________○○○--Constructeur
		 * Gestion du rollOver dynamique
		 * @param	pmc    :: Le movieClip utilisant les rollOver
		 * @param	desactivChild :: Desactivation du clip enfant
		 *****/
		public function Rollover(params:Object):void
		{
			mc              = params.mc;
			totalF          = mc.totalFrames;
			if(mc is Array ){
				trace('rollOver multiple');
				for each(var bts in mc){
					bts.buttonMode   = true;
					bts.stop();
					bts.mouseChildren=false;
					bts.addEventListener(MouseEvent.MOUSE_OVER, $action);
					bts.addEventListener(MouseEvent.MOUSE_OUT, $action);
				}
			}else if(mc is MovieClip){
				mc.buttonMode   = true;
				mc.stop();
				mc.mouseChildren=false;
				mc.addEventListener(MouseEvent.MOUSE_OVER, $action);
				mc.addEventListener(MouseEvent.MOUSE_OUT, $action);
			}
		}
		//____________________________________________________________________________○○○--Ecoute roll des boutons
		private function $action(me:MouseEvent):void
		{
			targetBt = me.target;
			typeAction = me.type;
			me.updateAfterEvent();
			if(mc is Array)totalF=targetBt.totalFrames;
			targetBt.addEventListener(Event.ENTER_FRAME, $roll_active);
		}
	//____________________________________________________________________________○○○--Gestion rollover
		private function $roll_active(e:Event):void
		{
			switch(typeAction)
			{
				case MouseEvent.MOUSE_OVER :
					targetBt.nextFrame();
						break;
				case MouseEvent.MOUSE_OUT :
					targetBt.prevFrame();
						break
			}
			if ((targetBt.currentFrame == totalF) || (targetBt.currentFrame == 1))
			{
				targetBt.removeEventListener(Event.ENTER_FRAME, $roll_active);
			}
		}			
	}
}