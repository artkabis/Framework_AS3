package fr.artkabis.geom
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class Square extends Sprite
	{
		public static var AUTOUPDATE:Boolean = true;
		
		public function Square() { }
		
		public function draw(bmd:BitmapData, rect:Rectangle):void
		{
			alpha = 0.75;
			graphics.clear();
			graphics.beginBitmapFill(bmd, new Matrix(1, 0, 0, 1, -rect.x, -rect.y), false);
			graphics.drawRect(0, 0, rect.width, rect.height);
			graphics.endFill();
			
			if (!AUTOUPDATE) { filters = [new BlurFilter(0, 0, 1)]; }
			
			addEventListener(MouseEvent.MOUSE_DOWN, drag);
			addEventListener(MouseEvent.MOUSE_UP, drop);
		}
		
		private function drag(e:MouseEvent):void
		{
			e.stopImmediatePropagation();
			startDrag();
			
			parent.setChildIndex(this, parent.numChildren - 1);
		}
		
		private function drop(e:MouseEvent):void { stopDrag(); }
	}
}