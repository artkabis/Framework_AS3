
/*******************************
* Website: www.artkabis.fr     *
* Forum: www.artkabis.net      *
* Email: artkabis@artkabis.net *
********************************/

package fr.artkabis.ui
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import gs.TweenMax;
	
	//______________________○○○ ActionsScroll contenu○○○___________________________
	public class Scroll extends MovieClip
	{
		private var hauteur_contenu               :Number;
		private var hauteur_mask                  :Number;
		private var oldY                          :Number;
		private var bounds                        :Rectangle;
		private var scrolling                     :Boolean
		private var hauteurC                      :Number;
		private var hauteurM                      :Number;
		private var contenu                       :MovieClip;
		private var scrollMC                      :MovieClip;
		private var masque                        :MovieClip;
		private var stageG                        :Object;
		private var animate                       :Boolean;
		private var anim                          :MovieClip;
		
		//===============================================================================================================================
		public function Scroll(_contenu:MovieClip , _masque:MovieClip , _scroller:MovieClip , _HauteurC:Number , _HauteurM:Number, _animate:Boolean=false, _anim:MovieClip=null):void
		//===============================================================================================================================
		{
			hauteurC   = _HauteurC;
			hauteurM   = _HauteurM;
			contenu    = _contenu;
			scrollMC   = _scroller;
			masque     = _masque;
			animate    = _animate;
			anim       = _anim;
			
			stageG = this.contenu.parent.root;
			trace('stageG = '+stageG);
			hauteur_contenu = hauteurC;
			hauteur_mask = hauteurM;
			 
			oldY = contenu.y;
			contenu.x = masque.x;
			contenu.y = masque.y;
			contenu.mask = masque;
			bounds = new Rectangle( scrollMC.x , scrollMC.y , 0 , hauteurM-scrollMC.height );
			scrolling = false;
			scrollMC.addEventListener( MouseEvent.MOUSE_DOWN , startScroll );
			//stageG.addEventListener( MouseEvent.MOUSE_OUT , quitteScroll );
			scrollMC.stage.addEventListener( MouseEvent.MOUSE_UP , stopScroll );
			stageG.addEventListener( MouseEvent.MOUSE_WHEEL, scrollMolette);
		}
		//===============================================================================================================================
		private function startScroll(me:MouseEvent):void 
		//===============================================================================================================================
		{
			if(animate && anim!=null){
				anim.play();
			}
				
				
			stageG.addEventListener( Event.ENTER_FRAME , enterframe );
			scrolling = true;
			this.scrollMC.startDrag(false,bounds);
		}
		private function quitteScroll(me:MouseEvent):void
		{
			if(mouseY>masque.y && mouseY<masque.height && me.target.name === 'scrollMC')this.scrollMC.startDrag(false,bounds);
			else this.scrollMC.stopDrag();
		}
		//===============================================================================================================================
		private function stopScroll(me:MouseEvent):void 
		//===============================================================================================================================
		{
			if(animate && anim!=null)anim.gotoAndStop(1);
			this.scrollMC.stopDrag();
			stageG.removeEventListener( Event.ENTER_FRAME , enterframe );
			scrolling = false;
		}
		//===============================================================================================================================
		private function enterframe(e:Event):void 
		//===============================================================================================================================
		{
			if (scrolling == true) 
			{
				var distance:Number = Math.round(scrollMC.y - bounds.y);
				var pourcentage:Number = distance / hauteur_mask;
				oldY = contenu.y;
				var targetY:Number = -((hauteur_contenu - hauteur_mask) * pourcentage) + masque.y;
				if (Math.abs(oldY - targetY) > 5) 
				{
					TweenMax.to(contenu, 0.3, {y: targetY, blurFilter:{blurX:15, blurY:10}, onComplete: finTween});
				}
			}
		}
		//===============================================================================================================================
		private function finTween():void 
		//===============================================================================================================================
		{
			TweenMax.to(contenu, 0.3, {blurFilter:{blurX:0, blurY:0}});
		}
		//===============================================================================================================================
		function scrollMolette(me:MouseEvent):void
		//===============================================================================================================================
		{
			trace('contenu.y = '+contenu.y);
			trace('masque.height = '+masque.height)
			 if(contenu.y>=masque.y){
				 contenu.y =masque.y;
				 finTween();
			 }
			 if(contenu.y<= -(hauteur_contenu- hauteur_mask)){
				 contenu.y = -(hauteur_contenu-hauteur_mask);
			 }
			  if(contenu.y>= -(masque.height-scrollMC.height) && contenu.y<= -(masque.height-scrollMC.height)-40){
				  trace('contenu plus grand que hauteur masque');
				  scrollMC.y = -(masque.height-scrollMC.height)-200;
				  contenu.y =  -masque.height;
				  finTween();
			  }
			  else {
				  scrollMC.y = -contenu.y-200;
				  finTween();
			  }
			  
			scrollMC.y=contenu.y;finTween();
			TweenMax.to(contenu, 0.3, {y: contenu.y+= me.delta, blurFilter:{blurX:15, blurY:10}, onComplete: finTween});
			scrollMC.y = -contenu.y;
		}
	}
}