package fr.artkabis.maths
{
	public class MinMax 
	{
		public function MinMax(){}
		
		 public static function random( $min:Number, $max:Number ):Number
		{
		  if( isNaN($min) )
		  {
			throw new Error("la valeur minimum n'a pas été défini");
		  }
		  if( isNaN($max) )
		  {
			throw new Error("la valeur maximum n'a pas été défini");
		  }
		  return Math.round( Math.random( ) * ( $max - $min ) ) + $min;
		}
		
		public function randomArray( $tab:Array ):*
		{
			return $tab[ random( $tab.length,0 ) << 0 ];
		}
	}
}