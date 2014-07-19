package fr.artkabis.carrousel
{
	import fr.artkabis.errors.ReturnError;
	import fr.artkabis.errors.ViewError;

	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.display.Stage;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	
	import flash.net.URLRequest;
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	
	public class Item extends MovieClip
	{
		private var urlCible:URLRequest;
		private var strCible:String;
		private var urlImage:URLRequest;
		private var chargeur:Loader;
		private var _balls:Balls = new Balls;;


		
		function Item( pName:String, pUrlImage:String, pUrlCible:String)
		{
			this.name = pName;
			strCible=pUrlCible;
			urlImage = new URLRequest( pUrlImage );
			urlCible = new URLRequest( strCible );
			
			chargeur = new Loader();
			chargeur.load( urlImage );
			chargeur.contentLoaderInfo.addEventListener( Event.COMPLETE, imageChargee );
			chargeur.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, chargement );
			chargeur.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, erreurChargement );
			
			//Interactivite
			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK, navigue);
		}
		private function navigue(p:MouseEvent):void
		{
			ModuleView.add(MovieClip(root), strCible );
		}
		private function chargement(pe:ProgressEvent):void{
			
			this.addChild(_balls);
		}
		private function imageChargee(p:Event):void
		{
			this.removeChild(_balls);
			this.addChild( chargeur );
			chargeur.x = - ( chargeur.width / 2 );
			chargeur.y = - ( chargeur.height );
		}
		private function erreurChargement(ie:IOErrorEvent):void{
			trace('Erreur : '+ie);
			var msg = ReturnError.extract(ie,true);
			ViewError.draw(Stage(root) ,msg);
		}
	}
}