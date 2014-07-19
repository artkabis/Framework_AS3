package fr.artkabis.filters
{
	import fr.artkabis.filters.NB;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import flash.filters.ColorMatrixFilter;
 import com.flashdynamix.motion.*;
  import com.flashdynamix.motion.easing.*
 import com.flashdynamix.motion.extras.ColorMatrix;
 

	
	public class ColorNB extends MovieClip
	{
		private const _couleur:uint = 0x65FF00;
		private var _target:*;
		
		public function ColorNB($target)
		{
			stop();
			_target = $target;
			applik(_target);
		}		
		
		public function applik($target):void 
		{   
			var nb:NB =new NB();
			$target.addEventListener("mouseOver",overImage);
			$target.addEventListener("mouseOut",outImage);
			
			//var tween:TweensyGroup = new TweensyGroup();
			//tween.to(nb.cmf,nb.cmf2, 2,null,0, $target);
			//$target.filters = [nb.cmf];
			$target.filters = [];
			function overImage(e:MouseEvent):void{
				$target.filters = [nb.cmf];
			}
			function outImage(e:MouseEvent):void{
				$target.filters = [];
				//tween.to(nb.cmf,nb.cmf2,2, null,0, $target);
			}
		}
	}
}