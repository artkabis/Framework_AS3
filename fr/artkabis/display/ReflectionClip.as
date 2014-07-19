package fr.artkabis.display{
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
	 *	A MovieClip that will automatically create a reflection effect
	 *	of the content that is currently being displayed.
	 *	
	 * 	@langversion ActionScript 3
	 *	@playerversion Flash 9.0.0
	 *
	 *	@author Rich Perez
	 */
	public class ReflectionClip extends MovieClip 
	{
		private var __content:DisplayObject;
		private var _animated:Boolean;
		private var _bitmapData:BitmapData;
		private var _contentHeight:Number;
		private var _gradientMask:DisplayObject;
		private var _reflection:Bitmap;
		private var _reflectionStrength:Number;
		private var _spacing:Number;
		
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
		*	If the value is set to true then the reflection will be updated on 
		*	every frame. By Default this is set to false.
		*	
		*	@param animated
		*		A boolean to determine if there the content is animated or not.
		*/
		public function set animated(animated:Boolean):void
		{
			if (this._animated == animated) return;
			this._animated = animated;
			
			this.addEventListener(Event.ENTER_FRAME, this._enterFrameHandler);
		}
		public function get animated():Boolean
		{
			return this._animated;
		}

		/**
		*	Gets and Sets the content for the ReflectionClip. This is what the reflection will be based on.
		*	
		*	@param content
		*		Any DisplayObject that will serve as the content of the ReflectionClip.
		*/
		public function set content(content:DisplayObject):void 
		{
			if (content as DisplayObject) 
			{
				this.__content = content;				
				this.addChild(this.__content);
				
				if (!this.gradientMask) this.gradientMask = this._createDefaultGradientMask();
				this.update();
			}
			else
			{
				throw new Error('ReflectionClip only accepts a DisplayObject.');
			}			

			this.update();
		}
		public function get content():DisplayObject
		{
			return this.__content;
		}

		/**
		 * 	Gets and Sets the height of the content. This is used to automatically position 
		 * 	the reflection. By default this is current height of the content.
		 * 
		 * 	@param contentHeight
		 * 		The height to use for the content.
		 * 	
		 */
		public function get contentHeight():Number
		{
			return isNaN(this._contentHeight) ? this.__content.height : this._contentHeight;
		}
		public function set contentHeight(contentHeight:Number):void
		{
			this._contentHeight = contentHeight;
			this.update();
		}

		/**
		*	Gets and Sets the gradientMask to be used as the mask that will be used in order to create the 
		*	reflection effect.
		*	
		*	@param gradientMask
		*		Any DisplayObject that will be used as a mask.
		*/
		public function set gradientMask(gradientMask:DisplayObject):void 
		{
			if (this._gradientMask) this.removeChild(this._gradientMask);
			this._gradientMask = gradientMask;
			this.addChild(this._gradientMask);

			this.update();
		}
		public function get gradientMask():DisplayObject
		{
			return this._gradientMask;
		}
				
		/**
		*	Gets and Sets a filter to be used on the reflection. This takes
		* 	an array of BitmapFilter objects and applys them to the reflection
		* 	DisplayObject. By default there are no filters applied.
		* 
		* 	@param array
		* 		An array of BitmapFilter objects.
		*/
		public function set reflectionFilters(array:Array):void
		{
			this._reflection.filters = array || [];
		}
		public function get reflectionFilters():Array
		{
			return this._reflection.filters;
		}

				
		/**
		*	Gets and Sets the strength of the reflection. This is set based on a value of 0 to 1.
		*	By default this is set to 1.
		*	
		*	@param strength	
		*	
		*/
		public function set reflectionStrength(strength:Number):void
		{
			this._reflectionStrength = strength;
			this.update();
		}
		public function get reflectionStrength():Number
		{
			return this._reflectionStrength;
		}

		/**
		*	Gets and Sets the spacing between the content and the reflection.
		*	
		*	@param spacing
		*		The spacing between the content and reflection.	
		*/
		public function set spacing(spacing:Number):void
		{
			if (spacing < 0) throw new Error('Spacing must be a positive number.');
			
			this._spacing = spacing;
			this.update();
		}
		public function get spacing():Number
		{
			return this._spacing;
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
		private function _createDefaultGradientMask():Shape
		{
			var width:Number = this.content.width;
			var height:Number = this.contentHeight;
		
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(width, height, Math.PI / 2);

			var shape:Shape = new Shape();
			shape.graphics.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xFFFFFF], [1, 0], [0, height / 2], matrix);

			shape.graphics.drawRect(0, 0, width, height);
			shape.graphics.endFill();
					
			return shape;
		}
		
		/**
		*	@private
		*/
		private function _createReflection():void
		{
			this._bitmapData = new BitmapData(this.__content.width, this.contentHeight, true, 0x000000);
			this._bitmapData.draw(this.__content);
			this._reflection.bitmapData = this._bitmapData;
		}
	
		
		/**
		*	Invoked on every frame creating a new reflection.
		*	
		*	@param event	
		*/
		private function _enterFrameHandler(event:Event):void
		{			
			this._createReflection();
		}
				
		/**
		 * 
		 * 
		 */
		private function _init():void
		{
			this._reflection = new Bitmap();
			this._reflection.smoothing = true;
			this.addChildAt(this._reflection, 0);			
	
			this.reflectionFilters = [];
			this.reflectionStrength = 1;
			this.spacing = 0;
			this._animated = false;
			
			this.__content = this.getChildByName('_content') as DisplayObject || null;
			
			this._gradientMask = this.getChildByName('_mask') as MovieClip;
			if (!this._gradientMask)
			{
				for (var i:int = 0; i < this.numChildren; i++)
				{
					this._gradientMask = this.getChildAt(i) as Shape;
					if (this._gradientMask) break;
				}
			}
			
			if (this.content)
			{
				if (!this.gradientMask) this.gradientMask = this._createDefaultGradientMask();
				this.update();
			}
		}
	
		/**
		*	@private
		*/
		private function _maskReflection():void
		{						
			this._gradientMask.y = this.contentHeight + this._spacing;
			this._gradientMask.cacheAsBitmap = 
			this._reflection.cacheAsBitmap = true;
			this._reflection.mask = this._gradientMask;
		}		
		
		/**	
		*	Sets the position and placement of the content. Then it creates a 
		*	reflection and masks it with the gradientMask mask.
		*/
		private function _update():void
		{
			if (!this.content && !this.gradientMask) return;
			
			this.__content.x = 
			this.__content.y = 0;
			
			this._createReflection();

			this._reflection.x = this.__content.x;
			this._reflection.y = this.contentHeight * 2 + this._spacing;

			this._reflection.alpha = this._reflectionStrength;
			this._reflection.rotation = 180;
			this._reflection.scaleX = -1;
		
			this._maskReflection();
		}
	}
}