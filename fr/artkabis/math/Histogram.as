package fr.artkabis.math
{
	import flash.display.*;

	public class Histogram extends Sprite
	{
		private var _source:BitmapData, _width:int, _height:int;
		private var _rArray:Array, _vArray:Array, _bArray:Array;
		
		public var rholder:Sprite, vholder:Sprite, bholder:Sprite;
		
		public function Histogram(width:int, height:int):void
		{
			_width = width;
			_height = height;
			
			initialize();
		}
		
		private function initialize():void
		{
			_rArray = new Array();
			_vArray = new Array();
			_bArray = new Array();
			
			graphics.clear();
			graphics.beginFill(0, 0);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();		
			
			rholder = new Sprite();
				rholder.y = height;
				rholder.blendMode = BlendMode.LIGHTEN;
				addChild(rholder);
			
			vholder = new Sprite();
				vholder.y = height;
				vholder.blendMode = BlendMode.LIGHTEN;
				addChild(vholder);		
			
			bholder = new Sprite();
				bholder.y = height;
				bholder.blendMode = BlendMode.LIGHTEN;
				addChild(bholder);
		}
		
		private function reset():void
		{
			for (var i:int = 0; i < 256; i++) { _rArray[i] = _vArray[i] = _bArray[i] = 0; }
			
			rholder.graphics.clear();
			vholder.graphics.clear();
			bholder.graphics.clear();
		}
		
		public function analyze(source:BitmapData):void
		{
			reset();
			_source = source;
			_source.lock();
			
			var color:uint, r:int, v:int, b:int;
			
			for (var s:int = 0; s < _source.width; s++)
			{
				for (var t:int = 0; t < _source.height; t++)
				{
					color = _source.getPixel(s, t);
						r = color >> 16;
						v = color >> 8 & 0xFF;
						b = color & 0xff;
						
						_rArray[r] += Boolean(r) ? 1 : 0;
						_vArray[v] += Boolean(v) ? 1 : 0;
						_bArray[b] += Boolean(b) ? 1 : 0;
				}
			}
			
			draw();
			
			_source.unlock();
		}
		
		private function draw():void
		{
			rholder.graphics.lineStyle(0.25, 0xff0000);
			vholder.graphics.lineStyle(0.25, 0x00ff00);
			bholder.graphics.lineStyle(0.25, 0x0000ff);
			
			rholder.graphics.beginFill(0xff0000);
			vholder.graphics.beginFill(0x00ff00);
			bholder.graphics.beginFill(0x0000ff);
			
			for (var i:int = 0; i < 255; i++)
			{
				rholder.graphics.lineTo(i, -_rArray[i]);
				vholder.graphics.lineTo(i, -_vArray[i]);
				bholder.graphics.lineTo(i, -_bArray[i]);
			}
			
			rholder.graphics.lineTo(255, 0);
			vholder.graphics.lineTo(255, 0);
			bholder.graphics.lineTo(255, 0);
			
			rholder.graphics.lineTo(0, 0);
			vholder.graphics.lineTo(0, 0);
			bholder.graphics.lineTo(0, 0);
			
			var maxHeight:int = Math.max(rholder.height, vholder.height, bholder.height);
			
			rholder.scaleX = vholder.scaleX = bholder.scaleX = _width / 255;
			rholder.scaleY = vholder.scaleY = bholder.scaleY = (_height / maxHeight);
		}
		
		public function refresh():void
		{
			analyze(_source);
		}
	}
}