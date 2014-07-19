package fr.artkabis.errors
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.filters.DropShadowFilter;
	
	public class AfficheError extends TextField
	{
		private var _txtErr:TextField;
		private var _format:TextFormat;
		private var _ombreI:DropShadowFilter;
		
		public function AfficheError(){
			init()
		}
		private function init():void
		{
			_txtErr      =   new TextField();
			_format      =   new TextFormat();
			_ombreI      =   new DropShadowFilter( 0,45,0x000000,1,10,10,1,3,false,false,false );

			//_______○○○--Formatage---○○○_______
			_format.size  = 13;
			_format.bold  = true;
			_format.align = TextFormatAlign.CENTER;
			
			//_______○○○--Paramètrage du texte d'erreur---○○○_______
			_txtErr.filters     = [ _ombreI ];
			_txtErr.textColor   = 0xFF0000;
			_txtErr.multiline   = false;
			_txtErr.y           = stage.stageHeight / 2;
			_txtErr.width       = stage.stageWidth;
		}
		public function draw($msg:String)
		{
			_txtErr.text        = $msg;
			_txtErr.setTextFormat( _format );
		}
	}
}