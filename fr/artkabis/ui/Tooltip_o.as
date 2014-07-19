package fr.artkabis.ui
{
	import flash.display.MovieClip;
	import flash.system.System;
	
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import gs.TweenMax;
	import gs.easing.*;

	public class Tooltip extends MovieClip
	{
		private var _format:TextFormat;
		private var _ecart:int =10;
		private var _titre:String;
		private var _bt:MovieClip;
		private var _tooltip:InfoBulle;
		private var _tc:*;

		public function Tooltip (pBt:MovieClip,pTitre:String):void
		{
			_titre    =   pTitre;
			_bt       =   pBt;
			_format   =   new TextFormat();
			_tooltip  =   new InfoBulle();
			_tc       =   _tooltip.content;
			
			_bt.mouseChildren = _tooltip.mouseChildren = _tc.mouseEnabled = _tooltip.mouseEnabled = false;

			_tooltip.name = 'tooltip';
			_tooltip.alpha = 0;
			_bt.addEventListener('mouseOver',overBt1);
			_bt.addEventListener('mouseOut',outBt1);
			addEventListener('mouseOver',over);
			
			dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
		}			
		private function drawTT():void
		{
			setChildIndex(_tooltip,this.numChildren -1);
			_tc.titre.text = _titre;
			_tc.titre.alpha = 0;
			_tc.titre.multiline = false;
			_tc.titre.autoSize = TextFieldAutoSize.LEFT;
			_format.align = TextFormatAlign.LEFT;
			_tc.titre.defaultTextFormat = _format
		
			var _largTitre = _tc.titre.width;
			TweenMax.to(_tooltip,.4,{alpha:1});
			TweenMax.to(_tc.centre,.4,{width:_largTitre + _ecart});
			TweenMax.to(_tc.titre,.4,{delay:.2,alpha:1});
			_bt.addEventListener('enterFrame',posTT);
		}
		private function posTT(me:Event):void
		{
			_tooltip.x -= (_tooltip.x - mouseX)*.13;
			_tooltip.y -= (_tooltip.y - mouseY)*.13;
			_tooltip.y+= -3
			_tooltip.x+= -1
		}
		private function suppTT():void
		{
			_bt.mouseEnabled = false;
			_tc.titre.text = '';
			TweenMax.to(_tooltip,.7,{x:_bt.x+_bt.width/2,y:_bt.y+_bt.height ,alpha:0,onComplete:reactiv});
			TweenMax.to(_tc.centre,.3,{width:_ecart});
			_bt.removeEventListener('enterFrame',posTT);
			function reactiv():void
			{
				removeChild( _tooltip );
				_bt.mouseEnabled = true;
			}
		}
		private function overBt1(me:MouseEvent):void
		{
			this.addChild(_tooltip);
			drawTT();
		}
		private function outBt1(me:MouseEvent):void
		{
			suppTT();
		}
		private function over(me:MouseEvent):void{
			if(me.target.name != _bt.name)me.target.mouseEnabled = false;
		}
	}
}