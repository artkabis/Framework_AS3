package fr.artkabis.utils
{
	import flash.display.Sprite;
	import flash.display.BitmapData;
 
	public class ResizeImage extends Sprite {
		
		private var widthMax:Number;
		private var heigthMax:Number;
		var scaleInitX
		var scaleInitY
 
		public static function resizeMe($img:BitmapData, $maxW:int, $maxH:int):void {
 
			widthMax   = $maxW;
			heigthMax  = $maxH;			
 
			scaleInitX = widthMax / ( $img.width / $img.scaleX );
			scaleInitY = heigthMax / ( $img.height / $img.scaleY );
 
			if(scaleInitX > 1){
				scaleInitX = 1
			}
			if(scaleInitY > 1){
				scaleInitY = 1
			}
			var rapport = $img.width / $img.height;
 
			if($img.height* scaleInitY > heigthMax){
				scaleInitY = heigthMax/$img.height;
			}
			if ($img.width * scaleInitX > widthMax){
				scaleInitX = widthMax/$img.width;
			}
 
			if(scaleInitX > scaleInitY){
				$img.scaleX = scaleInitY;
				$img.scaleY = scaleInitY;
			}else{
				$img.scaleX = scaleInitX;
				$img.scaleY = scaleInitX;
			}
		}
	}
}