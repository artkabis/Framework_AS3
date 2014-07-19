package fr.artkabis.utils
{
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	public class AlphaB 
	{
		private static const _ALPHAB:Array = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
		private static const _NUMA:int=26;
		private static var i:int=0;
		public function AlphaB():void{}
		
		public function maj():String
		{
			var ret:String;
			while(i<_NUMA)
			{
				i++;
				ret =  _ALPHAB[i].toUpperCase()
			}
			return ret;
		}
		public function min():String
		{
			var ret:String;
			while(i<_NUMA)
			{
				i++;
				ret =  _ALPHAB[i].toLowerCase()
			}
			return ret;
		}
		public static function defilAlpha($l:String,$d:int):String
		{
			var ret:String;
			i++;
			ret = String(_ALPHAB[i]);
			
			if(i>=_NUMA)i=0;
			if(ret==$l)ret=$l;
			return ret;
		}
	}
}