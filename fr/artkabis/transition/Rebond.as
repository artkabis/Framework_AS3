package fr.artkabis.transition
{
	import flash.events.Event;
	
	public class Rebond
	{
		private var _mc:*;
		private var _coefy:Number = 0;
		private var _coefw:Number = 1;
		private var _seuil:Object;
		private var _vitesse:Number;
		private var _rebond:Number;
		private var _inverse:Boolean;
		private var _maxY:Number=0;
		private var _sy:Number;
		private var _mcz:Number;
		private var _nbRebond:int;
		private var _maxR
		
		public function Rebond($mc:*=null, $seuil:Object=null, $vitesse:Number=0.1, $rebond:Number=0.9, $inverse:Boolean=false)  :  void
		{
			_mc      = $mc;
			_seuil   = $seuil
			_vitesse = $vitesse
			_rebond  = $rebond;
			_inverse = $inverse;
			
			_maxY=_mc.y;
			_sy=_seuil.y;
			_maxR = _rebond;
		  if(!_inverse){ _mc.addEventListener(Event.ENTER_FRAME, __anim);}
		  if(_inverse){ _mc.addEventListener(Event.ENTER_FRAME, __anim2);}
		}; 
		private function __anim( e:Event )  :  void
		{
			_coefy += _vitesse;
			_mc.y += _coefy;
			
			_coefw= (_maxY-_sy)/_mc.y
			_mcz = 1-_coefw;
			//_mc.scaleX=_mc.scaleY=_mcz
			
			if (_mc.hitTestObject(_seuil) )
			{
				_nbRebond++;
				_mc.y = _seuil.y;
				_coefy *= -1;
				_vitesse += _rebond;
			}
			if (_mc.y >_seuil.y) 
			{
				trace('ok');
				_mc.removeEventListener(Event.ENTER_FRAME, __anim)
				_mc.y = _seuil.y;
			}
			
			trace("_nbRebond:"+_nbRebond);
			trace("_coefw : "+_coefw,", _mcz : "+_mcz);
		};
		
		private function __anim2( e:Event )  :  void
		{
			_coefy += _vitesse;
			_mc.y -= _coefy;
			if (_mc.hitTestObject(_seuil) )
			{
				_mc.y = _seuil.y;
				_coefy *= -1;
				_vitesse += _rebond;
			}
			if (_mc.y <_seuil.y) 
			{
				_mc.removeEventListener(Event.ENTER_FRAME, __anim2)
				_mc.y = _seuil.y;
			}
		};

	}
}