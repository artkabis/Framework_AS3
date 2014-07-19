/*
Pour utiliser le moduleView, vous devez commencer par créer deux éléments qui seront utilisé dans cette classe, 
le premier concerne la fermeture du module, il vous faut donc créer un bouton (MovieClip) close partant le nom de classe BtClose, il devra comporter deux états 'over' et 'out' définit par des étiquettes d'images.
Le second concerne le chargement de l'image à afficher, il devra porter le nom de classe Preload, vous pouvez utiliser ce dont vous avez envie pour faire passienter le visiteur pendant le chargement de l'image.

La mise en place ::

import fr.artkabis.mods.ModuleView;

ModuleView.add(this, 'images/image1.jpg');


*/


package fr.artkabis.mods
{
	import fr.artkabis.errors.ReturnError;
	import fr.artkabis.errors.ViewError;
	
	import flash.events.MouseEvent;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter
	import flash.text.TextField;
	import flash.events.ProgressEvent;
	import flash.net.LocalConnection;
	
	import com.greensock.events.TweenEvent;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Sine;
	
	public class ModuleView extends MovieClip
	{
		public static var tween                                 :TweenMax
		public static var tween2                                :TweenMax
		public static var ldr                                   :Loader;
		public static var fichiers                              :Array=[];
		public static var xml                                   :XML
		public static var ombre                                 :DropShadowFilter;
		private static var _filtre                              :GlowFilter;
		public static var initViewer                            :Boolean;
		public static var btClose                               :BtClose;
		public static var _this                                 :Object;
		private static var _cible                               :Object;
		private static var _infos                               :TextField;
		private static var _preloader                           :Preload;
		private static var _contInfos                           :MovieClip;
		private static var _centreY,_centreX,id                 :int;
		private static const COULEUR_GLOW                       :uint = 0xFB6300;
		private static var _stage                               :*;
		private static var _url                                 :*;
		
		public function ModuleView(){}
		
		public static function add($cible:Object=null,$url:*=null):void
		{
			trace('ModuleView.add()');
			btClose = new BtClose();
			ldr = new Loader();
			
			_url=$url;
			_cible=$cible;
			
			if(_url && _cible)
			{
				_this = _cible;
				_stage = _this.parent;
				trace('ModuleView >> _cible  : ' + _cible, '_stage : '+_stage);
				
				_preloader                                    = new Preload();
				_contInfos                                    = new MovieClip();
				_infos                                        = new TextField();
				_filtre                                       = new GlowFilter( COULEUR_GLOW, 1, 10, 10, 1, 3, false, false);
				
				_infos.textColor = COULEUR_GLOW;
				_infos.width = 32;
				_centreY = _stage.stageHeight*.5;
				_centreX = _stage.stageWidth*.5;
				_contInfos.y = _centreY-50;
				_contInfos.x = _centreX-26;
				_preloader.x = _centreX;
				_preloader.y = _centreY;
				_contInfos.alpha=0;
				_preloader.alpha=0;


				if(_url is URLRequest){
					if(!initViewer)
					{
						trace('$url est de type string et initViewer sur false');
						ldr.load(_url);
					}else
					{
						ldr.load(_url);
						affiche(ldr,2);
					}
				}else{
					if(!initViewer){
						trace('$url est de type string et initViewer sur false');
						ldr.load(new URLRequest(_url));

					}else{
						ldr.load(new URLRequest(_url));
						affiche(ldr,2);
					}
				}
				ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, chargementImage);
				ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoaded);
				ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, imageNoLoaded);
				btClose.buttonMode=true;
				btClose.mouseChildren=false;
				_this.addChild(ldr);
			}else{ throw new Error("Attention pour créer une image d'aperçu, vous devez spécifier le chemin du fichier depuis la méthode add($url).");}
			
		}
		private static function chargementImage(pe:ProgressEvent):void{
			
			_this.addChild(_preloader);
			TweenMax.to(_preloader,.5,{alpha:1});
			TweenMax.to(_preloader,1,{y:_centreY-100,x:_centreX-50,z:500,ease:Sine.easeOut});
			_this.addChild(_contInfos);
			_contInfos.addChild(_infos);
			TweenMax.to(_contInfos,1,{y:_centreY-40,x:_centreX-60,z:200,ease:Sine.easeOut});
			TweenMax.to(_contInfos,.5,{alpha:1});
			var bl:int   = pe.bytesLoaded;
			var bt:int   = pe.bytesTotal;
			var pct:int  = Math.floor(( bl / bt)* 100) ;
			_infos.text = pct + "%";

		}
		public static function imageLoaded(e:Event):void{
			trace('chargement de l\'image');
			_contInfos.removeChild(_infos);
			_this.removeChild(_contInfos);
			_this.removeChild(_preloader);
			_infos=null;
			_contInfos=null;
			_preloader=null;
			try {
			   new LocalConnection().connect('foo');
			   new LocalConnection().connect('foo');
			} catch (e:*) {}
			var l = ldr;
			if(l.width>200 && l.width<500){
					l.filters = [new DropShadowFilter(0,45,0x000000,1,25,25,2,3,false,false,false)];
			}else if(l.width>500 && l.width<1000){
					l.filters = [new DropShadowFilter(0,45,0x000000,.5,15,15,2,3,false,false,false)];
			} else if(l.width>1000){
					l.filters = [new DropShadowFilter(0,45,0x000000,.7,35,35,2,3,false,false,false)];
			}else{
				l.filters = [new DropShadowFilter(0,45,0x000000,1,15,15,1,3,false,false,false)];
			}
			trace('loader : '+l,'nb children : '+l.numChildren,'largeurImage : '+l.width);
			positionneImage(l,2);
		}
		public static function imageNoLoaded(ie:IOErrorEvent):void{
			trace('Erreur : '+ie);
			var msg = ReturnError.extract(ie,true);
			ViewError.draw(_stage ,msg);
		}
		public static function positionneImage($img:*,$duree:int){
			trace('positionnement de l\'image');
			$img.x = (_stage.stageWidth*.5) - ($img.width*.5);
			$img.y = (_stage.stageHeight*.5) - ($img.height*.5);
			btClose.x = ($img.x+$img.width);
			btClose.y = $img.y;
			_this.addChild(btClose);
			trace('initViewer : '+initViewer);
				
			if(!initViewer){
				$img.alpha=0;
				btClose.alpha=0;
				affiche(ldr,2);
				trace('affichage nouvelle image');
			}	
			initViewer =true;
		}	
		public static function affiche($img,$time){
			$img.alpha=0;
			btClose.alpha=0;
			tween = TweenMax.to($img,$time,{alpha:1,ease:Back.easeOut});
			tween2 = TweenMax.to(btClose,$time,{alpha:1,ease:Back.easeOut});	
			_stage.addEventListener('mouseOver',__actions);
			_stage.addEventListener('mouseOut',__actions);
			_stage.addEventListener('mouseUp',__actions);

		}
		
		public static function __actions(me:MouseEvent):void{
			if(me.target == btClose){
				switch(me.type){
					case 'mouseOver' :
					 me.target.gotoAndPlay('over');
					 break;
					 case 'mouseOut' :
					 me.target.gotoAndPlay('out');
					 break;
					 case 'mouseUp' :
					trace('close');
					closeImage()
					 break;
				}
			}
		}
		public static function closeImage(){
			tween = TweenMax.to(ldr,2,{alpha:0,ease:Back.easeOut,onComplete:function(){ldr.unload();}});
			TweenMax.to(btClose,2,{alpha:0,ease:Back.easeOut,onComplete:function(){_this.removeChild(btClose);}});
		}
	}
}
