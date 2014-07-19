/**
 * usage:	RessourceMonitor.start(sp,obj);
 *
 * 			obj is optional and can holds following values:
 * 			- ram		: true/false
 * 			- plugin	: true/false
 * 			- instCnt	: Any display Object to get the numChildren
 * 			- x
 *  		- y
 *  		- textColor
 *  		- bgColor
 *
 *			RessourceMonitor.remove();
 */
package fr.artkabis.utils 
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.system.System;
	import flash.text.*;
	import flash.utils.*;
	import flash.system.Capabilities;
 
	public class MemoryInfo extends Sprite
	{
		static private var singleton		:MemoryInfo;
		private var _fpsSprite				:Sprite;
		private var _fpsText				:TextField;
		private var _time					:Number;
		private var _signal					:Boolean;
		private var _tempo					:Number;
		private var _sp						:Sprite;
		/*
		 * Default parameter values
		 */
		private var _ram			:Boolean	= true;
		private var _plugin			:Boolean	= false;
		private var _instCnt		:*;
		private var _x				:Number		= 10;
		private var _y				:Number		= 10;
		private var _textColor		:Number		= 0x000000;
		private var _bgColor		:Number		= 0xffffff;
		private var _back			:Boolean	= true;
 
		public function MemoryInfo(singleton:SingeltonEnforcer) {init();}
 
		public function init():void { _signal = true; }
		/**
		 * 	Start
		 */
		static public function start(sp:Sprite, obj:Object = ""):void 
		{
			MemoryInfo.getInstance()._start(sp, obj);
		}
		private function _start(sp:Sprite, obj:Object):void 
		{
			for (var key:String in obj) {
				if (key == "x") { _x 			= Number(obj[key]); }
				if (key == "y") { _y 			= Number(obj[key]); }
				if (key == "textColor") { _textColor 	= Number(obj[key]); }
				if (key == "bgColor") {
					_back 				= obj[key];
					_bgColor 			= Number(obj[key]);
				}
				if (key == "ram") { _ram 		= Boolean(obj.ram) }
				if (key == "plugin") { _plugin 		= Boolean(obj.ram) }
				if (key == "instCnt") { _instCnt 	= obj[key]; }
			}
			_sp 						= sp;
			_fpsSprite 					= new Sprite();
			_fpsSprite.x 				= _x;
			_fpsSprite.y 				= _y;
			_fpsSprite.name             = '_fpsSprite';

			_fpsText 					= new TextField();
			_fpsText.autoSize 			= TextFieldAutoSize.LEFT;
			_fpsText.textColor 			= _textColor;
			_fpsText.background 		= _back;
			_fpsText.backgroundColor 	= _bgColor;
 
			_fpsSprite.addChild(_fpsText);
			_sp.addChild(_fpsSprite);
			trace('fpsSprite.width::'+_sp.getChildByName('_fpsSprite').width)
			setTimeout(function(){trace(_fpsSprite.width)},50)
 			if (_fpsSprite.x > 1) {  _fpsSprite.x -= (_sp.width/2)-25;}
 			if (_fpsSprite.y > 1) {  _fpsSprite.y -= (_sp.height/2)+5;}
			trace(_fpsSprite.x,_fpsSprite.y);
			_fpsSprite.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
 
		private function enterFrameHandler(evt:Event):void 
		{
			(_signal == true) ? _time = getTimer() : _tempo = Math.ceil(1000/(getTimer()-_time));
			_signal = !_signal;
			_fpsText.text = "";
			_fpsText.appendText("Fps: " 		+ _tempo);
			
			if (_ram) { 	_fpsText.appendText(" Ram: "		+ Math.round(System.totalMemory / (1024 * 1024)) + " MB"); }
			if (_plugin) { 	_fpsText.appendText(" Plugin: "		+ Capabilities.version); }
			if (_instCnt) { _fpsText.appendText(" Instances: "	+ (_instCnt as Sprite).numChildren); }
		}
		/**
		 * 	remove
		 */
		static public function remove():void {
			MemoryInfo.getInstance()._remove();
		}
		private function _remove():void {
			_sp.removeChild(_fpsSprite);
		}
		/**
		 * 	Singelton
		 */
		static private function getInstance():MemoryInfo {
			if (MemoryInfo.singleton == null) {MemoryInfo.singleton= new MemoryInfo(new SingeltonEnforcer());}
			return MemoryInfo.singleton;
		}
	}
}
class SingeltonEnforcer{}