package fr.artkabis.utils 
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Stage
	import fl.transitions.Tween;
	import fl.transitions.easing.Back;
	import fl.transitions.TweenEvent;	
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import flash.events.Event;
	
	import fr.artkabis.text.DrawText;
	
	public class ScreenDetect extends MovieClip
	{
		protected var _X          :int;
		protected var _Y          :int;
		protected var _min        :int;
		protected var _message    :String;
		protected var _suite      :String;
		protected var _infoRedim  :String;
		protected var _stage      :Stage;
		protected var _stageW     :int;
		protected var _drawT      :DrawText;
		
		public function ScreenDetect ($stage:Stage, $message:String, $min:int, $x:int, $y:int):void
		{
			_drawT = new DrawText({text:''});
			
			_X              = $x
			_Y              = $y;
			_message        = $message;
			_min            = $min;
			_stage          = $stage;
			_stage.addEventListener(Event.RESIZE,detection);
		}
		private function detection(e:Event):void
		{
			_suite = '';
			_stageW         = _stage.stageWidth;
			_infoRedim = 'La résolution minimum accèpté est de '+_min+', veuillez donc respecter cette contrainte...';
			(_message == null)    ?  _drawT.contenu = ''+_infoRedim :   _drawT.contenu = ''+_message;
			(_stageW < _min)      ?  _drawT.contenu = ''+_message   :   _drawT.contenu = ''+_suite;
			_drawT.taille = 12;
			_drawT.autosize = 'L';
			_drawT.gras = true;
			_drawT.large = 50;
			_drawT.multiligne = true;
			_drawT.mouseE = false;
			
			this.addChild(_drawT);
			
			replaceInfo(null);
		}
		private function replaceInfo(te:Event):void
		{
			_infoRedim.concat('\n _stageW');
			_drawT.contenu = _infoRedim;
			if(_stageW >= _min)detection(null);
		}
	}
}