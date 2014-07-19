package fr.artkabis.utils   
 {  
     import flash.display.Loader;  
     import flash.display.Sprite;  
     import flash.display.StageAlign;  
     import flash.display.StageScaleMode;  
     import flash.events.Event;  
     import flash.net.URLRequest;  
   
   
     public class Embed extends Sprite   
     {  
   
         private var fontSWF : Loader;  
   
         public function Embed()   
         {  
            configScene( );  
            chargPolices( );  
         }  
   
         private function configScene() : void   
         {  
             stage.align = StageAlign.TOP_LEFT;  
             stage.scaleMode = StageScaleMode.NO_SCALE;  
         }  
   
         private function chargPolices() : void   
         {  
             fontSWF = new Loader( );  
             fontSWF.contentLoaderInfo.addEventListener( Event.COMPLETE, policeCharges );
			 fontSWF.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, erreurChargement ); 
             fontSWF.load( new URLRequest( "/fonts/librairieFonts.swf" ) );  
         }  
   
         private function policeCharges(event : Event) : void   
         {  
             fontSWF.contentLoaderInfo.removeEventListener( Event.COMPLETE, onFontsLoaded );  
             init( );  
         }  
		 private function erreurChargement (ie:IOErrorEvent):void
		 {
			 var txt:TextField = new TextField();
			 txt.text = 'Erreur de chargement des polices !!!';
			 this.addChild( txt );
		 }
   
         protected function init() : void   
         {  
             trace( "Polices chargées !!!!" );  
         }  
     }  
 } 