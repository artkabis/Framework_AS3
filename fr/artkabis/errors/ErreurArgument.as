package fr.artkabis.errors {
	import ArgumentError;
	
	public class ErreurArgument extends ArgumentError {
		
		public function ErreurArgument(param:String = null) {
			super((param == null) ? 'Vous avez passé un argument avec un  type erroné pour cette méthode."' : 'Le  type d\'argument adopté pour le paramètre' + param + 'n\'est pas autorisé par cette méthode.');
		}
	}
}