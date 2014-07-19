package fr.artkabis.graphics
{
	import flash.events.Event;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import fr.artkabis.utils.ConvertColor;
	
	public class Background extends Shape
	{
		private var _x,_y,_height,_epaisseur,_width:Number;
		private var _color,_colorCont:uint;
		private var _activLine:Boolean;
		private var _rect:Shape;
		private var cc:ConvertColor=new ConvertColor();
		private var rgb,contrgb:Object;
		private var hex,conthex:uint;
		private var _full:Boolean;
		private var _stage:Stage;
		private var _baseW:Number;
		private var _baseH:Number;
		
		public function get X():Number{return _x;}
		public function set X($x:Number){_x = $x}
		
		public function get Y():Number{return _y;}
		public function set Y($y:Number){_y = $y}
		
		public function get HEIGHT():Number{return _height;}
		public function set HEIGHT($height:Number){_height = $height}

		public function get WIDTH():Number{return _width;}
		public function set WIDTH($width:Number){_width = $width}
		
		public function get EPAISSEUR():*{if(_epaisseur==undefined){_epaisseur = String("← ←pas de contour→ →");return String(_epaisseur);};return _epaisseur;}
		public function set EPAISSEUR($epaisseur:Number){_epaisseur = $epaisseur}
		
		public function get STAGE(){return _stage;}
		public function set STAGE($stage:Stage){_stage = $stage};
		
		public function get FULL(){return _full;}
		public function set FULL($full:Boolean){_full = $full};
		
		public function get COLORRGB():String
		{
			rgb = cc.hex2rgb(_color);
			return rgb.r+'.'+rgb.g+'.'+rgb.b;
		}
		public function get COLORHEX():String
		{
			hex = cc.rgb2hex(rgb.r,rgb.g,rgb.b);
			return cc.dec2hex(hex);
		}
		public function get COLORCONTRGB():String
		{
			contrgb = cc.hex2rgb(_colorCont);
			return contrgb.r+'.'+contrgb.g+'.'+contrgb.b;
		}
		public function get COLORCONTHEX():String
		{
			conthex = cc.rgb2hex(contrgb.r,contrgb.g,contrgb.b);
			return cc.dec2hex(conthex);
		}

		public function get COLOR():uint{return _color;}
		public function set COLOR($color:uint){_color = $color}
		
		public function get COLORCONT():uint{return _colorCont;}
		public function set COLORCONT($colorCont:uint){_colorCont = $colorCont}
		
		public function get BG():Shape{return _rect;}
		
		public function get full():Boolean{return _full;}
		public function set full($full:Boolean){_full=$full;}
		
		public function Background(){}
		public function drawRect($x:Number=0,$y:Number=0,$width:Number=100,$height:Number=100,$color:uint=0xffffff):Boolean
		{
			_x=$x
			_y=$y
			_height=$height;
			_width=$width;
			_color = $color;
			_activLine=true;
			
			if(_full && _stage!=null){trace('full activé');_width = _stage.stageWidth;_height=_stage.stageHeight;_x=0;_y=0;_stage.addEventListener(Event.RESIZE,resiz);}
			if(_full && _stage==null)trace('vous devez définir le paramètre STAGE...');
			return _activLine;

		}
		private function resiz(e:Event):void{
			_width = _stage.stageWidth;
			_height = _stage.stageHeight;
			_rect.width = _width;
			_rect.height=_height;
			_rect.x =(_baseW-_width)/2;
			_rect.y = (_baseH-_height)/2;
		}
		public function lineStyle($ep:Number=1,$colorCont:Number=0x000000):void
		{
			_epaisseur = $ep
			_colorCont = $colorCont;
		}
		
		public function draw():Shape
		{
			rgb = cc.hex2rgb(_color);
			contrgb = cc.hex2rgb(_colorCont);
			_rect = new Shape();
			_rect.graphics.beginFill(_color);
			if(_activLine){_rect.graphics.lineStyle(_epaisseur,_colorCont);}
			_rect.graphics.drawRect(_x,_y,_width,_height);
			_baseW = _width;
			_baseH = _height;
			return _rect;
		}
	}
}