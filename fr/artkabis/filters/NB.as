package fr.artkabis.filters
{
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.display.Bitmap;

	public class NB extends Sprite
	{
		private var rLum:Number;
		private var gLum:Number;
		private var bLum:Number;
		private var nbMatrice:Array;
		public var cmf:ColorMatrixFilter;
		public var cmf2:ColorMatrixFilter;
		public var cmf3:ColorMatrixFilter;
	
		public function NB()
		{
			rLum = 0.2300;
			gLum = 0.7100;
			bLum = 0.0600;
			nbMatrice = new Array(rLum, gLum, bLum, 0, 0,
								 rLum, gLum, bLum, 0, 0,
								 rLum, gLum, bLum, 0, 0,
								 0, 0, 0, 1, 0);
			var r,g,b:Number;
			r=0;
			g=0;
			b=0;
			var mat:Array=[		 r, g, b, 0, 0,
								 r, g, b, 0, 0,
								 r, g, b, 0, 0,
								 0, 0, 2,.2,.2
						  ]
			var rien:Array=[ 1, 0, 0, 0, 0,
							 0, 1, 0, 0, 0,
							 0, 0, 1, 0, 0,
							 0, 0, 0, 1, 0
						 ]
			cmf = new ColorMatrixFilter(nbMatrice);
			cmf2 = new ColorMatrixFilter(mat);
			cmf3 = new ColorMatrixFilter(rien);
		}
		public function coloriz(){
			rLum = 0.2300;
			gLum = 0.7100;
			bLum = 0.0600;
			nbMatrice = new Array(rLum, gLum, bLum, 0, 0,
								 rLum, gLum, bLum, 0, 0,
								 rLum, gLum, bLum, 0, 0,
								 0, 0, 0, 1, 0);
			cmf = new ColorMatrixFilter(nbMatrice);
		}
		public function decoloriz()
		
		{
			rLum = 0.0000;
			gLum = 0.0000;
			bLum = 0.0000;
			nbMatrice = new Array(rLum, gLum, bLum, 0, 0,
								 rLum, gLum, bLum, 0, 0,
								 rLum, gLum, bLum, 0, 0,
								 0, 0, 0, 0, 0);
			cmf = new ColorMatrixFilter(nbMatrice);
		}
	}
}