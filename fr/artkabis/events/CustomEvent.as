/**
 * @author Clemente Gomez.
 * @email zomegpro@gmail.com.
 * @link http://blog.kreativeking.com.
 * @build 1.7 (04-13-09)
 * @description Paramerter Event allows the passing of extra parameters
 * 
 * @public methods: 
 * 					CustomEvent(type:String, param:* = null, bubbles:Boolean = false, cancelable:Boolean = false) - Constructor.
 */

package fr.artkabis.events
{
	import flash.events.Event;

	public class CustomEvent extends Event
	{
		/**
		 * The CustomEvent.PARAM constant defines the value of the type property of an param CustomEvent object.
		 */
		public static const PARAM : String = "param";
		/**
		 * The CustomEvent.PERCENT constant defines the value of the type property of an percent CustomEvent object.
		 */
		public static const PERCENT : String = "percent";
		/**
		 * The CustomEvent.COMPLETE constant defines the value of the type property of an complete CustomEvent object.
		 */
		public static const COMPLETE : String = "finished";
		/**
		 * The CustomEvent.READY constant defines the value of the type property of an ready CustomEvent object.
		 */
		public static const READY : String = "ready";
		/**
		 * The CustomEvent.XML_LOADED constant defines the value of the type property of an xml loaded CustomEvent object.
		 */
		public static const XML_LOADED : String = "xml loaded";
		/**
		 * The CustomEvent.INITIALIZED constant defines the value of the type property of an initialized CustomEvent object.
		 */
		public static const INITIALIZED : String = "initialized";
		/**
		 * The CustomEvent.ERROR constant defines the value of the type property of an error CustomEvent object.
		 */
		public static const ERROR : String = "error";
		/**
		 * The CustomEvent.ONLOADED constant defines the value of the type property of an complete load CustomEvent object.
		 */
		public static const ONLOADED:String = "OnLoaded";
		/**
		 * The CustomEvent.END_SCRIPT constant defines the value of the type property of an end script CustomEvent object.
		 */
		public static const END_SCRIPT:String = 'end_script';

		
		private var _param : *;

		public function CustomEvent(type : String, param : * = null, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			_param = param;
		}

		public override function clone() : Event
		{
			return new CustomEvent(type, _param, bubbles, cancelable);
		}

		public function get parameter() : *
		{
			return _param;
		}
		public override  function toString():String 
		{
			return formatToString("CustomEvent","type","bubbles","cancelable","eventPhase");
		}
	}
}