package fr.artkabis.graphics 
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.Bitmap
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.net.URLRequest;
	
	public class Brume extends Sprite
	{
		private var container    :Sprite;
		private var loader       :Loader;
		private var req          :URLRequest;
		private var image        :DisplayObject;
		private var randomSeed   :Number;
		private var brumeBMP     :Bitmap;
		private var brume        :BitmapData;
		private var perlinOffset :Array;
		private var brumeMask    :Shape;
		private var g            :Graphics;
		
		public function Brume($fichier:String) 
		{
			super();
			
			container  = new Sprite();
			loader     = new Loader();
			req        = new URLRequest($fichier);
		
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleComplete);
			loader.load(req);
		}
		
		private function handleComplete(e:Event):void
		{
			image = LoaderInfo(e.target).content;
			container.addChild(image);
				
			// BitmapData du brouillard
			brume = new BitmapData(image.width, image.height/6, true, 0x00000000);
			brumeBMP = new Bitmap(brume);
			brumeMask = new Shape();
			
			// Paramètres du perlin noise
			randomSeed = Math.floor(Math.random() * 255);
			var p1:Point = new Point(10, 100);
			var p2:Point = new Point(50, 10);
			perlinOffset = [p1, p2];
				
			// Mode de fusion, positionnement, filtre et masque
			brumeBMP.blendMode = BlendMode.OVERLAY;
			brumeBMP.y = 148;
			brumeBMP.filters = [new BlurFilter(0, 10)];
		
			
			g = brumeMask.graphics;
			g.beginFill(0x000000, 0.5);
			g.moveTo(0, brumeBMP.y);
			g.lineTo(0, brumeBMP.y + brumeBMP.height);
			g.curveTo(brumeBMP.width / 2, brumeBMP.y + brumeBMP.height + 10, brumeBMP.width, brumeBMP.y + brumeBMP.height - 50);
			g.lineTo(brumeBMP.width, brumeBMP.y - 20);
			g.curveTo(brumeBMP.width / 2, brumeBMP.y + 50, 0, brumeBMP.y);
			g.lineTo(0, brumeBMP.y);
	
			container.addChild(brumeBMP);
			container.addChild(brumeMask);
			brumeBMP.mask = brumeMask;
			addChild(container);
			container.addEventListener(Event.ENTER_FRAME, boucle);
		}
				// Animation
		private function boucle(e:Event):void
		{
			// Offset du perlin noise
			perlinOffset[0].x += 0.9;
			perlinOffset[1].y += 0.25;
			// Création d'un nouveau perlin noise
			brume.perlinNoise(brume.width/2, brume.height/2, 3, randomSeed, false, true, 0, true, perlinOffset);
		}
	}
}
