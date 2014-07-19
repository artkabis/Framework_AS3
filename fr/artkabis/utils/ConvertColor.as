package fr.artkabis.utils
{
	/**
	*La classe ConvertColor est utilisé pour trans-crypter des valeurs colorimétriques vers des valeurs numériques standards (hexadécimales,rgb,décimales).  	
	* <p>Il est possible de convertir une valeur decimale en hexadecimale,  une valeur decimale en RGB, une valeur hexadécimale en décimale, une valeur hexadécimal en RGB (red green blue), une valeur RGB en décimale et une valeur RGB en hexadécimale.</p>
	*
	*	@author			NICOLLE-Gregory - Artkabis
	*	@version		1.0
	*	@date			26.03.2010
	*	@langversion 	ActionScript 3.0
	* 	@playerversion 	Flash 10

	*	@tiptext
	*
	*	@example Dans cet exemple, vous pouvez la pallette complète de l'utilisation des méthodes de transtypage utilisables depuis ConvertColor, soit:
	*	<p><b> RGB>>Hexadecimale    RGB>>Decimale   Decimale>>RGB   Decimale>>Hexadecimale  Hexadecimale>>RGB   Hexadecimale>>Decimale    </b><p>
	* 
	*
	* <listing version="1.0">
	*	import fr.artkabis.utils.ConvertColor;
	*	
	*	var r,g,b:int;r=255;g=255;b=255;
	*	var d2rgb:Object=ConvertColor.dec2rgb  (16777215)
	*	var h2rgb:Object = ConvertColor.hex2rgb  ('#ffffff');
	*	
	*	trace("rgb2dec  : " + ConvertColor.rgb2dec  (r,g,b));
	*	trace("rgb2hex  : " + ConvertColor.rgb2hex  (r,g,b));
	*	trace("hex2rgb  : " + h2rgb.r, h2rgb.g, h2rgb.b);
	*	trace("dec2rgb  : " + d2rgb.r,d2rgb.g,d2rgb.b);
	*	trace("dec2hex  : " + ConvertColor.dec2hex  (16777215));
	*	trace("hex2dec  : " + ConvertColor.hex2dec  ("#FFFFFF"));	* 
	* </listing>
	*/
	public class ConvertColor
	{
		/**
		* Créer une occurrence de ConvertColor
		**/
		public function ConvertColor(){}
		
		/**
		* Convertie une valeur RGB en valeur decimale
		* @param $r	valeur rouge de type int
		* @param $g	valeur vert de type int
		* @param $b	valeur bleu de type int
		* @returns valeur décimale >> rgb2hdec(255,255,255) returns “16777215″
		**/
		public static function rgb2dec($r:int, $g:int, $b:int):String 
		{
			var dec = ($r<<16 | $g<<8 | $b)
			return dec;
		}
		
		/**
		* Convertie une valeur RGB en valeur hexadecimale
		* @param $r	valeur rouge de type int
		* @param $g	valeur vert de type int
		* @param $b	valeur bleu de type int
		* @returns valeur hexadecimale >> rgb2hex(255, 255, 255) returns “0xFFFFFF″
		**/
		public static function rgb2hex(r:int, g:int, b:int):String
		{
			var dec:uint = (r<<16 | g<<8 | b);
			var hex = dec2hex( dec );

			return hex;
		}
		
		/**
		* Convertie une valeur hexadecimale de base String en valeur RGB
		* @param $hex valeur hexdecimale:String à convertir en  rgb
		* @returns valeur rgb >> hex2rgb("0xF00F04") returns “240 15 4″.
		**/
		public static function  hex2rgb( $hex:String  ) : String  {
			var bytes:Array = [];
			while( $hex.length > 2 ) {
				var byte:String = $hex.substr( -2 );
				$hex = $hex.substr(0, $hex.length-2 );
				bytes.splice( 0, 0, int("0x"+byte) );
			}
			return bytes.join(" ");
		}
		
		/**
		*@private
		* Convertie une valeur hexadecimale en valeur RGB
		* @param $hex	Paramètre regroupant la valeur hexadecimale à convertir, cette valeur peut être de type String ("0xffffff") ou Number 0xffffff
		* @return Object { r:int,g:int,b:int } >> hex2rgb2(0xffffff) returns “255 255 255″
		**/
		private static function hex2rgb2 ($hex:*):Object
		{
			var newHex:* = formateHex($hex);
			var red = newHex>>16;
			var greenBlue = newHex-(red<<16)
			var green = greenBlue>>8;
			var blue = greenBlue - (green << 8);
			
			return({r:red, g:green, b:blue});
		}
		
		/**
		* Convertie une valeur decimale en valeur RGB
		* @param $dec	Paramètre regroupant la valeur decimale à convertir, cette valeur doit être de type  Number(uint,int), ex: 16777215
		* @return Object { r:int,g:int,b:int } >> hex2rgb2(16777215) returns “255 255 255″
		**/
		public static function dec2rgb ($dec:*):Object
		{
			(!$dec is Number)? uint($dec) : $dec;
			var hex = dec2hex($dec);
			var obj:Object=hex2rgb(hex);
			return obj;
		}

		
		/**
		* Convertie une valeur decimale en valeur hexadecimale
		* @param $dec valeur decimale à convertir en hexadecimale
		* @return valeur hexadecimale >> dec2hex(16777215) returns “0xFFFFFF″
		**/
		public static function dec2hex($dec:*):String
		{
			(!$dec is Number)?uint($dec) : $dec;
			var tmp:uint
			var hexa='0123456789ABCDEF',hex=''
			while ($dec > 15 ){
				tmp = $dec - ( Math.floor( $dec / 16 ) ) * 16 ;
				hex = hexa.charAt( tmp ) + hex ;
				$dec = Math.floor( $dec / 16 );
			}
			hex = hexa.charAt( $dec ) + hex ;
			return( '0x' + hex);
		}
		
		
		
		/**
		* Convertie une valeur hexadecimale de type Number ou String en valeur decimale
		* @param $hex valeur hexdecimale à convertir en decimale
		* @return valeur décimale >> hex2dec("0xF00F04") returns “240 15 4″.
		**/
		public static function hex2dec($hex:*):*
		{
			var c:Object = hex2rgb2($hex);
			var dec = rgb2dec(c.r,c.b,c.b);
			
			return dec;
		}
		
		
		/**
		* Outil de formatage hexadecimale, convertie #FFFFFF en 0xFFFFFF et permet de transtyper la valeur renvoyé (Number>>String || String>>Number)
		* @param $h valeur hexdecimale formater
		* @return valeur hexadécimale formaté >> formateHex("0xF00F04") returns “240 15 4″.
		**/
		private  static function formateHex($h:*="" , $modes:String="S"):*{
			
			var newHex:*;
			var _strg:String;
			var _uint:uint;
			
			/**
			* Mode String
			**/
			if($h is String && $modes=='S'){
				if($h.substr(0,1)=='#'){newHex='0x'+$h.toString().split('#')[1];}
				else if($h.substr(0,2)=='0x'){newHex = '0x'+$h.toString().split('0x')[1];}
			}else if($h is String && $modes=='N'){
				if($h.substr(0,1)=='#'){_uint = uint('0x'+$h.toString().split('#')[1]);trace("convert hex String2Number :"+_uint);}
				else if($h.substr(0,2)=='0x'){_uint = uint('0x'+$h.toString().split('0x')[1]);trace("convert hex String2Number :"+_uint);
				}
			}
			
			/**
			* Mode Number
			**/
			if ($h is Number && $modes=='N'){
				newHex = $h;
			}else if($h is Number && $modes=='S'){
				if($h.substr(0,1)=='#'){_strg='0x'+$h.toString().split('#')[1];}
				else if($h.substr(0,2)=='0x'){_strg = '0x'+$h.toString().split('0x')[1];}
				newHex = _strg;
			}
			return newHex;
		}
		
		/**
		* Outil de remplacement de séparateur dans une chaine
		*
		* @param $strInit		 	chaine de caractère contenant le ou les séparateurs à remplacer
		* @param $oldSeparator 		Caractère ou séparateur devant être remplacé
		* @param $newSeparator 		Caractère ou séparateur qui remplacera celui précédemment remplacé
		* @return valeur décimale >> hex2dec("0xF00F04") returns “240 15 4″.
		**/
		public static function replace($strInit:String, $oldSeparator:String, $newSeparator:String):String {
			return ($strInit.split($oldSeparator)).join($newSeparator);
		}
	}
}