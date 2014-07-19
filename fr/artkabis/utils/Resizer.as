package fr.artkabis.utils

{
	import flash.text.TextField;
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Capabilities
	import fr.artkabis.text.DrawText;
	
		public class Resizer extends Sprite {
			
		protected var _X          :int;
		protected var _Y          :int;
		protected var _min        :int;
		protected var _textInfo   :TextField;
		protected var _message    :String;
		protected var _suite      :String;
		protected var _infoRedim  :String;
		protected var _stage      :Stage;
		protected var _stageW     :int;
		protected var _stageH     :int;
		protected var _resX       :int;
		protected var _resY       :int;
		protected var _posX       :int;
		protected var _posY       :int;
		protected var _cible      :MovieClip;
		protected var _drawT       :DrawText;
		protected var params      :Object;
		
		private var _mc:Sprite;
		private var _mcStage:Stage;
		
		public function Resizer (params:Object):void
		{
			_textInfo = new TextField();
			_drawT = new DrawText({})
			
			_mc      =      params.mc;
			_message =      params.message;
			_min     =      params.min;
			_X       =      params.x;
			_Y       =      params.y;
			
			_suite = '';
			_mcStage = _mc.stage;
			
			//________________________________○○○---Params Texte resolution
			this.addChild(_drawT);
			_drawT.x = _X;
			_drawT.y = _Y;
			_drawT.large = 70;
			_drawT.color = '#ffffff';
			_drawT.mouseE = false;
			//______________________○○○---Fin
			
			_infoRedim = 'La résolution minimum accèpté \nest de '+_min+ ', veuillez donc respecter \ncette contrainte...';
			(_message == null)   ?  _message = _infoRedim          :   _message = _message; 
			(_message == null)   ?  _drawT.contenu = _infoRedim    :   _drawT.contenu = _message;
			( _min == 0)         ?  _min = 800                     :   _min = _min;
			(_mc.width <= _min)  ?  _drawT.contenu = _message+''   :   _drawT.contenu = _suite+'';
			
			if (Capabilities.screenResolutionX >_min) 
             { 
				addStageListener();
			 }
		}
		
		public function addStageListener() {
			_mcStage.scaleMode = StageScaleMode.NO_SCALE;
			_mcStage.align = StageAlign.TOP_LEFT;
			_mcStage.addEventListener(Event.RESIZE, resizeHandler);
		}
		
		private function resizeHandler(event:Event):void {
			if (_mcStage.stageWidth > _min)_drawT.contenu = '';
			if (_mcStage.stageWidth < _min)_drawT.contenu = _message;
			trace("stageWidth: "+_mcStage.stageWidth);
			trace("stageHeight: "+_mcStage.stageHeight);
			_mc.x = _mcStage.stageWidth/2;
			_mc.y = _mcStage.stageHeight/2;
			_mc.width = _mcStage.stageWidth;
			_mc.height = _mcStage.stageHeight
		}
	}
}