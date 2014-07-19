
/*****************************************************************************************************  
* Tooltip (AS3), version 1.2                                                                         * 
*                                                                                                    *
*                                                                                                    *
*                                                                                                    *
* <pre>                                                                                              *
*  ____              _         _      ____                                                           *
* |  __| _____  ____| |_      | | __ |__  |                                                          *
* | |   |  _  ||  _||  _| __  | |/ /    | |                                                          *
* | |   | |_| || |  | |  |__| |   <     | |                                                          *
* | |__ |_| |_||_|  |_|       |_|\_\  __| |                                                          *
* |____|                             |____|                                                          *
*                                                                                                    *
* </pre>                                                                                             *
*                                                                                                    *
* @class    :   Tooltip                                                                              *
* @author   :   Greg.N :: Artkabis                                                                   *
* @version  :   1.2 - class Tooltip (AS3)                                                            *
* @since    :   28-07-2009 21:02                                                                     *
*                                                                                                    *
*****************************************************************************************************/
package fr.artkabis.ui
{
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.display.MovieClip;
	import gs.TweenMax;
	import gs.easing.Back;

	public class Tooltip extends MovieClip
	{
		private var _format:TextFormat;
		private var _ecart:int =10;
		private var _titre:String;
		private var _bt:*;

		/****
		** Créer un nouveau tooltip en instanciant l'objet de cette facon
		** var tooltip:Tooltip = new Tooltip(bouton1,'Description de l'infobulle');
		** Il suffit ensuite d'ajouter l'objet à la list d'affichage: this.addChild( tooltip );
		** Attention, n'oubliez pas d'importer la classe Tooltip après l'avoir lié à flash: 
		** import fr.artkabis.ui.Tooltip;
		****/
		//=====================================================================================================
		public function Tooltip (pBt:*,pTitre:String):void
		//=====================================================================================================
		{
			_titre    =   pTitre;
			_bt       =   pBt;
			_format   =   new TextFormat();
			if(_bt as MovieClip)_bt.mouseChildren = this.mouseChildren = this.mouseEnabled = this.mouseEnabled = false;

			this.name = 'tooltip';
			this.alpha = 0;
			this.mouseEnabled = this.mouseChildren = false;
			_bt.addEventListener('mouseOver',overBt1);
			_bt.addEventListener('mouseOut',outBt1);
			addEventListener('mouseOver',over);
			
			dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
		}
		
		/****
		** Mise en place du tooltip et des différents élément du composant
		** Le texte est formaté, la taille du tooltip adapté au dimension du texte
		** Enfin, la fonction draxTT renvoie vers la fonction de gestion d'inertie
		****/
		//=====================================================================================================
		private function drawTT():void
		//=====================================================================================================
		{
			this.contenu.titre.text = _titre;
			this.contenu.titre.alpha = 0;
			this.contenu.titre.multiline = false;
			this.contenu.titre.autoSize = TextFieldAutoSize.LEFT;
			_format.align = TextFormatAlign.LEFT;
			this.contenu.titre.defaultTextFormat = _format;
			trace(this.contenu.centre.scale9Grid);
		
			var _largTitre = this.contenu.titre.width;
			TweenMax.to(this,.4,{alpha:1});
			TweenMax.to(this.contenu.centre,.4,{width:_largTitre + _ecart,ease:Back.easeOut});
			TweenMax.to(this.contenu.titre,.4,{delay:.2,alpha:1});
			_bt.addEventListener('enterFrame',posTT);
		}
		
		/****
		** La fonction posTT (positionnement tooltip) gère
		** l'ensemble de l'inertie lié au déplacement du composant
		** Le calcule ajout un décalage au drag du tooltip
		****/
		//=====================================================================================================
		private function posTT(me:Event):void
		//=====================================================================================================
		{
			this.x -= (this.x - this.parent.mouseX)*.13;
			this.y -= (this.y - this.parent.mouseY)*.13;
			this.y+= -3
			this.x+= -1
		}
		
		/****
		** La fonction suppTT (suppression tooltip) gère
		** la suppression de l'écouteurs posTT et le repositionnement
		** du tooltip
		****/
		//=====================================================================================================
		private function suppTT():void
		//=====================================================================================================
		{
			_bt.mouseEnabled = false;
			this.contenu.titre.text = '';
			TweenMax.to(this,.5,{x:_bt.x+_bt.width/2,y:_bt.y+_bt.height ,alpha:0,onComplete:reactiv});
			TweenMax.to(this.contenu.centre,.3,{width:_ecart,ease:Back.easeIn});
			_bt.removeEventListener('enterFrame',posTT);
			function reactiv():void
			{
				_bt.mouseEnabled = true;
			}
		}
		
		/****
		** Initialisation du tooltip au rollOver de l'objet _bt
		****/
		//=====================================================================================================
		private function overBt1(me:MouseEvent):void
		//=====================================================================================================
		{
			drawTT();
		}
		
		/****
		** Suppression du tooltip au rollOut de l'objet _bt
		****/
		//=====================================================================================================
		private function outBt1(me:MouseEvent):void
		//=====================================================================================================
		{
			suppTT();
		}
		
		/****
		** Desactivation du tooltip pendant le rollOver du bouton
		****/
		//=====================================================================================================
		private function over(me:MouseEvent):void
		//=====================================================================================================
		{
			if(me.target.name != _bt.name)me.target.mouseEnabled = false;
		}
		//=====================================================================================================
		//********************************************FIN******************************************************
		//=====================================================================================================
	}
}