package fr.artkabis.text
{
	import flash.display.Sprite;
	import flash.text.engine.*;
	public class CourbeText extends Sprite
	{
	       private static var container:Sprite;
	       private static var myAngle:Number;
	       private static var rads:Number;
	       private static var fontDescription:FontDescription;
	       private static var format:ElementFormat;
	       private static var textElement:TextElement;
	       private static var textBlock:TextBlock;
	       private static var lineWidth:Number;
	       private static var textLine:TextLine;
	       //
	       public function CourbeText ():void
	       {
	       }
	       public function creerCourbe (
										
										 $string:String="text", 
	      								 $largeurPath:int=150,
										 $hauteurPath:int=150,
										 $angle:int=360, 
	       								 $taille:int=14,
										 $couleursText:uint=0x000000,
										 $police:String="Impact"
										 
									   ):void
	       {
	               fontDescription = new FontDescription($police);
	               format = new ElementFormat(fontDescription);
	               format.fontSize = $taille;
	               format.color = $couleursText;
	               try
	               {
	                       for (var i:int = 0; i<$string.length; i++)
	                       {
	                               var ca:String = $string.charAt($string.length - i - 1);
	                               myAngle = (i * $angle / ($string.length-1));
	                               rads = myAngle * Math.PI / 180;
	                               textElement = new TextElement(ca,format);
	                               textBlock = new TextBlock();
	                               textBlock.content = textElement;
	                               lineWidth = 20;
	                               textLine = textBlock.createTextLine(null,lineWidth);
	                               textLine.x = $largeurPath * Math.cos(rads);
	                               textLine.y = $hauteurPath * Math.sin(-rads);
	                               textLine.rotation = 90 - myAngle;
	                               addChild (textLine);
	                               textLine = textBlock.createTextLine(textLine,lineWidth);
	                       }
	               }
	               catch (e:Error)
	               {
	                       trace (e);
	               }
	       }
	}
}
