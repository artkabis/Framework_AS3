package fr.artkabis.transition
{
	import gs.TweenMax;
	import flash.display.MovieClip;
	
	class SuperTween
	{
		
		public var Objets                                    :Array;
		public var Duree                                     :Number;
		public var Delay                                     :Number;
		public var RotY                                      :Number;
		public var RotX                                      :Number;
		public var RotZ                                      :Number;
		public var BezierOn                                  :Boolean;
		public var OrientBezier                              :Boolean;
		public var Courbe                                    :Object;
		public var tween                                     :Object;
		public var Props                                     :Object;
		
		private var nbObj                                    :int;
		private var mcDefaut                                 :MovieClip;
		
		public function SuperTween($props:Object):void
		{
			Objets           = ($props.Objets         === undefined) ? Objets = new Array(mcDefaut = new MovieClip()) : Objets = $props.Objets;
			BezierOn         = ($props.BezierOn       === false    ) ? BezierOn = false : BezierOn = $props.BezierOn; 
			OrientBezier     = ($props.OrientBezier   === undefined) ? OrientBezier = false : OrientBezier = $props.OrientBezier;
			Courbe           = ($props.Courbe         === undefined) ? Courbe = [] : Courbe =  $props.Courbe;
			Delay            = ($props.Delay          === undefined) ? Delay  = 0  : Delay  =  $props.Delay;
			Duree            = ($props.Duree          === undefined) ? Duree  = 1  : Duree  =  $props.Duree;
			RotY             = ($props.RotY           === undefined) ? RotY   = 0  : RotY   =  $props.RotY;
			RotX             = ($props.RotX           === undefined) ? RotX   = 0  : RotX   =  $props.RotX;
			RotZ             = ($props.RotZ           === undefined) ? RotZ   = 0  : RotZ   =  $props.RotZ;
			nbObj            = (nbObj                 === 0        ) ? nbObj  = 0  : nbObj  =  Objets.length;
			
			Props = $props;
			tournoyer(Props);
			
			trace ('Objets=' + Objets.toString() + '::::' + 'Duree=' + Duree.toString() + '::::' + 'Delay='+ Delay.toString() + '::::' +'RotY=' + RotY.toString() + '::::' + 'RotX=' + RotX.toString() + '::::' + 'RotZ='+ RotZ.toString() + '::::' + 'BezierOn=' + BezierOn.toString() + '::::' + 'Courbe=' + Courbe.toString() + '::::' + 'OrientBezier=' + OrientBezier.toString());
		}
		private function tournoyer($props:Object):void
		{
			for( var i:int=0; i<Objets.length; i++ )
			{
				if(!BezierOn)tween = TweenMax.to(Objets[i],Duree,{rotationY:RotY,rotationX:RotX,rotationZ:RotZ});
				else tween = TweenMax.to(Objets[i],Duree,{delay:Delay,rotationY:RotY,rotationX:RotX,rotationZ:RotZ, bezierThrough:Courbe, orientToBezier:OrientBezier});
			}
		}
/*		public static function del ($tween:SuperTween):void
		{
			if ($tween != null) {
				delete $tween;
			}		
		}
*/	}
}