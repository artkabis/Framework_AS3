package fr.artkabis.utils
{
    import flash.events.TextEvent;
    import flash.events.TimerEvent;
    import flash.text.TextField;
    import flash.utils.Timer;
        
    public dynamic class TypeWriter extends Array
    {
		private var _textField:TextField;
		private var _iterator:uint;
		private var _test:Array;
		private var _timer:Timer = new Timer(0);
		private var _pause:Array = [1000, null];
		private var _switchPause:Boolean;
                
		private var _aLaSuite:Boolean = true;
		private var _boucle:Boolean;
       
                //contrairement a Array, ici on ne peut pas creer un tableau vide de n elements avec un seul argument Number ds le constructeur
		public function TypeWriter(textField:TextField, ... args) 
		{
			super.push.apply(null, args);
			if (textField) start(textField);
		}

		public function start(textField:TextField):Boolean
		{
			_textField = textField;
			if (!_timer.running) 
			{
				_timer.addEventListener(TimerEvent.TIMER, onDelay);
				_timer.addEventListener(TimerEvent.TIMER_COMPLETE, endTimer);
                                
				timerLaucher();
				return true;
			}else return false;
		}
                
		override AS3 function push(... args):uint
		{
			super.push.apply(null, args);
			if (!_timer.running) timerLaucher();
			return length;
		}
                
        private function timerLaucher():void
        {  
			if (_switchPause) _test = _pause;
			else _test = this[_iterator];
                        
			 _switchPause = !_switchPause
                        
			_timer.delay = _test[0];
			_timer.repeatCount = _test[1] ? _test[1].length : 1;
        
			_timer.reset();
            _timer.start();
        }
                
        private function onDelay(e:TimerEvent):void
        { 
            if(_test[1]) _textField.appendText(_test[1].charAt(_timer.currentCount - 1));
        }

        private function endTimer(e:TimerEvent):void
        {
			if (!_switchPause) 
			{
				_iterator++
				if (_iterator == length){if (_boucle){_iterator = 0; _textField.text = "";}}
				else if(!_aLaSuite)  _textField.text = "";
			}
			if(_iterator < length) timerLaucher();
        } 
                //GETTER / SETTER
		public function set pause (aPause:uint):void { _pause = [aPause, null]; }
		public function get pause ():uint { return _pause[0]; }
                
		public function set aLaSuite (aALaSuite:Boolean):void { _aLaSuite = aALaSuite; }
		public function get aLaSuite ():Boolean { return _aLaSuite; }
                
		public function set boucle (aBoucle:Boolean):void { _boucle = aBoucle; }
		public function get boucle ():Boolean { return _boucle; }
    }       
}