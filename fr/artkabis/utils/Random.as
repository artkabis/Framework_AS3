package fr.artkabis.utils
{
	public class Random 
	{
		public function Random(){}
		public static function value($min:Number,$max:Number):Number
		{
		  if(isNaN($min))
		  {
			throw new Error("la valeur minimum n'a pas été défini");
		  }
		  if(isNaN($max))
		  {
			throw new Error("la valeur maximum n'a pas été défini");
		  }
		  return Math.round(Math.random() * ($max - $min)) + $min;
		}
	}
}