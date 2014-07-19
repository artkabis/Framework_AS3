/**
* @author Clemente Gomez. * @email zomegpro@gmail.com. 
* @link http://blog.kreativeking.com. 
* @build 3.0 (04-13-09) 
* @description Quickly load and manage Multiple XML files. 
*
* @public properies:  
* 					data:Array 
* 					names:Array 
* 					cacheBuster:Boolean 
* 					skipErrors:Boolean 
* 					bytesLoaded:Number 
* 					bytesTotal:Number 
* 					totalItems:Number 
* 					currentItem:Number 
* 					ratioLoaded:Number 
*
* @public methods:  
* 					XMLLoader($url:Array, $cache:Boolean, $names:Array, $skipErrors:Boolean) - Constructor. 
* 					loadXML($url:Array, $names:Array) - Loads the XML files. 
*/
package com.clementegomez.utils{
	import com.clementegomez.events.ParamEvent;
	import com.clementegomez.utils.LoaderHelper;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class XMLLoader extends EventDispatcher	{
		private var _data : Array;
		private var _names : Array;
		private var position : uint;
		private var urlLength : uint;
		private var counter : uint;
		private var _currentItem : Number;
		private var _cacheBuster : Boolean;
		private var isLoading : Boolean;
		private var loaded : Number;
		private var total : Number;
		private var progressEvent : ProgressEvent;
		private var skipError : Boolean;
		private var url : Array;


		/**
		 * <code>XMLLoader</code> allows the loading process and management of multiple <code>XML</code> files.		 
		 *
 		 * @param $url <code>XML</code> Files you want to loaded
		 * @param $cache Set to true to use a <code>cacheBuster</code>
		 * @param $names Name to use to reference the loaded <code>XML</code> Files
		 * @param $skipError Skip errors if <code>XML</code> urls are incorrect
		 * @return null
		 *
 		 * @example This example demostrates the use of the <code>XMLLoader</code> Class.
		 *
 		 * <listing version="3.0">
		 * package
 		 * {
		 *		import com.clementegomez.utils.XMLLoader;
		 *		import flash.display.*;
		 *		import flash.events.*;
		 *
		 *		public class XMLDoc extends MovieClip
		 *		{
		 *			public var xl:XMLLoader;
		 *			public var array:Array;
		 *
 		 *			public function XMLDoc()
		 *			{
		 *				xl = new XMLLoader();
		 *				array = new Array();
		 *				xl.addEventListener(Event.COMPLETE, loaded);
		 *				xl.addEventListener(ProgressEvent.PROGRESS, loading);
		 *
		 *				xl.loadXML(["http://flashden.net/feeds/user_item_comments/cg219.atom", "http://feeds2.feedburner.com/kreativeking?format=xml"], ["xml1", "xml2"], false);
		 *			}
		 *			
		 *			private function loaded(e:Event):void
		 *			{
		 *				trace(e.target.data["xml1"]);
		 *			}
		 *
		 *			private function loading(e:ProgressEvent):void
		 *			{
		 *				trace(e.target.ratioLoaded);
		 *			}
		 *		}
		 *	}
		 * </listing>
		 */
		public function XMLLoader($url : Array = null, $cache : Boolean = false, $names : Array = null, $skipError : Boolean = true)
		{
			init($url, $cache, $names, $skipError);	
		}

		private function init($url : Array, $cache : Boolean, $names : Array, $skipError : Boolean) : void

		{
			_data = new Array();
			_names = new Array();
			counter = 0;
			_cacheBuster = $cache;
			skipError = $skipError;
			isLoading = false;
			progressEvent = new ProgressEvent(ProgressEvent.PROGRESS);
			($names != null) ? _names = $names : _names = null;
			if($url != null)
			{
				url = $url;
				urlLength = url.length;
				startLoading(url, skipError);
				isLoading = true;
			}

		}

		private function startLoading($addresses : Array, $skipError : Boolean = true, $loopPosition : Number = 0) : void
		{
			var urls : Array = $addresses;
			var request : URLRequest;
			var loader : URLLoader;
			var loaderHelp : LoaderHelper;
			var i : uint;
			($skipError) ? i = $loopPosition : i = 0;
			for(i;i < urls.length; i++)
			{
				position = i;
				if(!_cacheBuster)
				{
					request = new URLRequest($addresses[String(i)]);
				}
				else
				{
					request = new URLRequest($addresses[String(i)] + "?" + new Date().getTime());
				}
				loader = new URLLoader();
				loaderHelp = new LoaderHelper(loader, position);
				loaderHelp.addEventListener(ParamEvent.PARAM, placeXML);
				loaderHelp.addEventListener(ParamEvent.PERCENT, showProgress);
				loaderHelp.addEventListener(ParamEvent.ERROR, onError);
				loader.load(request);
			}
		}

		private function showProgress(e : ParamEvent) : void

		{

			loaded = ((e.target as LoaderHelper).progress as ProgressEvent).bytesLoaded;
			total = ((e.target as LoaderHelper).progress as ProgressEvent).bytesTotal;
			progressEvent.bytesLoaded = loaded;
			progressEvent.bytesTotal = total;
			dispatchEvent(progressEvent);

		}

		// Depricated Function
		/*
		private function makeName($value:String):String
		{
		var name:String;
		var pattern:RegExp = /([\da-z0-9_]){1,}\./ig;
		var firstString:String = new String($value.match(pattern)[0]);
		firstString = firstString.substr(0, firstString.length - 1);
		name = $value.replace($value, firstString)
		return name;
		}
 		*/
		private function placeXML(e : ParamEvent) : void
		{
			var _xml : XML = new XML(e.target.getLoader.data);
			counter++;
			if(_names != null)
			{
				_data[_names[e.parameter]] = _data[e.parameter] = _xml;
			}
			else
			{
				_data[e.parameter] = _xml;
			}			if(urlLength == counter)

			{				isLoading = false;
							_currentItem = urlLength;
							dispatchEvent(new Event(Event.COMPLETE));
			}
			else
			{
				_currentItem = counter;
			}
		}

		private function onError(e : ParamEvent) : void
		{			if(skipError)
			{
				trace("XML file " + "'" + url[e.parameter] + "'" + " could not be loaded and skipped");
				if(e.parameter != urlLength - 1)
				{
					startLoading(url, skipError, e.parameter + 1);
				}
				else
				{
					url.pop();
					startLoading(url, skipError);
				}
			}
			else
			{
				throw new Error("Loading Failed at " + "'" + url[e.parameter] + "'");
			}
		}

		/**
		 * Starts the loading process if you don't pass anything using the Constructor function.
		 *
 		 * @param $url XML Files you want to loaded
		 * @param $names Name to use to reference the loaded XML Files
		 * @param $skipError Skip errors if <code>XML</code> urls are incorrect
		 * @return null
		 */
		public function loadXML($url : Array, $names : Array = null) : void
		{
			if (isLoading)
			{
				throw new Error("Can't have two simultaneous loading functions running");
			}
			else
			{
				($names != null) ? _names = $names : _names = null;
				url = $url;
				urlLength = url.length;
				startLoading(url, skipError);
				isLoading = true;
			}
		}

		/**
		 * Returns the <code>Array</code> which holds all the XML files.
		 *
 		 * @return <code>Array</code>
		 */
		public function get data() : Array
		{
			return _data;
		}

		/**
		 * Returns the <code>Array</code> which holds all the XML files names.
		 *
 		 * @return <code>Array</code>
		 */
		public function get names() : Array

		{

			return _names;
 
		}

		/**
		 * The <code>cacheBuster</code> property allows an XML file to be loaded in fresh if it happens to be cached on the client's
		 * system. Note that when testing locally, it is best to set <code>cacheBuster</code> to false as the urls will not be
		 * found on some sytems.
		 *
 		 * @param $value <code>Boolean</code>
		 * @default false
		 */
		public function set cacheBuster($value : Boolean) : void
		{
			_cacheBuster = $value;
		}

		/**
		 * @private
		 */
		public function get cacheBuster() : Boolean
		{
			return _cacheBuster;
		}

		/**
		 * <code>skipErrors</code> allows the loading process to continue if there is a dead link or misspelled url in the
		 * <code>Array</code> of <code>XML</code>files.
		 *
 		 * @param $value <code>Boolean</code>
		 * @default true;
		 */
		public function set skipErrors($value : Boolean) : void
		{
			skipError = $value;
		}

		/**
		 * @private
		 */
		public function get skipErrors() : Boolean
		{
			return skipError;
		}

		/**
		 * Returns the amount of loaded bytes of the <code>XML</code> files
		 * 
		 * @return Number
		 */
		public function get bytesLoaded() : Number
		{
			return loaded;
		}

		/**
		 * Returns the amount of total bytes of the <code>XML</code> files
		 *
 		 * @return Number
		 */
		public function get bytesTotal() : Number
		{
			return total;
		}

		/**
		 * Returns the total amount of <code>XML</code> files
		 * 
		 * @return Number
		 */
		public function get totalItems() : Number

		{

			return urlLength;

		}

		/**
		 * Returns the current number of loaded <code>XML</code> files
		 * 
		 * @return Number
		 */
		public function get currentItem() : Number

		{

			return _currentItem;

		}

		/**
		 * Returns a ratio of loaded <code>XML</code> files
 		 *
 		 * @return Number
		 */
		public function get ratioLoaded() : Number

		{
			var value : Number;
			((currentItem / urlLength) >= 0 || (currentItem / urlLength) <= 0) ? value = currentItem / urlLength : value = 0;

			return value;

		}
	}
}