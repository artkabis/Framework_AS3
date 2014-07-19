package fr.artkabis.utils
{
	[SWF(width="500", height="500", frameRate="30", backgroundColor="#FFFFFF")]
	
	import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

	
	public class Embeding extends Sprite
	{
		[Embed(source="ensemble.swf", symbol="Croix")]
        private var Croix:Class;
		
        [Embed(source="ensemble.swf", symbol="Rond")]
        private var Rond:Class;
		
        [Embed(source="ensemble.swf", symbol="Triangle")]
        private var Triangle:Class;
		
        [Embed(source="ensemble.swf", symbol="Carre")]
        private var Carre:Class;

		public function Embeding(){init();}
		private function init():void
		{			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			
			var carre:Sprite = new Carre();
			addChild(carre);
			carre.x = 200;
			carre.y = 100;
			
			var rond:Sprite = new Rond();
			addChild(rond);
			rond.x = 300;
			rond.y = 100;
			
			var triangle:Sprite = new Triangle();
			addChild(triangle);
			triangle.x = 300;
			triangle.y = 100;
			
			var croix:Sprite = new Croix();
			addChild(croix);
			croix.x = 100;
			croix.y = 100;
		}
	}
}