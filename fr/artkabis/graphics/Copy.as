package fr.artkabis.graphics
{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	
		/**
	* La classe Copy permet de cloner un élément un nombre de fois illimité et de les positionner à des points précis
	*
	* @author		NICOLLE-Gregory - Artkabis
	* @version		1.0
	* @date 		26.03.2010
	*
	* @example Dans cet exemple il est créé 10 copies de bitmap nommé image elles seront position de 10 pixels en 10 pixels sur l'axe x et à 0 pixel de l'axe y
	* 
	*
	* <listing version="1.0">
	*     Copy.draw( {scene:this, cible:image, nb:10, tabX:new Array(0,10,20,30,40,50,60,70,80,90,100), tabY:new Array(0,0,0,0,0,0,0,0,0,0});
	*  </listing>
	*/

	public class Copy extends MovieClip
	{
		/**
		* variable pour la récupération de la scène
		*/
		private static var _scene:*;
		private static var _cible:*;
		private static var _cibleBMP:BitmapData;
		private static var _copyBMP:Bitmap;
		private static var _bounds:Object;
		private static var _positionX:Number
		private static var _positionY:Number
		private static var _cibleH:Number;
		private static var _cibleW:Number;
		private static var _nb:int=1;
		private static var _copys:Array;
		private static var _tabX:Array;
		private static var _tabY:Array;
		
		 public function Copy():void{}
		
		
		/**
		* Creation d'un Timeout
		*
		* <p>La mise en place de la classe Copy doit passer par la méthode draw.</p>
		*
		* @param scene 			Récupération de la scene contenant l'élément à copier
		* @param cible 			Objec cible, celui-ci peut être un DisplayObject (movieClip, Sprite, etc) ou une image Bitmap
		* @param nb				Nombre de copie returné, ces copie seront ajoutées à la liste d'affichage
		* @param tabX			Tableau contenant la position lié à l'axe x de chaque copie demandé
		* @param tabY			Tableau contenant la position lié à l'axe y de chaque copie demandé
		* @param positionX		Position lié à l'axe x de la copie unique demandé
		* @param positionY		Position lié à l'axe y de la copie unique demandé
		* @see Copy
		*/
		
		 public static function draw(args:Object)
		{
			if(!args.cible is DisplayObject || !args.cible is BitmapData) throw new Error("L'objet cible ne peut être que de type DisplayObject ou Bitmap, modifiez donc ce paramètre et relier le bon type d'élément");
			_scene     = args.scene;
			_cible     = args.cible;
			_nb        = args.nb;
			_tabX      = args.tabX;
			_tabY      = args.tabY;
			_positionX = args.positionX;
			_positionY = args.positionY;
			
			if(_cible!=null && _nb!=0 && _scene!=null ){construct();}else{trace("Attention, vous n'avez pas utilisé correctement les paramètres de cette fonction, veuillez les utiliser correctement: Copy.draw({_scene:this, _cible:monImage, nb:2, positionX:10, positionY:20}); Si vous avez plusieurs copies, vous pouvez positionner vos image en utilisant les paramètres tabX et tabY, ils regroupent la position en x et y dans un tableau, sachant que les valeurs correspondent à l'ordre des copies");}
		}
		private static function construct():void
		{
			_cibleH    = _cible.height;
			_cibleW    = _cible.width;
			_copys=[];
			
			_bounds = new Object();
			_bounds.width = _cibleW;
			_bounds.height = _cibleH;
			
			_cibleBMP = new BitmapData(_bounds.width, _bounds.height, true, 0xFFFFFF);
			_cibleBMP.draw(_cible);
			_copyBMP = new Bitmap(_cibleBMP);
			_copyBMP.x = _positionX;
			_copyBMP.y = _positionY;
			
			if(_nb>1)
			{
				for(var i:int=0; i<_nb; i++)
				{
					_copyBMP = new Bitmap( _cibleBMP );
					_copys.push( _copyBMP );
					_scene.addChild( _copys[i] )
					if(_tabX.length === _nb && _tabY.length === _nb && _tabX.length == _tabY.length){_copys[i].x = _tabX[i];_copys[i].y = _tabY[i];
					}else{trace ("le nombre d'élément des tableau tanX et tabY doivent correspondrent entre elles et au nombre de copy demandées...");}
				}
			}
			else {_scene.addChild(_copyBMP);}
		}
		/**
		*Il est possible de récupérer le nombre de copie en utilisant la méthode Copy.copys
		*/
		public static function  get copys():Array{return _copys};
	}
}
