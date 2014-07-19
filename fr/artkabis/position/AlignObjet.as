package fr.artkabis.position {
	
	import flash.events.Event;
	import flash.display.*;

	public class AlignObjet extends PosObject{

		public function AlignObjet(target:DisplayObject,paramObj:Object)
		{
			/* initialisation de la classe parent */
			super(target,paramObj);
			
			//assignation des valeur de l'alignement et des marges dans les paramétres du constructeur
			var alignement = paramObj.alignement;
			var marge = paramObj.marge;
			
			/* Mise en place de l'alignement par defaut*/
			if (alignement == undefined) alignement = "MIDDLE";
			if (marge == undefined) marge = 0;
			
			/* convertion de l'alignement (eg. "TOP", "BOTTOM_RIGHT") to x, y, offsetX et offsetY */
			var params = new Object();
			switch (alignement){
				case "HAUT_GAUCHE":
				params = {
					x:0,
					y:0,
					offsetX: marge,
					offsetY: marge
					};
				break;
				case "HAUT":
				params = {
					x:.5,
					y:0,
					offsetX: -target.width/2,
					offsetY: marge
					};
				break;
				case "HAUT_DROITE":
				params = {
					x:1,
					y:0,
					offsetX: -target.width - marge,
					offsetY: marge
					};
				break;
				case "GAUCHE":
				params = {
					x:0,
					y:.5,
					offsetX: marge,
					offsetY: -target.height/2
					};
				break;
				case "MILLIEU":
				params = {
					x:.5,
					y:.5,
					offsetX: -target.width/2 - marge/2,
					offsetY: -target.height/2 - marge/2
					};
				break;
				case "DROITE":
				params = {
					x:1,
					y:.5,
					offsetX: -target.width - marge,
					offsetY: -target.height/2
					};
				break;
				case "BAS_GAUCHE":
				params = {
					x:0,
					y:1,
					offsetX: marge,
					offsetY: -target.height - marge
					};
				break;
				case "BAS":
				params = {
					x:.5,
					y:1,
					offsetX: -target.width/2,
					offsetY: -target.height - marge
					};
				break;
				case "BAS_DROIT":
				params = {
					x:1,
					y:1,
					offsetX: -target.width - marge,
					offsetY: -target.height - marge
					};
				break;
			}
			_param = params;			

			//Repositionnement des éléments
			this.reposition();
		}
	}
}