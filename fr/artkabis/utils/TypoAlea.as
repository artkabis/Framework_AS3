package fr.artkabis.utils
{
    import flash.display.Sprite;
    import flash.events.Event;

    public class TypoAlea extends Sprite
    {
        private var _lettreAffiche:String;
        private var _finDelay:Number;
        private var _txtField:Object;
        private var tabsTypoFw:Array;
        private var _debutAnimNb:Number;
        private var _lettreAjoute:String;
        private var _msg:String;
        private var len:uint;
        private var tabsTypoBw:Array;
        private var _lettreRnd:String;
        private var eventFinAnim:Event;
        private var _typeAnim:String;
        private var _cntDebutAnim:Number;
        private var tabs:Array;
        public static const FINANIM:String = "finanim";
        private static const DELAY_CNT:uint = 10;

        public function TypoAlea()
        {
            eventFinAnim = new Event(TypoAlea.FINANIM);
            return;
        }

        public function ajoutAnim(param1:Object = null) : void
        {
            _txtField = param1.txtField;
            _msg = param1.msg;
            _typeAnim = param1.typeAnim;
			
            len = _msg.length;
            tabsTypoFw = [];
            tabsTypoBw = [];
            tabs = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
            _init();
            if (_typeAnim == "fw"){_txtField.text = "";}
            else{ _txtField.text = _msg;}
            addEventListener(Event.ENTER_FRAME, renduTypo, false, 0, true);
            return;
        }
        private function renduTypo(event:Event) : void
        {
            if (_typeAnim == "fw"){ ActualiseFwAnimTypo();}
            else{ActualiseBwAnimTypo();}
            return;
        }

        private function _init() : void
        {
            _lettreRnd = "";
            _lettreAffiche = "";
            _lettreAjoute = "";
            _debutAnimNb = Math.floor(tabs.length / _msg.length);
            _cntDebutAnim = 0;
            _finDelay = 0;
            var i:uint = 0;
            while (i < _msg.length)
            {
                tabsTypoFw[i] = {startCnt:0, finCnt:0, debutAnimNb:_debutAnimNb * i / 10, lettreActuelle:"", activeUnderScore:false};
                tabsTypoBw[i] = {startCnt:0, finCnt:0, debutAnimNb:_debutAnimNb * i / 10, lettreActuelle:_msg.charAt(i), activeUnderScore:false};
                i = i + 1;
            }
            return;
        }

        private function ActualiseFwAnimTypo() : void
        {
            _lettreAffiche = "";
            var i:uint = 0;
            while (i < _msg.length)
            {
                
                if (tabsTypoFw[i].debutAnimNb <= _cntDebutAnim)
                {
                    tabsTypoFw[i].activeUnderScore = true;
                    if (tabsTypoFw[i].startCnt < tabs.length - 20)
					{
                        _lettreRnd = tabs[Math.floor(Math.random() * tabs.length)].toUpperCase();
                        tabsTypoFw[i].lettreActuelle = _lettreRnd;
                    }
                    else{tabsTypoFw[i].lettreActuelle = _msg.charAt(i);}
                    tabsTypoFw[i].startCnt = tabsTypoFw[i].startCnt + 20;
				}
                else if (tabsTypoFw[(i - 1)].activeUnderScore){tabsTypoFw[i].lettreActuelle = "_";}
                _lettreAffiche = _lettreAffiche + tabsTypoFw[i].lettreActuelle;
                i = i + 1;
            }
            _txtField.text = _lettreAffiche;
            if (_txtField.text == _msg)
            {
                if (_finDelay > DELAY_CNT)
                {
                    _init();
                    dispatchEvent(eventFinAnim);
                    removeEventListener(Event.ENTER_FRAME, renduTypo);
                }
                _finDelay = _finDelay + 1;
            }
            _cntDebutAnim = _cntDebutAnim + 1;
            return;
        }


        private function ActualiseBwAnimTypo() : void
        {
            _lettreAffiche = "";
            var lengthMsg:* = _msg.length - 1;
            while (lengthMsg > 0)
            {
                
                if (tabsTypoBw[(lengthMsg - 1)].debutAnimNb <= _cntDebutAnim)
                {
                    tabsTypoBw[(lengthMsg - 1)].activeUnderScore = true;
                    if (tabsTypoBw[(lengthMsg - 1)].startCnt < tabs.length - 20)
                    {
                        _lettreRnd = tabs[Math.floor(Math.random() * tabs.length)];
                        _lettreRnd = _lettreRnd.toUpperCase();
                        tabsTypoBw[(lengthMsg - 1)].lettreActuelle = _lettreRnd;
                    }
                    else{tabsTypoBw[(lengthMsg - 1)].lettreActuelle = "_";}
                    if (lengthMsg != _msg.length){if (tabsTypoBw[lengthMsg].startCnt > tabs.length - 20){tabsTypoBw[(lengthMsg - 1)].lettreActuelle = "";}}
                    tabsTypoFw[lengthMsg].startCnt = tabsTypoFw[lengthMsg].startCnt + 20;
                }
                _lettreAffiche = _lettreAffiche + tabsTypoBw[(lengthMsg - 1)].lettreActuelle;
               lengthMsg = lengthMsg - 1;
            }
            if (_cntDebutAnim <= 10)
            {
                _lettreAffiche = _lettreAffiche.slice(2, _lettreAffiche.length);
                _lettreAffiche = _msg.charAt(0) + _msg.charAt(1) + _lettreAffiche;
            }
            _txtField.text = _lettreAffiche;
            if (_txtField.text == "_")
            {
                _txtField.text = "";
                if (_finDelay > DELAY_CNT)
                {
                    _init();
                    dispatchEvent(eventFinAnim);
                    removeEventListener(Event.ENTER_FRAME, renduTypo);
                }
                _finDelay = _finDelay + 1;
            }
            _cntDebutAnim = _cntDebutAnim + 1;
            return;
        }
    }
}
