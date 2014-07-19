package fr.artkabis.ui
{
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer; 
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.MouseEvent;
	
	import flash.display.MovieClip;
	
	public class Lecteur extends MovieClip
	{
		//______________________○○○ Actions Lecteur mp3○○○___________________________
		private var getMusic:URLRequest;
		private var music:Sound;
		private var soundChannel:SoundChannel;
		private var currentSound:Sound;
		private var pos:Number;
		private var currentIndex:Number;
		private var songPlaying:Boolean;
		private var xml:XML;
		private var songlist:XMLList;
		private var posLecteur:Boolean;
		private var lecteurX:Number;
		private var volum:SoundTransform;
		private var activPlay:int;
		
		public function Lecteur():void
		{
			music          =    new Sound();
			volum          =    new SoundTransform();
			currentSound   =    music;
			currentIndex   =    0;
			lecteurX       =    this.x;
			activPlay      =    0;
			
			/*-------------------chargement XML ------------------------*/
			/*----------------------------------------------------------*/
			var loader:URLLoader = new URLLoader( ); //création d'un nouvel objet URLLoader 
			loader.addEventListener( Event.COMPLETE, chargComplet ); //Ecoute du chargement complété 
			loader.load(new URLRequest( "xml/musiques.xml" ) ); //chargement du  fichier xml contenant les informations sonore
			muteoff.mouseEnabled=false;
			mute.buttonMode = true;
			
			/*--------Gestion des bouton du lecteur----------------*/
			this.next_btn.mouseChildren = this.prev_btn.mouseChildren = this.play_btn.mouseChildren = this.pause_btn.mouseChildren = false;
			this.next_btn.buttonMode = this.prev_btn.buttonMode = this.play_btn.buttonMode = this.pause_btn.buttonMode =this.next_btn.useHandCursor = this.prev_btn.useHandCursor = this.play_btn.useHandCursor = this.pause_btn.useHandCursor =true;
			
			this.next_btn.addEventListener ( MouseEvent.CLICK, sonSuivant ); 
			this.prev_btn.addEventListener ( MouseEvent.CLICK, sonPrecedent );
			this.pause_btn.addEventListener ( MouseEvent.CLICK,sonPause );
			if(activPlay!=0)this.play_btn.addEventListener(MouseEvent.CLICK,sonPlay);
			
			
			this.addEventListener ( MouseEvent.MOUSE_OUT, $actionsMouse );
			this.addEventListener ( MouseEvent.MOUSE_OVER, $actionsMouse );
			this.addEventListener ( MouseEvent.CLICK, $actionsMouse );
			
			/*--------Son suivant----------------------------------------*/
		}		
		private function progressMusic(pe:ProgressEvent):void {
			var pct:uint = Math.round(pe.bytesLoaded/pe.bytesTotal)* 100;
			this.txtCharg.text = pct+'%';
			trace('pct:::::::::::::::::'+pct);
		}
		
		private function completeHandler(event):void {
			trace("DONE");
			}
		
		private function chargComplet( e:Event ):void 
		{
			xml = new XML(e.target.data); 
			songlist = xml.song; //on rempli la liste avec les éléments du xml
			getMusic = new URLRequest(songlist[0].url);//on attache getMusic avec le premier son du xml
			music.load(getMusic);//on charge la music
			soundChannel = music.play();//on joue le son
			this.songTXT.text = songlist[0].title; //on rempli le champ texte titre
			this.artistTXT.text = songlist[0].artist; //on rempli le champ texte artiste
			this.albumTXT.text = songlist[0].album;  //on rempli le champ texte album 
			soundChannel.addEventListener(Event.SOUND_COMPLETE, sonSuivant);//on passe à la track suivante si l'actuelle est terminé
			music.addEventListener(ProgressEvent.PROGRESS, progressMusic);
			var gestionVolume:SoundTransform = new SoundTransform();
			soundChannel.soundTransform = gestionVolume;
			songPlaying = true;
			
			this.barr_rouge.mouseEnabled = false;
			this.zoneVol.buttonMode = true;
			this.zoneVol.useHandCursor = true;
			barr_blanche.mouseEnabled = false;
			zoneVol.addEventListener(MouseEvent.MOUSE_DOWN,clicVol);
			this.parent.parent.addEventListener(MouseEvent.MOUSE_UP,declicVol);

			this.barr_rouge.mask = this.barrVol;
			this.muteoff.visible = false;
		}
		private function gestionVol(e:Event):void
		{
			this.barrVol.width = this.zoneVol.mouseX;
			soundChannel.soundTransform = volum;
			volum.volume = this.barrVol.width/100;
			SoundMixer.soundTransform = new SoundTransform(volum.volume, 1); 
			if (this.barrVol.width > 99){this.barrVol.width = 100;}
			else if(this.barrVol.width > 5){muteoff.visible = false;muteoff.mouseEnabled=false;this.muteoff.buttonMode = false;mute.mouseEnabled=true;songPlaying = true;}
			else if(this.barrVol.width < 5 && volum.volume < 5) {this.barrVol.width=5; muteoff.visible =true;this.muteoff.buttonMode = true;mute.mouseEnabled=false;muteoff.mouseEnabled=true;songPlaying = false;}
		}

		private function clicVol (me:MouseEvent):void
		{
			trace('target bt:::'+me.target.name);
			me.updateAfterEvent();
			this.addEventListener(Event.ENTER_FRAME,gestionVol);
			this.barrVol.width = this.zoneVol.mouseX;
			trace ('écouteur barre de volume ajouté');
		}
		
		private function declicVol(me:MouseEvent):void
		{
			this.removeEventListener(Event.ENTER_FRAME,gestionVol);
			trace ("ecouteur barrVol supprimé !!!");
		}
		private function sonSuivant(e:Event):void
		{
			music.addEventListener(ProgressEvent.PROGRESS, progressMusic);
			if (currentIndex < (songlist.length() - 1))currentIndex++;
			else currentIndex = 0;
		
			var nextReq:URLRequest = new URLRequest(songlist[currentIndex].url);
			var nextTitle:Sound = new Sound(nextReq);
			soundChannel.stop();
			this.songTXT.text = songlist[currentIndex].title;
			this.artistTXT.text = songlist[currentIndex].artist;
			this.albumTXT.text = songlist[currentIndex].album;
			soundChannel = nextTitle.play();
			songPlaying = true;
			currentSound = nextTitle;
			//soundChannel.addEventListener(Event.SOUND_COMPLETE, sonSuivant);
			trace(songlist[currentIndex].artist);
			trace('Next sound  volum.volume::'+volum.volume*100);
			volum.volume =  this.barrVol.width/100;
			SoundMixer.soundTransform = new SoundTransform(volum.volume, 1); 
			this.muteoff.visible = false;
		}
		
		/*--------Son précédent et accès au informations du fichier xml--------------------------*/
		 /*-------------------------------------------------------------------------------------*/
		
		function sonPrecedent(e:Event):void
		{
			music.addEventListener(ProgressEvent.PROGRESS, progressMusic)
			if (currentIndex > 0)currentIndex--;
			else currentIndex = songlist.length() - 1;
			
			var nextReq:URLRequest = new URLRequest(songlist[currentIndex].url);
			var prevTitle:Sound = new Sound(nextReq);
			soundChannel.stop();
			this.songTXT.text = songlist[currentIndex].title;
			this.artistTXT.text = songlist[currentIndex].artist;
			this.albumTXT.text = songlist[currentIndex].album;
			soundChannel = prevTitle.play();
			songPlaying = true;
			currentSound = prevTitle;
			soundChannel.addEventListener(Event.SOUND_COMPLETE, sonSuivant);
			volum.volume = this.barrVol.width/100;
			SoundMixer.soundTransform = new SoundTransform(volum.volume, 1); 
			this.muteoff.visible = false;
		}
		
		private function sonPause(e:Event):void
		{
			activPlay=1;
			pos = soundChannel.position; //mise en pause à la position actuelle de lecture
			soundChannel.stop(); //son stopé
			songPlaying = false;
			this.play_btn.addEventListener(MouseEvent.CLICK,sonPlay); 
		}
		
		private function sonPlay(e:Event):void
		{
			if(songPlaying == false) //si songPlaying vaut false ont joue la fonction
			{
				soundChannel = currentSound.play(pos); //on lis la track à la position actuelle de lecture
				soundChannel.addEventListener(Event.SOUND_COMPLETE, sonSuivant);//on passe à la track suivante si l'actuelle est terminé
				songPlaying = true; //on met songplaying sur true
				this.play_btn.removeEventListener(MouseEvent.CLICK,sonPlay);
			}
		}
		
		private function $actionsMouse (me:MouseEvent):void
		{
			switch(me.type)
			{
				case MouseEvent.MOUSE_OVER:
				if(me.target.name === 'next_btn' || me.target.name === 'prev_btn' || me.target.name === 'pause_btn' || me.target.name === 'play_btn')
				{
					me.target.gotoAndPlay('over');
				}
				break;
					
				case MouseEvent.MOUSE_OUT:
				if(me.target.name === 'next_btn' || me.target.name === 'prev_btn' || me.target.name === 'pause_btn' || me.target.name === 'play_btn')
				{
					me.target.gotoAndPlay('out');
				}
				break;
					
				case MouseEvent.CLICK:
				trace ('clic:::' + me.target.name);
				if(me.target.name === 'mute' && songPlaying === true )
				{
					this.muteoff.visible = true;
					this.muteoff.mouseEnabled=true;
					this.muteoff.buttonMode = true;
					this.mute.buttonMode = false;
					this.mute.mouseEnabled=false;
					songPlaying = false
					SoundMixer.soundTransform = new SoundTransform(0, 1); 
				}
				if(me.target.name === 'muteoff' && songPlaying === false)
				{
					activPlay=1;
					this.muteoff.visible = false;
					this.muteoff.mouseEnabled=false;
					this.muteoff.buttonMode = false;
					this.mute.buttonMode = true;
					this.mute.mouseEnabled=true;
					songPlaying = true;
					volum.volume = this.barrVol.width/100;
					SoundMixer.soundTransform = new SoundTransform(volum.volume, 1); 
				}
				break;
			}
		}
		//_____________________________________○○○ FIN○○○________________________________
	}
}
