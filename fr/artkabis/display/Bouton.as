package fr.artkabis.display
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;

    public dynamic class Bouton extends Sprite
    {
		private var _X,_Y,_W,_H:Number;
		private var _C:uint;
		private var _BM,_ME,_UC:Boolean;
		
		public function get X():Number{return _X;};
		public function set X($x:Number){_X=$x;};
		
		public function get Y():Number{return _Y;};
		public function set Y($y:Number){_Y=$y;};
		
		public function get W():Number{return _W;};
		public function set W($w:Number){_W=$w;};
		
		public function get H():Number{return _H;};
		public function set H($h:Number){_W=$h;};
		
		public function get color():uint{return _C;};
		public function set color($c:uint){_C=$c;};
		
		public function get bouttonMode():Boolean{return _BM;};
		public function set bouttonMode($bm:Boolean){_BM=$bm;};
		
		public function get mouseEnable():Boolean{return _ME;};
		public function set mouseEnable($me:Boolean){_ME=$me;};
		
		public function get useCursor():Boolean{return _UC;};
		public function set useCursor($uc:Boolean){_UC=$uc;};
			   
	   public function Bouton(
							   $x:Number=0,
							   $y:Number=0,
							   $width:Number = 150 ,
							   $height:Number = 20,
							   $color:uint=0x00ff00,
							   $btMode:Boolean=true,
							   $mouseE:Boolean=true,
							   $useC:Boolean =true
							   )
        {
													_X  = $x;
													_Y  = $y;
													_W  = $width;
													_H  = $height;
													_C  = $color;
													_BM = $btMode;
													_ME = $mouseE;
													_UC = $useC;
			
            graphics.beginFill($color)  ;
            graphics.drawRect( _X, _Y, _W, _H )  ;
            buttonMode                                                = _BM  ;
            mouseEnabled                                              = _ME  ;
            useHandCursor                                             = _UC  ;
            addEventListener( MouseEvent.MOUSE_DOWN   , __actions )  ;
			addEventListener( MouseEvent.MOUSE_UP     , __actions )  ;
			addEventListener( MouseEvent.MOUSE_OVER   , __actions )  ;
			addEventListener( MouseEvent.MOUSE_OUT    , __actions )  ;
        }
        
        prototype.press = function():void
        {
            // nothing, overrides now this method.
        };
		prototype.release = function():void
        {
            // nothing, overrides now this method.
        };
		prototype.rollOver = function():void
        {
            // nothing, overrides now this method.
        };
		prototype.rollOut = function():void
        {
            // nothing, overrides now this method.
        };
        
        private function __actions( e:MouseEvent = null ):void
        {
            switch(e.type)
			{
				case MouseEvent.MOUSE_DOWN   :this[ "press" ]       ( ) ;break;
				case MouseEvent.MOUSE_UP     :this[ "release" ]     ( ) ;break;
				case MouseEvent.MOUSE_OVER   :this[ "rollOver" ]    ( ) ;break;
				case MouseEvent.MOUSE_OUT    :this[ "rollOut" ]     ( ) ;break;
			}
        }
    }
}