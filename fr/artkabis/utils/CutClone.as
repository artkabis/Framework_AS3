package fr.artkabis.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import fr.artkabis.geom.Square
	
	public class CutClone extends Sprite
	{
		[Embed(source = "../../../assets/lomo1.jpg")] private var Lomo1:Class;
		[Embed(source = "../../../assets/lomo2.jpg")] private var Lomo2:Class;
		[Embed(source = "../../../assets/lomo3.jpg")] private var Lomo3:Class;
		[Embed(source = "../../../assets/lomo4.jpg")] private var Lomo4:Class;
		
		private var bmd0:BitmapData;
		private var bmd1:BitmapData;
		private var bmd2:BitmapData;
		private var bmd3:BitmapData;
		private var bmd4:BitmapData;
		
		public function CutClone() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			scrollRect = new Rectangle(0, 0, 576, 376);
			
			bmd0 = new BitmapData(576, 428, true, 0);
			bmd1 = Bitmap(new Lomo1()).bitmapData;
			bmd2 = Bitmap(new Lomo2()).bitmapData;
			bmd3 = Bitmap(new Lomo3()).bitmapData;
			bmd4 = Bitmap(new Lomo4()).bitmapData;
			
			bmd0.copyPixels(bmd1, bmd1.rect, new Point());
			
			update();
			
			addEventListener(MouseEvent.MOUSE_DOWN, mDown);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		

		
		private var rect:Rectangle;
		
		private function update(selection:Boolean = false):void
		{
			graphics.beginBitmapFill(bmd0);
			graphics.drawRect(0, 0, bmd0.width, bmd0.height);
			graphics.endFill();
			
			if (selection)
			{
				graphics.lineStyle(1, 0xff, 0.5);
				graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			}
		}
		
		private function mDown(e:MouseEvent):void 
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, mUp);
			
			rect = new Rectangle(mouseX, mouseY, 2, 2);
		}
		
		private function mMove(e:MouseEvent):void 
		{
			rect.width = mouseX - rect.x;
			rect.height = mouseY - rect.y;
			
			update(true);
		}
		
		private function mUp(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mUp);
			
			var s:Square = new Square();
				s.x = rect.x;
				s.y = rect.y;
				s.draw(bmd0, rect);
				
				addChild(s);
				
			update();
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			trace(e.keyCode);
			switch(e.keyCode)
			{
				case 97:
				case 49:
					bmd0.copyPixels(bmd1, bmd1.rect, new Point());
					break;
					
				case 98:
				case 50:
					bmd0.draw(bmd2);
					break;
					
				case 99:
				case 51:
					bmd0.draw(bmd3);
					break;
					
				case 100:
				case 52:
					bmd0.draw(bmd4);
					break;
					
				case 13:
					Square.AUTOUPDATE = !Square.AUTOUPDATE;
					break;
					
				default:
					trace(e.keyCode);
					break;
			}
		}
	}
}