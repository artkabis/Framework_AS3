package fr.artkabis.utils
{
    import flash.net.SharedObject;
	
    public final class Cookie
    {
        private var _so:SharedObject;
        
        public function Cookie($titre:String)
        {
	    _so = SharedObject.getLocal($titre);
        }
        
        public function read($titreVar:String):String
		{
			if(_so.data[$titreVar]) return _so.data[$titreVar];
			return "";	
		}

        public function write($titreVar:String , $var:*):void
		{
			_so.data[$titreVar] = $var.toString();
			_so.flush();
		}
    }
}
