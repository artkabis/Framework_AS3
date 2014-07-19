package fr.artkabis.graphics
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.filters.ColorMatrixFilter;
	
	import flash.geom.Point;
	
	
	/**
	* La classe Assombre permet d'assombrir une image arpès un événement de type MouseEvent.CLICK
	*
	* @author		NICOLLE-Gregory - Artkabis
	* @version		1.0
	* @date 		26.03.2010
	*
	* @example Dans cet exemple il est créé 10 copies de bitmap nommé image elles seront position de 10 pixels en 10 pixels sur l'axe x et à 0 pixel de l'axe y
	* 
	*
	* <listing version="1.0">
	*     Copy.draw( {scene:this, cible:image, nb:10, tabX:new Array(0,10,20,30,40,50,60,70,80,90,100), tabY:new Array(0,0,0,0,0,0,0,0,0,0});
	*  </listing>
	*/

	public class Assombre extends Sprite
	{
		[Embed(source = "../../../assets/cube.jpg")] private var Img:Class;
		
		private var bmd:BitmapData;
		
		public function Assombre():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			bmd = Bitmap(new Img()).bitmapData;
			
			graphics.clear();
			graphics.beginBitmapFill(bmd);
			graphics.drawRoundRect(0, 0, bmd.width, bmd.height, 20);
			graphics.endFill();
			
			stage.addEventListener(MouseEvent.CLICK, assombrir);
		}
		
		private function assombrir(e:MouseEvent):void 
		{
			bmd.applyFilter(bmd, bmd.rect, new Point(), new ColorMatrixFilter([	1, 0, 0, 0, 0,
																				0, 1, 0, 0, 0,
																				0, 0, 1, 0, 0,
																				0, 0, 0, 0.5, 0]));
		}
		
	}

}