/**************************************************UTILISATION*********************************************
***   import fr.artkabis.transition.MotionBlur;                                                         ***
***   var motion:MotionBlur = new MotionBlur({cible:mc, duree:1,ease:'BO',departX:0,x:100,blur:true});  ***
***                                                                                                     ***
***********************************************************************************************************/




package fr.artkabis.transition
{
	import flash.display.MovieClip;
	import gs.TweenMax;
	import gs.easing.Linear;
	import gs.easing.Back;
	import gs.easing.Sine;
	
	public class MotionBlur extends MovieClip
	{
		private var _cible                       :MovieClip;
		private var _Y                           :Number;
		private var _X                           :Number;
		private var _blur                        :Boolean;
		private var _duree                       :Number;
		private var _ease                        :String;
		private var _mouv                        :Object;
		private var _departX                     :Number;
		private var _departY                     :Number;
		private var _mcDefaut                    :MovieClip;
		private var params                       :Object;
		
		public function MotionBlur(params:Object):void
		{
			_mcDefaut   =   new MovieClip();
			_cible      =   params.cible;
			_duree      =   params.duree;
			_departX    =   params.departX;
			_departY    =   params.departY;
			_X          =   params.x;
			_Y          =   params.y;
			_blur       =   params.blur;
			_ease       =   params.ease;
			
			_mcDefaut.name='_mcDefaut';
			if(_cible === null)_cible    =   _mcDefaut; else _cible=params.cible;
			
			_duree    = (isNaN(_duree) == true)    ?   _duree    =    1               : _duree    = _duree;
			_departX  = (isNaN(_departX) == true)  ?   _departX  =    0               : _departX  = _departX;
			_departY  = (isNaN(_departY) == true)  ?   _departY  =    0               : _departY  = _departY;
			_X        = (isNaN(_X) == true)        ?   _X        =    _cible.x        : _X        = _X;
			_Y        = (isNaN(_Y) == true)        ?   _Y        =    _cible.x        : _Y        = _Y;
			
			trace('_cible::'+_cible.name+', _duree::'+_duree+', departX::'+_departX+', departY::'+_departY+', _X::'+_X+', _Y::'+_Y+', _blur::'+_blur+', _ease::'+_ease);
			
			switch (_ease)
			{
				case 'LI':
				_mouv = Linear.easeIn;
				break;
				case 'LO':
				_mouv = Linear.easeOut;
				break;
				case 'BI':
				_mouv = Back.easeIn;
				break;
				case 'BO':
				_mouv = Back.easeOut;
				break;
				case 'SI':
				_mouv = Sine.easeIn;
				break;
				case 'SO':
				_mouv = Sine.easeOut;
				break;
				default:
				_mouv = Back.easeOut;
			}
			
			_cible.x = _departX;
			_cible.y = _departY;
			
			if(_ease && _blur)TweenMax.to(_cible,_duree,{x:_X , y:_Y , ease:_mouv,onComplete:finTween,onCompleteParams:[_cible], blurFilter:{blurX:100,blurY:20}});
			else if(!_ease && _blur)TweenMax.to(_cible,_duree,{x:_X , y:_Y, onComplete:finTween , onCompleteParams:[_cible], blurFilter:{blurX:100,blurY:20}});
			else if(_ease && !_blur)TweenMax.to(_cible,_duree,{x:_X , y:_Y , ease:_mouv});
			else TweenMax.to(_cible,_duree,{x:_X , y:_Y});
		}
		private function finTween(_cible:MovieClip):void{TweenMax.to(_cible,.5,{blurFilter:{blurX:0, blurY:0}});}
	}
}