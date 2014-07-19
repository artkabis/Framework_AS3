package  fr.artkabis.utils
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	* Dynamic reflection effect class
	* Created by Martin Christov: http://activeden.net/user/mWidgets/portfolio
	* Donated to Activetuts+ as a freebie: http://active.tutsplus.com/category/freebies/
	* Use it however you like!
	*/
	
	public class ReflectEffect extends Sprite {
		
		static var bmp:Bitmap;
		static var bmpd:BitmapData;
		static var bmpr:BitmapData;
		static var blurFilter:BlurFilter;
		private var $mc:DisplayObject;
		
		/**
		/* Initialise the Reflect Effect to reflect the specified DisplayObject
		/*
		/* @param mc The DisplayObject to be reflected
		**/
		
		public function ReflectEffect(mc:DisplayObject) {
			$mc=mc;
			//draw a bitmapdata of the display object being reflected
			bmpd=new BitmapData(mc.width,mc.height,true,0x00FFFFFF);
			bmpd.draw(mc);
		}
		
		/**
		* Returns a Bitmap display object that is a vertically-reflected version of the object
		* that was passed to the constructor when ReflectEffect was initialised.
		*
		* @param length "Height" of the reflective surface
		* @param fadelength E.g. if you put 40 for length and 30 for fade, the reflection will end 10px behind the actual reflection.
		* @param objpos This basically moves your reflection up/down (or left/right) inside the Bitmap output.
		* @param blur Blurring of the reflection
		* @param alpha Alpha transparency of the reflection
		*/
		public function down(length:Number=40, fadelength=null, objpos=null, blur:Number=5, alpha:Number=0.7):Bitmap{
			if(fadelength==null)fadelength=length;
			blurFilter=new BlurFilter(blur,blur);
			var fadeperpx=255/fadelength;//what is the fade value per pixel
			var alph=255, tc:String, uc:int, i:int, j:int;
			if(objpos==null)objpos=$mc.height-length;//the position from which the reflection starts.
			else objpos-=length;
			//draw a new bitmapdata with the size of the reflection
			bmpr=new BitmapData($mc.width,length,true,0x00FFFFFF);
			//the loop for copying pixels from original bitmapdata and the new one
			for(i=1;i<length;i++){
				if(fadelength+i>=length)alph-=fadeperpx;//calculate the alpha
				for(j=1;j<$mc.width;j++){
					//set the alpha. first get the pixel, then subtract from its potential alpha
					tc=bmpd.getPixel32(j,length-i+objpos).toString(16);
					tc=tc.substr(0,2);
					uc=int("0x"+tc);
					uc*=(alph/255);if(uc<0)uc=0;
					bmpr.setPixel32(j,i, (uc<<24)|bmpd.getPixel(j,length-i+objpos));
				}
			}
			bmp=new Bitmap(bmpr);
			//set default x,y positions, alpha & blur
			bmp.x=$mc.x;bmp.y=$mc.y+$mc.height;
			bmp.filters=[blurFilter];
			bmp.alpha=alpha;
			return bmp;
			// same logic applied to the rest three
		}
		
		/**
		* Returns a Bitmap display object that is a vertically-reflected version of the object
		* that was passed to the constructor when ReflectEffect was initialised.
		*
		* @param length "Height" of the reflective surface
		* @param fadelength E.g. if you put 40 for length and 30 for fade, the reflection will end 10px behind the actual reflection.
		* @param objpos This basically moves your reflection up/down (or left/right) inside the Bitmap output.
		* @param blur Blurring of the reflection
		* @param alpha Alpha transparency of the reflection
		*/
		public function up(length:Number=40, fadelength=null, objpos=null, blur:Number=5, alpha:Number=0.7):Bitmap{
			if(fadelength==null)fadelength=length;
			blurFilter=new BlurFilter(blur,blur);
			var fadeperpx=255/fadelength;
			var alph=0;var tc:String; var uc:int, i:int, j:int;
			if(objpos==null)objpos=0;
			//else objpos-=length;
			bmpr=new BitmapData($mc.width,length,true,0x00FFFFFF);
			for(i=1;i<length;i++){
				if(fadelength+i>=length)alph+=fadeperpx;
				for(j=1;j<$mc.width;j++){
					tc=bmpd.getPixel32(j,length-i+objpos).toString(16);
					tc=tc.substr(0,2);
					uc=int("0x"+tc);
					uc*=(alph/255);if(uc<0)uc=0;
					bmpr.setPixel32(j,i, (uc<<24)|bmpd.getPixel(j,length-i+objpos));
				}
			}
			bmp=new Bitmap(bmpr);
			bmp.x=$mc.x;bmp.y=$mc.y-length;
			bmp.filters=[blurFilter];
			bmp.alpha=alpha;
			return bmp;
		}
		
		/**
		* Returns a Bitmap display object that is a horizontally-reflected version of the object
		* that was passed to the constructor when ReflectEffect was initialised.
		*
		* @param length "Height" of the reflective surface
		* @param fadelength E.g. if you put 40 for length and 30 for fade, the reflection will end 10px behind the actual reflection.
		* @param objpos This basically moves your reflection up/down (or left/right) inside the Bitmap output.
		* @param blur Blurring of the reflection
		* @param alpha Alpha transparency of the reflection
		*/
		public function right(length:Number=40, fadelength=null, objpos=null, blur:Number=5, alpha:Number=0.7):Bitmap{
			if(fadelength==null)fadelength=length;
			blurFilter=new BlurFilter(blur,blur);
			var fadeperpx=255/fadelength;
			var alph=0;var tc:String; var uc:int, i:int, j:int;
			alph=255;
			if(objpos==null)objpos=$mc.width-length;
			else objpos-=length;
			bmpr=new BitmapData(length,$mc.height,true,0x00FFFFFF);
			for(i=1;i<length;i++){
				if(fadelength+i>=length)alph-=fadeperpx;
				for(j=1;j<$mc.height;j++){
					tc=bmpd.getPixel32(length-i+objpos,j).toString(16);
					tc=tc.substr(0,2);
					uc=int("0x"+tc);
					uc*=(alph/255);if(uc<0)uc=0;
					bmpr.setPixel32(i,j, (uc<<24)|bmpd.getPixel(length-i+objpos,j));
				}
			}
			bmp=new Bitmap(bmpr);
			bmp.x=$mc.x+$mc.width;bmp.y=$mc.y;
			bmp.filters=[blurFilter];
			bmp.alpha=alpha;
			return bmp;
		}
		
		/**
		* Returns a Bitmap display object that is a horizontally-reflected version of the object
		* that was passed to the constructor when ReflectEffect was initialised.
		*
		* @param length "Height" of the reflective surface
		* @param fadelength E.g. if you put 40 for length and 30 for fade, the reflection will end 10px behind the actual reflection.
		* @param objpos This basically moves your reflection up/down (or left/right) inside the Bitmap output.
		* @param blur Blurring of the reflection
		* @param alpha Alpha transparency of the reflection
		*/
		public function left(length:Number=40, fadelength=null, objpos=null, blur:Number=5, alpha:Number=0.7):Bitmap{
			if(fadelength==null)fadelength=length;
			blurFilter=new BlurFilter(blur,blur);
			var fadeperpx=255/fadelength;
			var alph=0;var tc:String; var uc:int, i:int, j:int;
			if(objpos==null)objpos=0;
			bmpr=new BitmapData(length,$mc.height,true,0x00FFFFFF);
			for(i=1;i<length;i++){
				if(fadelength+i>=length)alph+=fadeperpx;
				for(j=1;j<$mc.height;j++){
					tc=bmpd.getPixel32(length-i+objpos,j).toString(16);
					tc=tc.substr(0,2);
					uc=int("0x"+tc);
					uc*=(alph/255);if(uc<0)uc=0;
					bmpr.setPixel32(i,j, (uc<<24)|bmpd.getPixel(length-i+objpos,j));
				}
			}
			bmp=new Bitmap(bmpr);
			bmp.x=$mc.x-length;bmp.y=$mc.y;
			bmp.filters=[blurFilter];
			bmp.alpha=alpha;
			return bmp;
		}
		
		
	}
	
}