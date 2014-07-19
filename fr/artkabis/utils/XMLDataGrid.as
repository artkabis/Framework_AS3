package  fr.artkabis.utils{
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import fl.controls.DataGrid;
	import fl.controls.ComboBox;
	import fl.controls.Button;
	import flash.events.IOErrorEvent;

	public class XMLDataGrid {
		private static var dg:DataGrid;
		private static var cb:ComboBox;
		private static var urlLoader:URLLoader = new URLLoader();
		private static var bouton:Button;
		private static var bookXML:XML;
		private static var _titresGrid:Array;
		private static var _titresCombo:Array;
		private static var _titresBt:Array;
		private static var _largeurColonnes:Array;
		private static var _largeur:int;
		private static var _hauteur:int;
		private static var _cible:Object;
		private static var _lignesVisible:int;
		private static var _x:int;
		private static var _y:int;

		public function XMLDataGrid() {}
		public static function createdGrid(params:Object):void {
			_cible           = params.target;
			_titresGrid      = params.titles;
			_largeur         = params.width;
			_hauteur         = params.height;
			_largeurColonnes = params.columnsWidth
			_lignesVisible   = params.rowCount;
			_x               = params.x;
			_y               = params.y;
			dg = new DataGrid();
			for (var i:int=0;i<_titresGrid.length;i++){
				dg.addColumn(_titresGrid[i].toString());
				dg.setSize(_largeur,_hauteur);
				if(_largeurColonnes!=null){trace(_largeurColonnes);dg.columns[i].width = _largeurColonnes[i];}else{}
			}
			dg.rowCount=5;
			dg.move(_x,_y);
			if(_cible){_cible.addChild(dg);}else{trace('Vous devez lier la scene avec la classe en spécifiant le paramètre target:this.');}
		}
		
		public static function createdComboBox(params:Object):void {
			_cible          = params.target;
			_titresCombo    = params.labels;
			_largeur        = params.width;
			_hauteur        = params.height;
			_x              = params.x;
			_y              = params.y;
			cb = new ComboBox();
			for (var i:int=0;i<_titresCombo.length;i++){
				cb.addItem({label: _titresCombo[i].toString() });
				cb.setSize(_largeur,_hauteur);
			}
			cb.move(_x,_y);
			if(_cible){_cible.addChild(cb);}else{trace('Vous devez lier la scene avec la classe en spécifiant le paramètre target:this.');}
		}
		
		public static function createdButton(params:Object):void {
			_cible          = params.target;
			_titresBt       = params.labels;
			_largeur        = params.width;
			_hauteur        = params.height;
			_x              = params.x;
			_y              = params.y;
			for (var i:int=0;i<_titresBt.length;i++){
				bouton = new Button();
				bouton.label = _titresBt[i].toString();
				bouton.addEventListener(MouseEvent.CLICK, loadBooks);
				bouton.x = _x;
				bouton.y = _y;
				bouton.width  = _largeur;
				bouton.height = _hauteur;
			}
			if(_cible){_cible.addChild(bouton);}else{trace('Vous devez lier la scene avec la classe en spécifiant le paramètre target:this.');}
		}

		private static function loadBooks(e:Event):void {
			urlLoader.load(new URLRequest(cb.selectedLabel.toLowerCase()+".xml"));
			urlLoader.addEventListener(Event.COMPLETE, populateGrid);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, erreurChargement);
		}
		private static function erreurChargement(ie:IOErrorEvent):void{
			import fr.artkabis.errors.ReturnError;
			import fr.artkabis.errors.ViewError;
			ViewError.draw(_cible.root.parent,ReturnError.extract(ie,true));
		}
		private static function populateGrid(e:Event):void 
		{
			var booksXML:XML = new XML( e.target.data);
			var booksLength:int = booksXML.book.length();
			trace(booksLength);
			var nodes:Array=new Array();
			var obj:Object={}
			var obj2:Object={}
			dg.removeAll();
			for (var i:int=0; i < _titresGrid.length; i++) 
			{
				nodes[i]=_titresGrid[i].toLowerCase();
				obj = '@'+nodes[i];
				obj2 = _titresGrid[i] as Object
				for (var j:int=0; j < booksLength; j++) {
					dg.addItem({
							   obj2 : booksXML.book[j].obj
							   });
				}
			}
		} 
	}
}				/*dg.addItem({
						   Titre: booksXML.book[i].@titre, 
						   enStock: booksXML.book[i].@enstock,
						   Prix: booksXML.book[i].@prix
						   });*/

