/*
Les éléments necessaire au bon fonctionnement de cette application >>
Vous devez créer une animation contenu dans un MovieClip comportant deux parties délimité par des étiquettes d'images, la première en image clé 2 se nomera 'sonOn' et sera utilisé pour annoncer le début ou la relance du fichier audio.
la seconde étiquette en image clé 21 se nomera "mute" et sera utilisé pour annoncer la fin de lectuere du fichier audio. Ce movieClip devra porter le nom de classe "Anim"

Au dessus des calques contenant les éléments utilisés pour les animations, vous devrez ajouter un bouton transparent ayant le nom d'occurrence "zone", celui-ci sera utilisé pour gérer l'arrêt ou la lectuer du fichier audio.

La mise en place >>
import fr.artkabis.mods.SoundMods;

var modsSound:SoundMods = new SoundMods('musique/monSon1.mp3');
this.addChild(modsSound);
*/


package fr.artkabis.mods
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import flash.net.URLRequest;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	import com.greensock.easing.Bounce;

	public class SoundMods extends MovieClip
	{
		private const POS_X                              :Array  = [0,15,30,45]             ;
		private const MAX_Y                              :int    = 45                       ;
		private var _elem                                :MovieClip                         ;
		private var _positionX                           :int                               ;
		private var _positionY                           :int                               ;
		private var _delay                               :Number                            ;
		private var _ease                                :Object                            ;
		private var _etat                                :String = 'on'                     ;
		private var _alpha                               :int                               ;
		private var _activeTint                          :Boolean                           ;
		private var _tint                                :uint                              ;
		private var _rond                                :Sprite                            ;
		private var _balle                               :MovieClip                         ;
		private var _animation                           :Anim                              ;
		private var _tween                               :TweenMax                          ;
		private var _son                                 :Sound                             ;
		private var _channel                             :SoundChannel                      ;
		private var _req                                 :URLRequest                        ;
		private var _positionSon                         :int                               ;
		private var _longueurSon                         :int                               ;
		private var _url                                 :String;
		private var _cible                               :*;
		private var _x,_y,_scaleY,_scaleX                :int;
		
		public function SoundMods(params:Object):void
		{
			_url          = params.url;
			_cible        = params.cible;
			_x            = params.x;
			_y            = params.y;
			_scaleX       = params.scaleX;
			_scaleY       = params.scaleY;
			
			_req          = new URLRequest(_url)
			_channel      = new SoundChannel()
			_son          = new Sound();
			
			
			_son.load(_req);
			_son.addEventListener(Event.COMPLETE, sonCharge);
			_animation = new Anim();
			_animation.x = _x;
			_animation.y = _y;
			if(_scaleX !=0 || _scaleY!=0){
				_animation.scaleX = _scaleY;
				_animation.scaleY = _scaleY;
			}
			_cible.addChild(_animation);
			_animation.zone.addEventListener('click',muted);
			
			//Ajout de code sur les frames 1 et 20
			_animation.addFrameScript(0, frame01);
			_animation.addFrameScript(19, frame20);
		}
		private function frame01():void{
			_animation.stop();
			if(_channel.soundTransform.volume==0)
			{
				_animation.zone.addEventListener('click',muted);
				trace('frame1 volume:'+_channel.soundTransform.volume);
				_channel = _son.play(_positionSon);
				trace('son ::: '+_son);
				anim({elem:_balle, positionX:0, positionY:MAX_Y, delay:Math.random()* (.5 - 1.5)+1.5, ease:Bounce.easeOut, etat:'on'});
				TweenMax.to(_channel, 1, {volume:1, onComplete:function(){__init2();}});
			}
		}
		private function frame20():void{
			_animation.stop();
			_animation.zone.addEventListener('click',activSon);
			
		}
		private function activSon(me:MouseEvent):void{
			if(me.target===_animation.zone){
				_animation.gotoAndPlay('sonOn');
				_animation.zone.removeEventListener('click',activSon);
			}
		}
		private function __init():void{
			trace("initialisation...");
			_rond         = new Sprite();
			_balle        = new MovieClip();
			
			_rond.graphics.beginFill(0x333333,1);
			_rond.graphics.drawCircle(5,5,5);
			_rond.graphics.endFill();
			
			_balle.addChild(_rond);
			_animation.addChild(_balle);
			affichageElem(_balle,1,.5);
			_balle.mouseEnabled=false;
		}
		private function __init2():void{
			trace("initialisation2...");
			affichageElem(_balle,1,1);
		}
		private function affichageElem(_elem:MovieClip=null, _alpha:int=1, $durre:int=1):void
		{
			TweenMax.to(_elem,$durre,{alpha:_alpha,ease:Sine.easeOut});
		}
		private function anim(params:Object):void
		{
			_elem       = params.elem,
			_positionX  = params.positionX,
			_positionY  = params.positionY,
			_delay      = params.delay,
			_ease       = params.ease,
			_etat       = params.etat,
			_alpha      = params.alpha,
		    _activeTint = params.activeTint,
			_tint       = params.tint
			
			_etat = _etat;
			if(_etat==='on')
			{
				_elem.x = _positionX;
				trace('état on', _elem)
				if(!_activeTint)
				{
					_tween = TweenMax.to(_elem, _delay,{alpha:_alpha,y:_positionY, tint:0xFF6600, ease:_ease, onComplete:relance, onCompleteParams:[ _elem , Math.round(Math.random()* (POS_X.length-1))]});
				}else{
					_tween = TweenMax.to(_elem, _delay,{alpha:_alpha,y:MAX_Y, tint:0xFF6600,tint:_tint, ease:_ease, onComplete:relance, onCompleteParams:[ _elem , Math.round(Math.random()* (POS_X.length-1))]});	
				}
			}else{
				if(!_activeTint){
					_tween = TweenMax.to(_elem, _delay,{alpha:_alpha,y:MAX_Y, tint:0xFF6600, ease:_ease});
				}else{
					_tween = TweenMax.to(_elem, _delay,{alpha:_alpha,y:MAX_Y, tint:0xFF6600,tint:_tint, ease:_ease});	
				}
				
			}
				
		}
		private function relance($elem:MovieClip=null,$indexX:int=0):void{
			trace('test');
			if($elem && _etat==='on'){
				trace('relance si elem vaut true');
				trace('indexX : '+$indexX);
				//anim(_elem, POS_X[$indexX],0,0,Sine.easeOut,'off',0,true,0x333333)
				_tween = TweenMax.to($elem,0,{y:0,tint:0x333333})
				anim({elem:$elem, positionX:POS_X[$indexX], positionY:MAX_Y, delay:Math.random()* (.5 - 1.5)+1.5, ease:Bounce.easeOut,etat:'on',alpha:1});
				TweenMax.to(_animation.getChildByName('ballG'+$indexX),.5,{delay:.5,tint:0xFF6600,ease:Sine.easeOut});
				TweenMax.to(_animation.getChildByName('ballG'+$indexX),.5,{delay:1,tint:0x333333,ease:Sine.easeIn});
			}
		}
		private function muted(me:MouseEvent):void
		{
			if(me.target===_animation.zone){
				anim({elem:_balle,positionX:0 , positionY:MAX_Y, delay:.5, ease:Bounce, etat:'off'});
				affichageElem(_balle,0,.5);
				_animation.gotoAndPlay('mute');
				TweenMax.to(_channel, 1, {volume:0, onComplete:function(){
																			_positionSon = _channel.position;
																			trace('_positionSonition audio:'+_positionSon);
																			_channel.stop();
																			trace('stop sound');
																			_animation.zone.removeEventListener('click',muted);
																		}});
			}
		}
		private function sonCharge(e:Event):void
		{
			_longueurSon  = _son.length
			if(!_balle){__init();}else{__init2();}
			relance(_balle,0);
			_channel = _son.play(_positionSon);
			_channel.soundTransform.volume = 1;
			_channel.addEventListener(Event.SOUND_COMPLETE,sonboucle);
		}
		private function sonboucle(e:Event){
			trace('bouclage du _son');
			replay()
		}
		private function replay():void{
			_channel = _son.play(_positionSon);
			_channel.addEventListener(Event.SOUND_COMPLETE,sonboucle);
		}
	}
}
