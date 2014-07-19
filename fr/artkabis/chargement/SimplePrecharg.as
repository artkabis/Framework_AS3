package fr.artkabis.utils
{
	public class Precharge extends MovieClip
	{	
		private var filtre:GlowFilter;
		private var barre_charg:MovieClip = new MovieClip();
		private var chargement:TextField = new TextField();
		private var barr:Shape = new Shape();
		
		public function Precharg()
		stop();
		filtre = new GlowFilter(0x65FF00, 1, 10, 10, 1, 3, false, false);
		addChild (barre_charg);
		
		chargement.textColor = 0x65FF00;
		chargement.width=28;
		addChild(chargement);
		
		
		barr.graphics.beginFill(0x65FF00); 
		barr.graphics.drawRect(0,stage.stageHeight/2, 2,4); 
		barre_charg.addChild(barr);
		barre_charg.filters = [filtre]
		
		this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, chargement_progress);   
		this.loaderInfo.addEventListener(Event.COMPLETE, chargement_termine); 
		this.loaderInfo.addEventListener(IOErrorEvent.IOError, erreur); 
		}	
		private function chargement_progress(e:ProgressEvent):void {   
			var pourcentage:int = Math.round(e.bytesLoaded / e.bytesTotal * 100);   
			chargement.text = pourcentage + "%"; 
			chargement.y = (stage.stageHeight/2)-8;
			chargement.x = barre_charg.x + barre_charg.width+5;
			barre_charg.width = stage.stageWidth /100 * pourcentage;   
		}   
		  
		private function chargement_termine(event:Event):void {   
			this.loaderInfo.removeEventListener(ProgressEvent.PROGRESS, chargement_progress);   
			this.loaderInfo.removeEventListener(Event.COMPLETE, chargement_termine);  
			removeChild( chargement );
			chargement = null;
			removeChild( barre_charg );
			barre_charg = null;
			play();   
		}
		private function erreur(e:Event):void{
			chargement.text="erreur!";
		}
}