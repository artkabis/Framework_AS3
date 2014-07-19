package fr.artkabis.display 
{
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Shape;	
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.geom.Matrix;

	/**
	 *	A MovieClip that will automatically create a reflet effect
	 *	of the content that is currently being displayed.
	 *	
	 * 	@langversion ActionScript 3
	 *	@playerversion Flash 9.0.0
	 *
	 *	@author Rich Perez
	 */
	public class ReflectionClip1 extends MovieClip 
	{
		private var _cible:DisplayObject;
		private var _animer:Boolean;
		private var _bitmapData:BitmapData;
		private var _cibleHeight:Number;
		private var _degradeMask:DisplayObject;
		private var _reflet:Bitmap;
		private var _forceReflet:Number;
		private var _espacement:Number;
		
		/**
		 *	@Constructor
		 */
		public function ReflectionClip()
		{
			this._init();
		}
		
		//
		// accessors
		//
		
		/**
		*	Gets and Sets a flag if the content has an animating timeline or not. 
		*	If the value is set to true then the reflet will be updated on 
		*	every frame. By Default this is set to false.
		*	
		*	@param animated
		*		A boolean to determine if there the content is animated or not.
		*/
		public function set animer($animer:Boolean):void
		{
			if (this._animer == $animer) return;
			this._animer = $animer;
			
			this.addEventListener(Event.ENTER_FRAME, this._enterFrameHandler);
		}
		public function get animer():Boolean
		{
			return this._animer;
		}

		/**
		*	Gets and Sets the content for the ReflectionClip. This is what the reflet will be based on.
		*	
		*	@param content
		*		Any DisplayObject that will serve as the content of the ReflectionClip.
		*/
		public function set cible($cible:DisplayObject):void 
		{
			if (_cible as DisplayObject) 
			{
				this._cible = $cible;				
				this.addChild(this._cible);
				
				if (!this.degradeMask) this.degradeMask = this._creerDefautMaskDegrade();
				this.update();
			}
			else
			{
				throw new Error('ReflectionClip only accepts a DisplayObject.');
			}			

			this.update();
		}
		public function get cible():DisplayObject
		{
			return this._cible;
		}

		/**
		 * 	Gets and Sets the height of the content. This is used to automatically position 
		 * 	the reflet. By default this is current height of the content.
		 * 
		 * 	@param cibleHeight
		 * 		The height to use for the content.
		 * 	
		 */
		public function get cibleHeight():Number
		{
			return isNaN(this._cibleHeight) ? this._cible.height : this._cibleHeight;
		}
		public function set cibleHeight($cibleHeight:Number):void
		{
			this._cibleHeight = $cibleHeight;
			this.update();
		}

		/**
		*	Gets and Sets the degradeMask to be used as the mask that will be used in order to create the 
		*	reflet effect.
		*	
		*	@param degradeMask
		*		Any DisplayObject that will be used as a mask.
		*/
		public function set degradeMask($degradeMask:DisplayObject):void 
		{
			if (this._degradeMask) this.removeChild(this._degradeMask);
			this._degradeMask = $degradeMask;
			this.addChild(this._degradeMask);

			this.update();
		}
		public function get degradeMask():DisplayObject
		{
			return this._degradeMask;
		}
				
		/**
		*	Gets and Sets a filter to be used on the reflet. This takes
		* 	an array of BitmapFilter objects and applys them to the reflet
		* 	DisplayObject. By default there are no filters applied.
		* 
		* 	@param array
		* 		An array of BitmapFilter objects.
		*/
		public function set refletFilters($array:Array):void
		{
			this._reflet.filters = $array || [];
		}
		public function get refletFilters():Array
		{
			return this._reflet.filters;
		}

				
		/**
		*	Gets and Sets the strength of the reflet. This is set based on a value of 0 to 1.
		*	By default this is set to 1.
		*	
		*	@param strength	
		*	
		*/
		public function set forceReflet($force:Number):void
		{
			this._forceReflet = $force;
			this.update();
		}
		public function get forceReflet():Number
		{
			return this._forceReflet;
		}

		/**
		*	Gets and Sets the espacement between the content and the reflet.
		*	
		*	@param espacement
		*		The espacement between the content and reflet.	
		*/
		public function set espacement($espacement:Number):void
		{
			if (espacement < 0) throw new Error('Spacing must be a positive number.');
			
			this._espacement = $espacement;
			this.update();
		}
		public function get espacement():Number
		{
			return this._espacement;
		}
				
		//
		// public functions
		//
		
		/**
		*	Updates the current display of the ReflectionClip.
		*/
		public function update():void
		{
			this._update();
		}
		
		//
		// private functions
		//
	
		/**
		 * 	Creates a default gradient shape to use as a mask if there is none found.
		 * 
		 * 	@return Shape
		 */
		private function _creerDefautMaskDegrade():Shape
		{
			var width:Number = this._cible.width;
			var height:Number = this.cibleHeight;
		
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(width, height, Math.PI / 2);

			var shape:Shape = new Shape();
			shape.graphics.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xFFFFFF], [1, 0], [0, height / 2], matrix);

			shape.graphics.drawRect(0, 0, width, height);
			shape.graphics.endFill();
					
			return shape;
		}
		private function _creerReflection():void
		{
			this._bitmapData = new BitmapData(this._cible.width, this.cibleHeight, true, 0x000000);
			this._bitmapData.draw(this._cible);
			this._reflet.bitmapData = this._bitmapData;
		}
		private function _enterFrameHandler(event:Event):void
		{			
			this._creerReflection();
		}
		private function _init():void
		{
			this._reflet = new Bitmap();
			this._reflet.smoothing = true;
			this.addChildAt(this._reflet, 0);			
	
			this.refletFilters = [];
			this.forceReflet = 1;
			this.espacement = 0;
			this._animer = false;
			
			this._cible = this.getChildByName('_cible') as DisplayObject || null;
			
			this._degradeMask = this.getChildByName('_mask') as MovieClip;
			if (!this._degradeMask)
			{
				for (var i:int = 0; i < this.numChildren; i++)
				{
					this._degradeMask = this.getChildAt(i) as Shape;
					if (this._degradeMask) break;
				}
			}
			
			if (this.cible)
			{
				if (!this.degradeMask) this.degradeMask = this._creerDefautMaskDegrade();
				this.update();
			}
		}
		private function _maskReflection():void
		{						
			this._degradeMask.y = this.cibleHeight + this._espacement;
					
			this._degradeMask.cacheAsBitmap = 
			this._reflet.cacheAsBitmap = true;
			this._reflet.mask = this._degradeMask;
		}
		
		private function _update():void
		{
			if (!this.cible && !this.degradeMask) return;
			
			this._cible.x = 
			this._cible.y = 0;
			
			this._creerReflection();

			this._reflet.x = this._cible.x;
			this._reflet.y = this.cibleHeight * 2 + this._espacement;

			this._reflet.alpha = this._forceReflet;
			this._reflet.rotation = 180;
			this._reflet.scaleX = -1;
		
			this._maskReflection();
		}
	}
}