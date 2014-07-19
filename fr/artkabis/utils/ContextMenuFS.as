package fr.artkabis.utils
{
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
    import flash.ui.ContextMenuBuiltInItems;
	
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;
	
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class ContextMenuFS extends MovieClip
	{
		private var cMenu                    :ContextMenu;
		private var _stage                   :Stage;
		private var _txtItem                 :String;
		private var _url                     :String;
		private var _cible                   :MovieClip
		private var _params                  :Object;
		private var _activFS                  :Boolean;
		private var menuItem0                :ContextMenuItem;
		private var menuItem1                :ContextMenuItem;
		private var menuItem2                :ContextMenuItem;
		private var params                   :Object;
		
		//==================================================================================================
		//==================================================================================================
		public function get cible():MovieClip{return _cible};
		public function set cible(pCible:MovieClip){_cible=_cible};
		//==================================================================================================
		//==================================================================================================
		public function get sceneActu():Stage{return _stage};
		public function set sceneActu(pStage:Stage){_stage=_stage};
		//==================================================================================================
		//==================================================================================================
		public function get titre():String{return _txtItem};
		public function set titre(pStage:String){_txtItem=_txtItem};
		//==================================================================================================
		//==================================================================================================
		public function get url():String{return _url};
		public function set url(pStage:String){_url=_url};
		
		//==================================================================================================
		public function ContextMenuFS(params ):void
		//==================================================================================================
		
		{
			_cible     =    params.cible;
			_stage     =    params.scene;
			_txtItem   =    params.titre;
			_url       =    params.url;
			_activFS   =    params.activFS;
			
			
			initialisation();
		}
		//==================================================================================================
		private function initialisation ():void
		//==================================================================================================
		{
			menuItem0 = new ContextMenuItem( String( _txtItem) );
			if (_activFS){
			menuItem1 = new ContextMenuItem( "On Full Screen>>" , true );
			menuItem2 = new ContextMenuItem( "Off Full Screen<<" );
			}

			
			cMenu = new ContextMenu();
			cMenu.hideBuiltInItems();
			menuItem0.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, navig );
			cMenu.customItems.push( menuItem0 );
			if(_activFS){
				menuItem1.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, onfullscreen );
				menuItem2.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, offfullscreen );
				cMenu.customItems.push( menuItem1, menuItem2 );
				menuItem1.separatorBefore = true;
			}
			_stage.addEventListener( Event.RESIZE,changeMode );
			
			
			_cible.contextMenu = cMenu;
			
		}
		//==================================================================================================
		private function navig( cm:ContextMenuEvent ):void 
		//==================================================================================================
		{
			var request:URLRequest = new URLRequest( _url );
			navigateToURL(request, '_blank');
		}
		//==================================================================================================
		private function onfullscreen( cm:ContextMenuEvent ):void 
		//==================================================================================================
		{
			trace( _stage.displayState );
			_stage.displayState = StageDisplayState.FULL_SCREEN;
			menuItem1.enabled = false;
			menuItem2.enabled = true;
		}
		//==================================================================================================
		private function offfullscreen( cm:ContextMenuEvent ):void
		//==================================================================================================
		{
			trace( _stage.displayState );
			_stage.displayState = StageDisplayState.NORMAL;
			menuItem1.enabled = true;
			menuItem2.enabled = false;
		}
		//==================================================================================================
		private function changeMode( e:Event ):void
		//==================================================================================================
		{
			if( _stage.displayState == StageDisplayState.NORMAL )
			{
				menuItem1.enabled = true;
				menuItem2.enabled = false;
			}
			if( _stage.displayState == StageDisplayState.FULL_SCREEN )
			{
				menuItem1.enabled = false;
				menuItem2.enabled = true;
			}
		}
	}
}