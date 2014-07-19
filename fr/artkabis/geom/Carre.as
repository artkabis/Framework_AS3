package fr.artkabis.geom
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	public class Carre extends MovieClip  
	{
		private var carre                      :Shape;
		private var typ                        :String;
		public var type                        :String;
		private var meth                       :String;
		private var cs                         :Array;
		private var matr                       :Matrix;
		private var alphs                      :Array;
		private var ratios                     :Array;
		public var taille                      :int;
		public var couleurs                    :Array;
		public var angle                       :Number;
		
		public function Carre ( pTaille:int , pCouleurs:Array , pAngle:Number , pType:String ) :void 
		{
			matr  = new Matrix( );
			carre  = new Shape ( );
			
			couleurs = pCouleurs;
			taille = pTaille;
			angle = pAngle;
			type = pType;
			draw();
		}
		
		private function draw():void
		{
			type = (type === 'l' ? typ = GradientType.LINEAR : typ = GradientType.RADIAL);
			meth = SpreadMethod.REFLECT;
			alphs = [ 1 , 1];
			ratios = [ 0, 255 ];
			
			matr.createGradientBox( taille, taille, angle, 0, 0 );
			carre.graphics.beginGradientFill( typ, couleurs, alphs, ratios, matr, meth);
			carre.graphics.drawRect( 0 , 0 , taille , taille );
				
			addChild ( carre );
		}
	}
}