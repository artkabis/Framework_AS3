package fr.artkabis.transition
{
	import gs.TweenMax;
	import flash.display.MovieClip;
	
	class SuperClass 
	{
		public var objets:Array;
		public var Duree:Number;
		public var RotY:Number;
		public var RotX:Number;
		public var RotZ:Number;
		private var nbObj:int;
		private var mcDefaut:MovieClip;
		
		public function SuperClass(props:Object):void
		{
			trace();
			objets           = (props.objets === undefined) ? objets = new Array(mcDefaut = new MovieClip()) : objets = props.objets;
			Duree            = (props.Duree  === undefined) ? Duree  = 1 : Duree =  props.Duree;
			RotY             = (props.RotY   === undefined) ? RotY   = 0 : RotY  =  props.RotY;
			RotX             = (props.RotX   === undefined) ? RotX   = 0 : RotX  =  props.RotX;
			RotZ             = (props.RotZ   === undefined) ? RotZ   = 0 : RotZ  =  props.RotZ;
			nbObj            = (nbObj==0)                   ? nbObj  = 0 : nbObj =  objets.length;
			
			trace ('objets' + objets + '::::' + 'duree' + Duree + '::::' + 'RotY' + RotY + '::::' + 'RotX' + RotX + '::::' + 'RotZ'+RotZ);
			tournoyer(props);
		}
		private function tournoyer(props:Object):void
		{
			
			for( var i:uint=0; i<objets.length; i++ )
			{
				TweenMax.to(objets[i],Duree,{rotationY:RotY,rotationX:RotX,rotationZ:RotZ});
				trace('objets='+objets+'::'+'Duree='+Duree);
			}
		}
	}
	
}