package fr.artkabis.math
{
	public class Math 
	{
		public function Math(){}
		
		public function random( $min:Number, $max:Number ):Number
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
	}
}