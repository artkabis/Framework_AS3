

package fr.artkabis.graphics
{
	import flash.display.Shape;
	
	/**
	* La classe DessineRect est une classe graphique permettant de dessiner un rectangle depuis toute une palette de paramètres
	*
	* @author		NICOLLE-Gregory - Artkabis
	* @version		1.0
	* @date 		26.03.2010
	*
	* @example Dans cet exemple un rectangle de 200 pixels de largeur sur 50 pixels de hauteur est créé, la couleur de base est noir avec alpha à 100 %, le contour blanc de 1 pixel avec bord arrondie de 0.10
	* 
	*
	* <listing version="1.0">
	*     DessineRect.draw( 0,0,200,50,0x000000,1,0xffffff,1,true,0.10);
	*  </listing>
	*/

	public class DessineRect extends Shape
	{
		public function DessineRect(){}
		
				/**
		* Creation d'un rectangle avec paramètres
		*
		* <p>La mise en place du Timeout doit passer par la méthode draw(x:Number,y:Number,largeur:Number,hauteur:Number,couleurInterne:uint,alphaCouleurInterne:uint,couleurContour:uint,tailleContour:Number,activArrondie:Boolean,largeurArrondi:Number )</p>
		* @param $x 	Position du rectangle sur l'axe x
		* @param $y 	Position du rectangle sur l'axe y
		* @param $l		Largeur du rectangle en pixel
		* @param $h		Hauteur du rectangle en pixel
		* @param $c1	Couleur de remplissage du rectangle (en hexadecimal : 0xFFFFFF)
		* @param $a1	Opacité de la couleur de remplissage du rectangle
		* @param $c2	Couleur du contour du rectangle (en hexadecimal : 0xFFFFFF)
		* @param $t2	Epaisseur du contour en pixel
		* @param $arr	Activation du contour (true or false)
		* @param $la	Largeur de l'angle d'arrondie du rectangle en pixels
		* @see DessineRect
		* @return rect
		*/

		public static function draw( $x:Number=0 , $y:Number=0 , $l:Number=100 , $h:Number=10 , $c1:uint=0xffffff , $a1:Number=1 , $c2:uint=0x000000 , $t2:Number=0.1 , $arr:Boolean=false , $la:Number=0 ):Shape
		{
			var rect:Shape = new Shape();
			with(rect.graphics)
			{
				beginFill( $c1 , $a1 );
				lineStyle( $t2 , $c2 ); 
				if($arr)drawRoundRect( $x , $y , $l , $h , $la );
				else drawRect( $x , $y , $l , $h );
			}
			return rect;
		}
	}
}
