package fr.artkabis.utils
{
    import flash.display.Sprite;
    import flash.events.Event;

    public class RandomTypo extends Sprite
    {
        private var _resultLetter:String;
        private var _endDelay:Number;
        private var _txtField:Object;
        private var aobjFwTypo:Array;
        private var _startMotionNum:Number;
        private var _joinLetter:String;
        private var _msg:String;
        private var len:uint;
        private var aobjBwTypo:Array;
        private var _rndLetter:String;
        private var evt_endmotion:Event;
        private var _motionType:String;
        private var _startMotionCnt:Number;
		private var _speed:int;
		private var _scene:Object;
        private var arry:Array;
        public static const ENDMOTION:String = "endmotion";
        private static const DELAY_CNT:uint = 10;

        public function RandomTypo()
        {
            evt_endmotion = new Event(RandomTypo.ENDMOTION);
            return;
        }// end function

        public function addMotion(param1:Object = null) : void
        {
            _txtField = param1.txtField;
            _msg = param1.msg;
            _motionType = param1.motionType;
			_speed = param1.speed;
			_scene = param1.scene;
			
            len = _msg.length;
            aobjFwTypo = [];
            aobjBwTypo = [];
            arry = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
            _init();
            if (_motionType == "fw"){_txtField.text = "";}
            else{ _txtField.text = _msg;}
            addEventListener(Event.ENTER_FRAME, onRenderTypoHandler, false, 0, true);
            return;
        }// end function
        private function onRenderTypoHandler(event:Event) : void
        {
            if (_motionType == "fw"){ updateFwTypoMotion();}
            else{updateBwTypoMotion();}
            return;
        }// end function

        private function _init() : void
        {
			var limite:int;
			if(_scene && _speed){
				limite = (_speed>90)?90 : _speed && (_speed<1)?1 : _speed
				_scene.frameRate = _limite;
			}
            _rndLetter = "";
            _resultLetter = "";
            _joinLetter = "";
            _startMotionNum = Math.floor(arry.length / _msg.length);
            _startMotionCnt = 0;
            _endDelay = 0;
            var i:uint = 0;
            while (i < _msg.length)
            {
                aobjFwTypo[i] = {startCnt:0, endCnt:0, startMotionNum:_startMotionNum * i / 10, currentLetter:"", underScoreFlg:false};
                aobjBwTypo[i] = {startCnt:0, endCnt:0, startMotionNum:_startMotionNum * i / 10, currentLetter:_msg.charAt(i), underScoreFlg:false};
                i = i + 1;
            }
            return;
        }// end function

        private function updateFwTypoMotion() : void
        {
            _resultLetter = "";
            var i:uint = 0;
            while (i < _msg.length)
            {
                
                if (aobjFwTypo[i].startMotionNum <= _startMotionCnt)
                {
                    aobjFwTypo[i].underScoreFlg = true;
                    if (aobjFwTypo[i].startCnt < arry.length - 20)
					{
                        _rndLetter = arry[Math.floor(Math.random() * arry.length)].toUpperCase();
                        aobjFwTypo[i].currentLetter = _rndLetter;
                    }
                    else{aobjFwTypo[i].currentLetter = _msg.charAt(i);}
                    aobjFwTypo[i].startCnt = aobjFwTypo[i].startCnt + 20;
				}
                else if (aobjFwTypo[(i - 1)].underScoreFlg){aobjFwTypo[i].currentLetter = "_";}
                _resultLetter = _resultLetter + aobjFwTypo[i].currentLetter;
                i = i + 1;
            }
            _txtField.text = _resultLetter;
            if (_txtField.text == _msg)
            {
                if (_endDelay > DELAY_CNT)
                {
                    _init();
                    dispatchEvent(evt_endmotion);
                    removeEventListener(Event.ENTER_FRAME, onRenderTypoHandler);
                }
                _endDelay = _endDelay + 1;
            }
            _startMotionCnt = _startMotionCnt + 1;
            return;
        }// end function


        private function updateBwTypoMotion() : void
        {
            _resultLetter = "";
            var lengthMsg:* = _msg.length - 1;
            while (lengthMsg > 0)
            {
                
                if (aobjBwTypo[(lengthMsg - 1)].startMotionNum <= _startMotionCnt)
                {
                    aobjBwTypo[(lengthMsg - 1)].underScoreFlg = true;
                    if (aobjBwTypo[(lengthMsg - 1)].startCnt < arry.length - 20)
                    {
                        _rndLetter = arry[Math.floor(Math.random() * arry.length)];
                        _rndLetter = _rndLetter.toUpperCase();
                        aobjBwTypo[(lengthMsg - 1)].currentLetter = _rndLetter;
                    }
                    else{aobjBwTypo[(lengthMsg - 1)].currentLetter = "_";}
                    if (lengthMsg != _msg.length){if (aobjBwTypo[lengthMsg].startCnt > arry.length - 20){aobjBwTypo[(lengthMsg - 1)].currentLetter = "";}}
                    aobjFwTypo[lengthMsg].startCnt = aobjFwTypo[lengthMsg].startCnt + 20;
                }
                _resultLetter = _resultLetter + aobjBwTypo[(lengthMsg - 1)].currentLetter;
               lengthMsg = lengthMsg - 1;
            }
            if (_startMotionCnt <= 10)
            {
                _resultLetter = _resultLetter.slice(2, _resultLetter.length);
                _resultLetter = _msg.charAt(0) + _msg.charAt(1) + _resultLetter;
            }
            _txtField.text = _resultLetter;
            if (_txtField.text == "_")
            {
                _txtField.text = "";
                if (_endDelay > DELAY_CNT)
                {
                    _init();
                    dispatchEvent(evt_endmotion);
                    removeEventListener(Event.ENTER_FRAME, onRenderTypoHandler);
                }
                _endDelay = _endDelay + 1;
            }
            _startMotionCnt = _startMotionCnt + 1;
            return;
        }// end function

    }
}
