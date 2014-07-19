package fr.artkabis.mods
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.MovieClip;
	
	public class ModsNews extends MovieClip
	{
		private var _urlBigImg      :String;
		private var _urlLittleImg   :String;
		private var _texte          :String;
		//private var _balls          :Balls;
		private var _ldr            :Loader;
		private var params          :Object;
		
		public function ModsNews(params:Object):void
		{
			_urlBigImg     = params.urlBigImg;
			_urlLittleImg  = params.urlLittleImg;
			_texte         = params.content;
			
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void{
			_ldr = new Loader();
			_ldr.load(new URLRequest(_urlLittleImg));
			_ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, loadImgComplete)
			_ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadImgProgress);
			//_balls = new Balls;                     
		}
		
		private function loadImgProgress(pe:ProgressEvent):void{
			//addChild(_balls);
			//_balls.x = (MovieClip(root).stage.stageWidth*.5)-(_balls.width*.5);
			//_balls.y = (MovieClip(root).stage.stageHeight*.5)-(_balls.height*.5)
		}
		private function loadImgComplete(e:Event):void
		{
			trace('chargement miniature modsNew terminé');
			//removeChild(_balls);
			this.contImg.addChild( _ldr );
			this.contentTxt.text = _texte.toString();
			this.contImg.mouseChildren=false;
			this.contImg.buttonMode=true;
			this.contImg.addEventListener(MouseEvent.CLICK, createZoomApercu);
		}
		private function createZoomApercu(me:MouseEvent):void{
			ModuleView.add(MovieClip(root),_urlBigImg);
		}
	}
}