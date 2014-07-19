package fr.chargement
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class XMLLoader extends EventDispatcher
	{
		private var _req:URLRequest;
		private var _xml:XML;
		private var _urlLoader:URLLoader;
		private var _dataLoader:URLLoader
		
		
		public function XMLLoader(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function load($fichier:String):void{
			_req = new URLRequest($fichier);
			_urlLoader = new URLLoader();
			_urlLoader.load(_req);
			_urlLoader.addEventListener(Event.COMPLETE,onXMLLoaded);
		}
		
		private function onXMLLoaded(evt:Event):void {
			_urlLoader.removeEventListener(Event.COMPLETE, onXMLLoaded);
			_dataLoader = evt.target as URLLoader;
			_xml = new XML(_dataLoader.data);
			dispatchEvent(new CustomEvent(CustomEvent.ONLOADED,_xml));
			_xml = null;
			_dataLoader = null;
			_urlLoader = null;
		}
	}
}