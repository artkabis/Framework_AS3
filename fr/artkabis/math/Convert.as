package fr.artkabis.math
{
	public class Convert 
	{
		private var _angleEnRadians:Number;
		private var _angleEnDegres:Number;
		
		public function Convert():void{}
		public function degres2radian($d:Number):Number
		{
			_angleEnRadians = $d * Math.PI/180;
			return _angleEnRadians;
		}
		public function radian2degres($r:Number):Number
		{
			_angleEnDegres  = $r * 180/Math.PI;
			return _angleEnDegres;
		}
		public function rotationTan( $x:Number=0 , $y:Number=0 ):Number
		{
			var rot:Number;
			rot = Math.atan2($y, $x)* 180 / Math.PI;
			return rot;
		}
	}
}