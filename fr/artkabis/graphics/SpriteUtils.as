package fr.artkabis.graphics
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	public class SpriteUtils
	{
		//public function SpriteUtils(){}
		static public function snapClip ( clip:DisplayObject ):Bitmap
		{
			var bounds:Rectangle = clip.getBounds( clip.root );
			// --
			var m:Matrix;
			m = clip.transform.matrix.clone();
			m.tx -= bounds.x;
			m.ty -= bounds.y;
			// --
			var l_bitmapData:BitmapData = new BitmapData( int( bounds.width + 0.5 ), int( bounds.height + 0.5 ), true, 0x0 );
			l_bitmapData.draw ( clip, m, clip.transform.concatenatedColorTransform, null, null, true );
			// --
			m = null;
			bounds = null;
			// --
			var result:Bitmap = new Bitmap( l_bitmapData );
			result.pixelSnapping = PixelSnapping.NEVER;
			result.smoothing = true;
			bounds = clip.transform.pixelBounds;
			result.x = bounds.x;
			result.y = bounds.y;
			result.blendMode = clip.blendMode;
			return result;
		}
 
		public static  function replace( clip:DisplayObject ):Sprite
		{
			var clipBit:Bitmap = snapClip( clip );
			// --
			var par:DisplayObjectContainer = clip.parent;
			var cont:Sprite = new Sprite();
			if( par )
			{
				var idClip:int = par.getChildIndex( clip );
				par.removeChild(clip);
				cont.addChild(clipBit);
				par.addChildAt( cont, idClip );
			}
			else
			{
				cont.addChild(clipBit);
			}
			return cont;
		}
 
	}
}