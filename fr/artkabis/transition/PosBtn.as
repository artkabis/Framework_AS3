package fr.artkabis.transition
{
	import gs.TweenMax;
	import gs.easing.*;
	import flash.display.MovieClip
	public class PosBtn 
	{
		private var _groupe:Array;
		private var _tab:Array;
		private var _nbElements:int;
		private var _wBt:Number;
		private var _maxEcart:Number;
		private var _initX:Number;
		private var _delay:Number;
		private var mcVid
		public function PosBtn($tab:Array,$initX:Number=0,$maxEcart:Number=100,$delay:Number=1.5)
		{
			
			_tab = $tab;
			_initX = $initX
			_maxEcart = $maxEcart;
			_wBt = _tab[0].width;
			_groupe = _tab;
			_delay = $delay;
			
			derouler();
		}
		private function derouler():void
		{
			trace('_groupe.length():::'+_groupe.length)
			_nbElements = _groupe.length;
			for(var i:uint=0; i<_nbElements;i++)
			{
				_tab.push(mcVid = new MovieClip());
				_groupe[i].x =_initX;
				TweenMax.to(_groupe[i+1],1,{delay:1.5, x: _initX +  _groupe[i].x + (i+1)* ( _wBt + _maxEcart ),ease:Sine.easeOut});
			}
		}
	}
}