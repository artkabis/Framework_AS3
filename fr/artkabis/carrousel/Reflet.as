package fr.artkabis.carrousel
{
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import flash.display.DisplayObject;
	
	public class Reflet extends MovieClip
	{
		private var urlImage:URLRequest;
		private var chargeur:Loader;
		private var _ratios:Array=[];
		private var _alphas:Array=[]
		
		function Reflet( $name:String , $urlImage:String, $alphas:Array, $ratios:Array )
		{
			this.name = $name;
			_alphas=$alphas;
			_ratios=$ratios;
			urlImage = new URLRequest($urlImage);
			
			chargeur = new Loader();
			chargeur.load( urlImage );
			chargeur.contentLoaderInfo.addEventListener(Event.COMPLETE, imageChargee);
		}
		private function imageChargee(e:Event):void
		{
			this.addChild(chargeur);
			var masque:Sprite = new Sprite();
			var type:String = GradientType.LINEAR;
			var couleurs:Array = [0xff0000, 0xff0000];
			var mat:Matrix = new Matrix();
			mat.createGradientBox(chargeur.width, chargeur.height, Math.PI/2);
			masque.graphics.beginGradientFill(type, couleurs, _alphas, _ratios, mat);
			masque.graphics.drawRect(0, 0, chargeur.width, chargeur.height);
			masque.graphics.endFill();
			this.addChild(masque);
			masque.cacheAsBitmap = chargeur.cacheAsBitmap = true;
			chargeur.mask = masque;
			chargeur.x = masque.x = -(chargeur.width/2);
			flipVertical(chargeur);
		}
		private function flipVertical($do:DisplayObject):void
		{
			$do.scaleY = -1;
			$do.y += $do.height;
		}
	}
}