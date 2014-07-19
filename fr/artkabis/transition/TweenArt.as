package fr.artkabis.transition
{
	
	public class TweenArt extends SuperTween
	{
		public var P:*;
		public function TweenArt(props:Object):void
		{
			super(props);
			P = props;
		}
/*		override public function del($tween:SuperTween):void
		{
			super.remove(null);
			trace(this);
		}
*/	}
}