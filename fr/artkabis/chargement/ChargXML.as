package fr.chargement
{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	
	public class ChargXML extends URLLoader
	{
		private var _xml        :XML;
		private var _urlCharg   :URLLoader;
		private var _req        :URLRequest;
		private var _fichier    :String;

		public function ChargXML($fichier):void
		{
			_fichier = $fichier;
			chargerXML();
		}
		private function chargerXML():void
		{
			_urlCharg = new URLLoader();
			_req = new URLRequest( _fichier );
			_urlCharg.addEventListener( Event.COMPLETE , chargXmlComplet );
			_urlCharg.load( _req );
		}
		private function  chargXmlComplet (e:Event):void
		{
			_xml = new XML(e.target.data);
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		public function get getXML():XML
		{
			trace('xml de la classe ChargXML::::::::::::::::::::'+XML(_xml));
			return XML(_xml);
			
		}
	}
}