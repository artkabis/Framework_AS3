package fr.artkabis.chargement
{
	import flash.events.Event;

	public class CustomEvent extends Event
	{
		public var data:*;
		
		public static const ONLOADED:String = "OnLoaded";
		
		public function CustomEvent(type:String, data:*)
		{
			this.data = data;
			super( type );
		}
	}
}