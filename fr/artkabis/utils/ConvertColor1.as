package fr.artkabis.utils
{
	public class ConvertColor1
	{
		public function ConvertColor1(){}
		
		//convertie une couleur rgb en hex
		public static function rgb2hex(r:int, g:int, b:int):uint 
		{
			return(r<<16 | g<<8 | b);
		}
		//convertie une couleur hex en rgb
		public static function hex2rgb (hex:*):Object
		{
			var newHex:*;
			if(hex is String)
			{
				if(hex.substr(0,1)=='#'){newHex='0x'+hex.toString().split('#')[1];}
				else if(hex.substr(0,2)=='0x')newHex = '0x'+hex.toString().split('0x')[1];
				//trace('new Hex S : '+newHex);
			}
			else if (hex is Number)
			{
				newHex = hex;
				//trace('new Hex N : '+newHex);
			}
			var red = newHex>>16;
			var greenBlue = newHex-(red<<16)
			var green = greenBlue>>8;
			var blue = greenBlue - (green << 8);
			
			return({r:red, g:green, b:blue});
		}
		public static function dec2hex(dec:uint):String
		{
			var tmp:uint
			var hexa='0123456789ABCDEF',hex=''
			while (dec>15){
				tmp=dec-(Math.floor(dec/16))*16;
				hex=hexa.charAt(tmp)+hex;
				dec=Math.floor(dec/16);
			}
			hex=hexa.charAt(dec)+hex;
			return('#'+hex);
		}
	}
}