package fr.artkabis.ui
{

	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.BlendMode;
	import flash.display.Loader;
	import flash.display.LoaderInfo;

	import flash.text.TextField;
	import flash.text.TextFormat;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;

	import flash.media.Sound;
	import flash.media.ID3Info;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	import flash.utils.Timer;
	import flash.net.URLRequest;

	public class MP3Player extends Sprite {

		//obj sound
		private var _son:Sound;
		private var _channel:SoundChannel;

		//tete de lecture
		private var _posTime:Timer;
		private var _posPiste:Number=0;

		//controles
		private var _btPlayStop:MovieClip;
		private var _btPause:MovieClip;
		private var _btVolume:MovieClip;
		private var pauseTimer:Timer;

		private var _progressBar:MovieClip;
		private var _barrePlay:MovieClip;
		private var _barreVolume:MovieClip;

		//affichage des _activeID3
		private var _txtInfo:TextField;

		public var _tagID3:ID3Info;
		public var _urlMP3:String;
		public var _activeID3:Boolean;
		
		//==============================================================================================
		public function PlayerMP3(
								  $urlMP3:String,
								  $btPlayStop:MovieClip,
								  $btPause:MovieClip,
								  $barreVolume:MovieClip,
								  $progressBar:MovieClip,
								  $barrePlay:MovieClip,
								  $txtInfo:TextField
								  ):void 
		{			
		//==============================================================================================
			_urlMP3      =  $urlMP3;
			_btPlayStop  =  $btPlayStop;
			_btPause     =  $btPause;
			_barreVolume =  $barreVolume;
			_progressBar =  $progressBar;
			_barrePlay   =  $barrePlay;
			_txtInfo     =  $txtInfo;
			
			initialisation();
		}
		//==============================================================================================
		private function initialisation()
		//==============================================================================================
		{
			(_urlMP3 == null) ? _urlMP3="defaut.mp3" :   _urlMP3 = _urlMP3;

			//_activeID3 = (parms.notag ==  null || parms.notag ==="false") ? true : false;
			_btPause.miseEnPause();
			_btVolume.GestionVolume();
			_progressBar.x=81;
			_progressBar.y=2;
			_barrePlay.x=81;
			_barrePlay.y=2;
			_barrePlay.scaleX=0;
			_barrePlay.blendMode = BlendMode.HARDLIGHT;

			/*
			* le son
			* */
			_son=new Sound();
			_son.addEventListener(Event.COMPLETE,chargeSonComplete);
			_son.addEventListener(ProgressEvent.PROGRESS,progressionSon);
			_son.addEventListener(IOErrorEvent.IO_ERROR, erreurSon);

			_btPlayStop.addEventListener(MouseEvent.MOUSE_DOWN,lectureMP3);

			if (_activeID3)_son.addEventListener(Event.ID3,gestionID3);

			/*
			* tete de lecture et pbar
			* */
			_posTime=new Timer(50);

			try {
				_son.load(new URLRequest(_urlMP3));
			} catch (error:SecurityError) {
				trace(error);
			}
		}
		//==============================================================================================
		private function lectureMP3(e:MouseEvent):void 
		//==============================================================================================
		{

			//fonctionnalités et icones des bt dans le context play
			_btPlayStop.removeEventListener(MouseEvent.MOUSE_DOWN,lectureMP3);
			_btPlayStop.addEventListener(MouseEvent.MOUSE_DOWN,stopMP3);
			_btPause.addEventListener(MouseEvent.MOUSE_DOWN,pauseMP3);

			//tete de lecture 
			_posTime.addEventListener(TimerEvent.TIMER,_posTimeHandler);
			_channel = _son.play();
			_barrePlay.removeEventListener(Event.ENTER_FRAME, fadeOutHandler);
			_barrePlay.alpha = 1;

			_channel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			setVolume();
			_btPlayStop.isBtStop();
			_posTime.start();
			_posPiste=0;
		}
		//==============================================================================================
		private function stopMP3(e:MouseEvent):void 
		//==============================================================================================
		{

			_posTime.removeEventListener(TimerEvent.TIMER,_posTimeHandler);
			_posTime.stop();

			//fonctionnalités et icones des bt dans le context stop
			_btPause.removeEventListener(MouseEvent.MOUSE_DOWN,pauseMP3);
			_btPlayStop.removeEventListener(MouseEvent.MOUSE_DOWN,stopMP3);
			_btPlayStop.addEventListener(MouseEvent.MOUSE_DOWN,lectureMP3);

			_channel.stop();

			_btPlayStop.isBtPlay();
			_btPause.isBtPause();

			//fondu alpha sur tete de lecture
			_barrePlay.addEventListener(Event.ENTER_FRAME, fadeOutHandler);
		}
		//==============================================================================================
		private function pauseMP3(e:MouseEvent):void 
		//==============================================================================================
		{
			if (e.target.TYPE=="PAUSE") {
				_channel.stop();
				_posPiste=_channel.position;
				_btPause.isBtPlay();
			} else {
				_channel=_son.play(_posPiste);
				setVolume();
				_btPause.isBtPause();
			}
		}
		//==============================================================================================
		private function erreurSon(e:IOErrorEvent):void 
		//==============================================================================================
		{
			//on affiche le msg d'erreur
			_btPlayStop.removeEventListener(MouseEvent.MOUSE_DOWN,lectureMP3);
			_posTime.stop();
			var err:String =   "   " + e.type + "   " +e.text;
			_txtInfo.text = err;
		}
		//==============================================================================================
		private function gestionID3(e:Event):void 
		//==============================================================================================
		{
			//recupere les infos 
			_tagID3 = _son.id3;
			var titreMP3:String = _tagID3.songName == null ? " " : _tagID3.songName;
			var artiste:String = _tagID3.artist == null ? " " : _tagID3.artist;
			var album:String = _tagID3.album == null ? " " : _tagID3.album;
			var annee:String = _tagID3.year == null ? " " : _tagID3.year;
			var commentaire:String = _tagID3.comment == null ? " " : _tagID3.comment;
			var genre:String = _tagID3.genre == null ? " " : _tagID3.genre;

			_txtInfo.text =  "   " + titreMP3 + "   " + artiste+  "   "  + album + "   "  + annee + "   " + commentaire +"   "+ genre ;
			_txtInfo.addEventListener(Event.ENTER_FRAME,defilementTexte);
		}
		//==============================================================================================
		private function progressionSon(e:ProgressEvent):void 
		//==============================================================================================
		{
			_progressBar.scaleX=e.bytesLoaded / e.bytesTotal;
		}
		//==============================================================================================
		private function chargeSonComplete(e:Event):void 
		//==============================================================================================
		{
			_son.close();
		}
		//==============================================================================================
		private function soundCompleteHandler(e:Event):void 
		//==============================================================================================
		{
			stopMP3(null);
		}
		//==============================================================================================
		private function _posTimeHandler(e:TimerEvent):void 
		//==============================================================================================
		{
			_barrePlay.scaleX=_channel.position / _son.length;
		}
		//==============================================================================================
		private function onSetVolume(e:MouseEvent):void 
		//==============================================================================================
		{
			_btVolume.indicator = e.localX;
			setVolume();
		}
		//==============================================================================================
		public function setVolume():void 
		//==============================================================================================
		{
			if (_channel != null) {
				var transform:SoundTransform= _channel.soundTransform;
				transform.volume = _btVolume.mouseX;
				_channel.soundTransform=transform;
			}
		}
		//==============================================================================================
		private function defilementTexte(e:Event):void 
		//==============================================================================================
		{
			_txtInfo.scrollH = _txtInfo.scrollH< _txtInfo.maxScrollH  ?   _txtInfo.scrollH+1 : _txtInfo.scrollH = 0 ;
		}
		//==============================================================================================
		private function fadeOutHandler(e:Event):void 
		//==============================================================================================
		{
			if (e.target.alpha>0) e.target.alpha-=0.1;
			else _barrePlay.removeEventListener(Event.ENTER_FRAME, fadeOutHandler);
		}
	}
}