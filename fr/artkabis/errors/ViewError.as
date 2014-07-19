package fr.artkabis.errors
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.filters.DropShadowFilter;
	import flash.display.Stage;
	
	public class ViewError extends TextField
	{
		private static var _txtErr:TextField;
		private static var _format:TextFormat;
		private static var _ombreI:DropShadowFilter;
		
		public function ViewError(){}
		public static function draw($stage:Stage=null, $text:String = '', $size:int=13, $bold:Boolean=true, $color:uint=0xFF0000, $multiline:Boolean = false):void
		{
			_txtErr      =   new TextField();
			_format      =   new TextFormat();
			_ombreI      =   new DropShadowFilter( 0,45,0x000000,1,10,10,1,3,false,false,false );

			//_______○○○--Formatage---○○○_______
			_format.size  = $size;
			_format.bold  = $bold;
			_format.align = TextFormatAlign.CENTER;
			
			//_______○○○--Paramètrage du texte d'erreur---○○○_______
			_txtErr.filters     = [ _ombreI ];
			_txtErr.textColor   = $color;
			_txtErr.multiline   = $multiline;
			_txtErr.y           = $stage.stageHeight / 2;
			_txtErr.width       = $stage.stageWidth;
			
			_txtErr.text        = $text;
			_txtErr.setTextFormat( _format );
			$stage.addChild(_txtErr);
		}
	}
}