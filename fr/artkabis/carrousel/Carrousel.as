/*********************************************************************************************
**			import fr.artkabis.carrousel
**			var _urlXML:String = 'xml/monXML.xml';
**			var _carrousel:Carrousel;
**			_carrousel = new Carrousel();
**			_carrousel.add(_urlXML);
**			
**			//paramètrage du carrousel: rayon x et y, delimitation de la zone de mouvement: minX-maxX & minY-maxY, gestion de la vitesse: 1 lent, 2 vitesse moyenne, 3 vitesse accèléré
**			_carrousel.rayonX  = 175;
**			_carrousel.rayonY  = 020;
**			_carrousel.maxY    = 130;
**			_carrousel.maxX    = 450;
**			_carrousel.minY    = 030;
**			_carrousel.minX    = 005;
**			_carrousel.vitesse = 000;
**			_carrousel.x       = 150;
**			_carrousel.y       = 320;
**		
**			this.addChild(_carrousel);
**
**
********************************************************************************************/


package fr.artkabis.carrousel
{
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	
	public class Carrousel extends MovieClip
	{
		private var   urlXml                            :  URLRequest   ;
		private var   chargeurXml                       :  URLLoader    ;
		private var   listeElements                     :  Array        ;
		private var   autorisationMouve                 :  Boolean      ;
		private var   nbreItems                         :  uint         ;
		private var   angleInit                         :  Number       ;
		private var   angleSup                          :  Number       ;
		private var   angleFinal                        :  Number       ;
		private var   listeClips                        :  Array        ;
		private var   _rayonX                           :  Number = 150 ;
		private var   _rayonY                           :  Number = 25  ;
		private var   _maxX                             :  Number = 430 ;
		private var   _maxY                             :  Number = 130 ;
		private var   _minX                             :  Number = 25  ;
		private var   _minY                             :  Number = 25  ;
		private var   _vitesse                          :  int    = 02  ;
		
		public var item:Item;
		public var reflet:Reflet;
		
		//Getters Setters
		public function get rayonX():Number{return _rayonX;}
		public function set rayonX($rx:Number){_rayonX = $rx;}
		
		public function get rayonY():Number{return _rayonY;}
		public function set rayonY($ry:Number){_rayonY = $ry;}
		
		public function get minX():Number{return _minX;}
		public function set minX($mx:Number){_minX = $mx;}
		
		public function get maxX():Number{return _maxX;}
		public function set maxX($mx:Number){_maxX = $mx;}
		
		public function get minY():Number{return _minY;}
		public function set minY($my:Number){_minY = $my;}
		
		public function get maxY():Number{return _maxY;}
		public function set maxY($my:Number){_maxY = $my;}
		
		public function get vitesse():int{return _vitesse;}
		public function set vitesse($v:int)
		{
			_vitesse = Math.round($v);
			_vitesse = (_vitesse>3) ? 3 : $v || (_vitesse<1) ? 1 : $v;
		}
		
		public function Carrousel():void
		{
			this.alpha=0;
			TweenMax.to(this,2,{delay:1, alpha:1,ease:Bounce.easeOut});
		}
		public function add($url:String):void
		{
			urlXml        = new URLRequest($url);
			listeElements = new Array();
			listeClips    = new Array();
			chargeurXml   = new URLLoader();
			
			autorisationMouve = false;
			angleSup = 0;
			
			chargeurXml.addEventListener(Event.COMPLETE, xmlCharge);
			this.addEventListener(MouseEvent.MOUSE_OUT, function(){stoppe()});
			this.addEventListener(MouseEvent.MOUSE_OVER, function(){anime()});
			this.addEventListener(MouseEvent.MOUSE_MOVE, gestionAnim);
			
			chargeurXml.load(urlXml);
		}
	
		private function xmlCharge(p:Event):void
		{
			var xml:XML = new XML(chargeurXml.data);
			if(xml)
			{
				var elements:XMLList = new XMLList(xml.element);
				for each(var element:XML in elements)
				{
					var objet:Object = new Object();
					objet.urlImage = element.urlImage;
					objet.urlCible = element.urlCible;
					listeElements.push(objet);
				}
				creationElements();
			}
		}
		public function supp():void
		{
			listeClips=[];
			this.removeChild(item);
			this.removeChild(reflet);
		}
		
		private function creationElements():void
		{
			nbreItems = listeElements.length;
			for(var i:uint = 0; i<listeElements.length; i++)
			{
				//Creation items
				item = new Item("item"+String(i), listeElements[i].urlImage, listeElements[i].urlCible);
				item.name = "item"+i;
				this.addChild(item);
				listeClips.push(item);
				
				//Creation reflets
				reflet = new Reflet("reflet"+String(i), listeElements[i].urlImage, new Array(.7,0), new Array(0,95));
				this.addChild(reflet);
				listeClips.push(reflet);
			}
			this.addEventListener(Event.ENTER_FRAME, positionnement);
		}
		
		//Mouvement
		private function positionnement(p:Event):void
		{
			for(var i:uint=0; i<nbreItems; i++)
			{
				angleInit = 2* Math.PI* (i/nbreItems);
				angleFinal = angleInit + angleSup;
				
				//positionnement x
				this.getChildByName("item"+i).x = getChildByName("reflet"+i).x = (this.width/2 + _rayonX * -Math.cos(angleFinal));
				//positionnement y
				this.getChildByName("item"+i).y = this.height/2 + _rayonY * -Math.sin(angleFinal);
				this.getChildByName("reflet"+i).y    = (this.height/2 + _rayonY * -Math.sin(angleFinal))+.95;
				
				//ScaleX et scaleY
				this.getChildByName("item"+i).scaleX = getChildByName("reflet"+i).scaleX = 0.8 + 0.2*-Math.sin(angleFinal); 
				this.getChildByName("item"+i).scaleY = getChildByName("reflet"+i).scaleY = 0.8 + 0.2*-Math.sin(angleFinal);
			}
			for(i=0; i<nbreItems* 2; i++)
			{
				listeClips.sortOn("scaleX", Array.NUMERIC);
				this.setChildIndex(listeClips[i], i);
			}
			//Evolution elements 
			if(autorisationMouve)
			{
				angleSup += ((( this.mouseX - this.width/2)* _vitesse/10000)* Math.PI);
				if(angleSup > (2* Math.PI)){angleSup -= (2* Math.PI)};
			}else {angleSup = angleSup;}
		}
		
		public function stoppe():void{ autorisationMouve = false; }
		public function anime():void{ autorisationMouve = true; }
		private function gestionAnim(me:MouseEvent):void
		{
			if(this.mouseX<_minX || this.mouseY<_minY || this.mouseX>_maxX || this.mouseY>_maxY)
			{
				stoppe();
			}else{
				anime();
			}
		}
	}
}