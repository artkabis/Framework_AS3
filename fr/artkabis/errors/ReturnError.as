package fr.artkabis.errors
{
	import flash.events.IOErrorEvent;
	public class ReturnError
	
	{
		public static var _err             :*;
		public static var result           :String;
		private static const LOCAL  :String = 'file:///';
		private static const HTTP   :String  = 'http://';
		
		
		//=======================================================
		//                  GETTER_SETTER                      \\
		//=======================================================
		public function set error($er:*){_err = String($er);}
		public function get error():String{return _err;}
		//=======================================================
		//                     CONSTRCTOR                      \\
		//=======================================================
		public function ReturnError()
		{
		}
		
		//=======================================================
		//                 PUBLIC METHODE extract              \\
		//=======================================================
		public static function extract($err:* , $local:Boolean):String
		{
			_err = $err is IOErrorEvent ? String($err) : $err;
			
			if($local ||_err.substr(120,1) ==='f' ){
				result = _err.split('file:///')[1];result = result.split('"]')[0];
			}else {
				result = _err.split('http://')[1];result = result.split('"]')[0];
			}
			return result;
		}
	}
}