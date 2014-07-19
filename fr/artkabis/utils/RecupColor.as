package fr.artkabis.utils
{

	 import flash.geom.Matrix; 
	 import flash.geom.Rectangle; 
	 import flash.geom.ColorTransform; 
	 
	 import flash.display.Sprite;
	 import flash.display.BitmapData; 
	 import flash.display.DisplayObject;
	 
	 import flash.utils.ByteArray
	 
	 public class RecupColor extends Sprite
	 {
		private static var _cible:*;
	  
		public static function RecupeColor($cible:DisplayObject)
		{
			_cible = $cible;
			returnColor(_cible);
		}
		public static function moyenne( image:BitmapData ):uint
		{
			var i:int     = 0;
			var c:uint    = 0;
			var a:uint    = 0;
			var r:uint    = 0;
			var g:uint    = 0;
			var b:uint    = 0; 
			var color:int = 0;
			
			var bArray:ByteArray = image.getPixels( image.rect );
			while (i < bArray.length)
			{
				a += bArray[ i + 0 ];
				r += bArray[ i + 1 ];
				g += bArray[ i + 2 ];
				b += bArray[ i + 3 ];
				i += 4 
			}
			
			//recomposition de la couleur
			var div:Number =  1 / ( image.width * image.height );
			a = ( a * div )<< 24; 
			r = ( r * div )<< 16;
			g = ( g * div )<< 8; 
			b =   b * div;
			
			color = a | r | g | b ;
			return  ( color );
			
		}
		public static function returnColor( cont:DisplayObject) : String
		{
			var W:int = cont.width;
			var H:int = cont.height;		
			var bmpd:BitmapData = new BitmapData( W, H );
			bmpd.draw( cont );
			var colorM:uint = moyenne( bmpd );
			var colorT:String;
			colorT = colorM.toString(16);
			colorT = colorT.substr( 2 );
			return  colorT;
		}
	}
}	