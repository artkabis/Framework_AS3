package fr.artkabis.display 
{
    import flash.events.Event;
    import flash.display.Stage;
    import flash.display.SimpleButton;
    import flash.display.DisplayObject;

	public class ArtkSimpleButton extends SimpleButton 
	{
        protected var _detruit:Boolean;
        
        public function ArtkSimpleButton(declic:DisplayObject = null, clic:DisplayObject = null, over:DisplayObject = null, zone:DisplayObject = null) {
            super(declic, over, clic,zone);
        }
        
        override public function get stage():Stage {
            if (super.stage == null) {
                try {
                    return this.parent.stage;
                } catch (e:Error) {}
            }
            
            return super.stage;
        }
        public function get detruit():Boolean {
            return this._detruit;
        }
        public function detruir():void {
            this._detruit = true;
            
            if (this.parent != null)
                this.parent.removeChild(this);
        }
    }
}
