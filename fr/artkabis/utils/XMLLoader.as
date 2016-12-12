﻿/**
* @author Clemente Gomez.
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
package com.clementegomez.utils

	import com.clementegomez.utils.LoaderHelper;






	public class XMLLoader extends EventDispatcher

		private var _names : Array;


		private var counter : uint;

		private var _cacheBuster : Boolean;

		private var loaded : Number;
		private var total : Number;
		private var progressEvent : ProgressEvent;

		private var url : Array;


		/**
		 * <code>XMLLoader</code> allows the loading process and management of multiple <code>XML</code> files.
		 *
 
		 * @param $cache Set to true to use a <code>cacheBuster</code>



		 *
 

 
		 * package
 
		 *		import com.clementegomez.utils.XMLLoader;
		 *		import flash.display.*;

		 *
		
		 *		{
		 *			public var xl:XMLLoader;


 
		 *			{
		 *				xl = new XMLLoader();

		 *				xl.addEventListener(Event.COMPLETE, loaded);
		 *				xl.addEventListener(ProgressEvent.PROGRESS, loading);
		 *
	

		 *			
		 *			private function loaded(e:Event):void
		 *			{
		 *				trace(e.target.data["xml1"]);
		 *			}
		 *
	
		 *			{
		 *				trace(e.target.ratioLoaded);
		 *			}
		 *		}

		 * </listing>
		 */
		public function XMLLoader($url : Array = null, $cache : Boolean = false, $names : Array = null, $skipError : Boolean = true)

			init($url, $cache, $names, $skipError);
		}

		private function init($url : Array, $cache : Boolean, $names : Array, $skipError : Boolean) : void

		{
			_data = new Array();
			_names = new Array();
			counter = 0;
			_cacheBuster = $cache;

			isLoading = false;
			progressEvent = new ProgressEvent(ProgressEvent.PROGRESS);
			($names != null) ? _names = $names : _names = null;

			{
				url = $url;
				urlLength = url.length;

				isLoading = true;


		}

		private function startLoading($addresses : Array, $skipError : Boolean = true, $loopPosition : Number = 0) : void
		{
			var urls : Array = $addresses;
			var request : URLRequest;


			var i : uint;
			($skipError) ? i = $loopPosition : i = 0;
			for(i;i < urls.length; i++)
			{
				position = i;


					request = new URLRequest($addresses[String(i)]);
				}
				else
				{
					request = new URLRequest($addresses[String(i)] + "?" + new Date().getTime());
				}

				loaderHelp = new LoaderHelper(loader, position);
				loaderHelp.addEventListener(ParamEvent.PARAM, placeXML);
				loaderHelp.addEventListener(ParamEvent.PERCENT, showProgress);
				loaderHelp.addEventListener(ParamEvent.ERROR, onError);


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

		private function makeName($value:String):String
		{

		var pattern:RegExp = /([\da-z0-9_]){1,}\./ig;
		var firstString:String = new String($value.match(pattern)[0]);
		firstString = firstString.substr(0, firstString.length - 1);
		name = $value.replace($value, firstString)
		return name;

 		*/
		private function placeXML(e : ParamEvent) : void
		{
			var _xml : XML = new XML(e.target.getLoader.data);

			if(_names != null)

				_data[_names[e.parameter]] = _data[e.parameter] = _xml;

			else
			{
				_data[e.parameter] = _xml;
			}

			{
							_currentItem = urlLength;
							dispatchEvent(new Event(Event.COMPLETE));
			}
			else
			{
				_currentItem = counter;
			}
		}

		private function onError(e : ParamEvent) : void


				trace("XML file " + "'" + url[e.parameter] + "'" + " could not be loaded and skipped");
				if(e.parameter != urlLength - 1)
				{
					startLoading(url, skipError, e.parameter + 1);
				}


					url.pop();




			{
				throw new Error("Loading Failed at " + "'" + url[e.parameter] + "'");
			}


		/**
		 * Starts the loading process if you don't pass anything using the Constructor function.
		 *
 


		 * @return null


		{
			if (isLoading)


			}
			else
			{

				url = $url;
				urlLength = url.length;

				isLoading = true;
			}


		/**
		 * Returns the <code>Array</code> which holds all the XML files.

 

		public function get data() : Array
		{

		}

		/**
		 * Returns the <code>Array</code> which holds all the XML files names.
		 *
 
		 */
		public function get names() : Array

		{

			return _names;
 
		}

		/**
		 * The <code>cacheBuster</code> property allows an XML file to be loaded in fresh if it happens to be cached on the client's
		 * system. Note that when testing locally, it is best to set <code>cacheBuster</code> to false as the urls will not be
		 * found on some sytems.

 
		 * @default false
		 */
		public function set cacheBuster($value : Boolean) : void
		{

		}

		/**


		public function get cacheBuster() : Boolean

			return _cacheBuster;
		}

		/**
		 * <code>skipErrors</code> allows the loading process to continue if there is a dead link or misspelled url in the
		 * <code>Array</code> of <code>XML</code>files.

 

		 */


			skipError = $value;
		}

		/**
		 * @private

		public function get skipErrors() : Boolean
		{

		}

		/**
		 * Returns the amount of loaded bytes of the <code>XML</code> files


		 */
		public function get bytesLoaded() : Number
		{

		}

		/**
		 * Returns the amount of total bytes of the <code>XML</code> files

 
		 */

		{
			return total;


		/**
		 * Returns the total amount of <code>XML</code> files
		 * 

		 */
		public function get totalItems() : Number

		{

			return urlLength;

		}

		/**
		 * Returns the current number of loaded <code>XML</code> files
		 * 

		 */
		public function get currentItem() : Number

		{

			return _currentItem;

		}

		/**
		 * Returns a ratio of loaded <code>XML</code> files
 
 



		{
			var value : Number;


			return value;

		}

}