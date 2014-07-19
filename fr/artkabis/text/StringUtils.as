package fr.artkabis.text
{

	/**
	* La classe StringUtils offre une large gamme d'outils pour manipyler vos chaines de caracteres .
	* <p>Il est possible de convertir une valeur decimale en hexadecimale,  une valeur decimale en RGB, une valeur hexadecimale en decimale, une valeur hexadecimal en RGB (red green blue), une valeur RGB en décimale et une valeur RGB en hexadecimale.</p>
	*
	*	@author			NICOLLE-Gregory - Artkabis
	*	@version		1.0
	*	@date			28.03.2010
	*	@langversion 	ActionScript 3.0
	* 	@playerversion 	Flash 10

	*	@tiptext
	*
	*	@example Dans cet exemple, vous pouvez vous rendre compte des possibilité que peut offrir cette classe. Au programme :
	*	<p><b> Capitaliser, netoyageLettre, citation, suppression, suppressionEspace, similitude, dissolutionTags,echangeLettre, compteurMots, tronquage, etc </b><p>
	* 
	*
	* <listing version="1.0">
	*	import fr.artkabis.text.StringUtils
	*	
	*	
	*	var strg  :String = "Codons un peu! Ici c'est le coin du developpeur.     Allez hop !!!"                       ;
	*	var strg2 :String = "Ne codons plus!!! Ici c'est le coin des fégnasses.     Allez zou !!!"                     ;
	*	var strg3 :String = "<code>Ne codons plus! Ici c'est le coin des fégnasses.     Allez zou !!!</code>"          ;
	*	var strg4 :String = "           Ne codons plus! Ici c'est le coin des fégnasses.     Allez zou !!!            ";
	*
	*	trace("apresPremiere : " + StringUtils.apresPremiere(strg,"l"));
	*	trace("apresDerniere : " + StringUtils.apresDerniere(strg,"l"));
	*	trace("commencePar : " + StringUtils.commencePar(strg,"C"));
	*	trace("avantPremiere : " + StringUtils.avantPremiere(strg,"l"));
	*	trace("avantDerniere : " + StringUtils.avantDerniere(strg,"l"));
	*	trace("entre : " + StringUtils.entre(strg,"s","t"));
	*	trace("block : " + StringUtils.block(strg, 0, "."));
	*	trace("capitaliser : " + StringUtils.capitaliser(strg, false));
	*	trace("comporte : " + StringUtils.comporte(strg, '!'));
	*	trace("compteurLettre : " + StringUtils.compteurLettre(strg, 'e', true));
	*	trace("padLeft : " + StringUtils.padLeft(strg, '.', 4));
	*	trace("padRight : " + StringUtils.padRight(strg, '.', 9));
	*	trace("nettoieLettre : " + StringUtils.nettoieLettre(strg));
	*	trace("citer : " + StringUtils.citer(strg));
	*	trace("supprime : " + StringUtils.supprime(strg,'Allez hop',true));
	*	trace("supprimeBigespace : " + StringUtils.supprimeBigEspace(strg));
	*	trace("similitude : " +  StringUtils.similitude(strg, strg2)+'%');
	*	trace("dissoutTags : " +  StringUtils.dissoutTags(strg3));
	*	trace("echangeLettre : " +  StringUtils.echangeLettre(strg4));
	*	trace("suppEspaceExtremite : " +  StringUtils.SuppEspaceExtremite(strg3));
	*	trace("suppEspaceGauche : " +  StringUtils.SuppEspaceGauche(strg3));
	*	trace("suppEspaceDroite : " +  StringUtils.SuppEspaceDroite(strg3));
	*	trace("compteurMots : " +  StringUtils.compteurMots(strg));
	*	trace("tronquer : " +  StringUtils.tronquer(strg2, 20, "!!!"));	
	* </listing>
	**/

	public class StringUtils {

		/**
		*	Returns everything after the first occurrence of the provided character in the string.
		*
		*	@param $string La chaine de caractère.
		*
		*	@param $letterStart The character or sub-string.
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*
		*
		*/
		
		/**
		* Recuperation du contenu de la chaine situé après la lettre passé en deuxième paramètre depuis le debut de la chaine.
		* @param $string		Chaine de caractère 
		* @param $caracteres	Caractere de decoupe
		**/
		public static function apresPremiere($string:String, $caracteres:String):String {
			if ($string == null) { return ''; }
			var idx:int = $string.indexOf($caracteres);
			if (idx == -1) { return ''; }
			idx += $caracteres.length;
			return $string.substr(idx);
		}

		/**
		*   Renvoi le contenu de la chaine situé avant la lettre passé en deuxième paramètre depuis la fin de la chaine.
		* 	@param $string		Chaine de caractère 
		*	@param $caracteres	Caractere de decoupe
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function apresDerniere($string:String, $caracteres:String):String {
			if ($string == null) { return ''; }
			var idx:int = $string.lastIndexOf($caracteres);
			if (idx == -1) { return ''; }
			idx += $caracteres.length;
			return $string.substr(idx);
		}

		/**
		*   Verifie si la premiere lettre de la chaine correspond au second paramtre.
		* 	@param $string		Chaine de caractère 
		*	@param $letterStart	Caractere de comparaison
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function commencePar($string:String, $letterStart:String):Boolean {
			if ($string == null) { return false; }
			return $string.indexOf($letterStart) == 0;
		}

		/**
		*	Returns everything before the first occurrence of the provided character in the string.
		*
		*	@param $string La  chaine de caractère comparative.
		*
		*	@param $letterStart The character or sub-string.
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function avantPremiere($string:String, $caracteres:String):String {
			if ($string == null) { return ''; }
			var idx:int = $string.indexOf($caracteres);
        	if (idx == -1) { return ''; }
        	return $string.substr(0, idx);
		}

		/**
		*	Returns everything before the last occurrence of the provided character in the string.
		*
		*	@param $string La  chaine de caractère comparative.
		*
		*	@param $letterStart The character or sub-string.
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function avantDerniere($string:String, $caracteres:String):String {
			if ($string == null) { return ''; }
			var idx:int = $string.lastIndexOf($caracteres);
        	if (idx == -1) { return ''; }
        	return $string.substr(0, idx);
		}

		/**
		*	Returns everything after the first occurance of $start and before
		*	the first occurrence of $fin in $string.
		*
		*	@param $string La  chaine de caractère comparative.
		*
		*	@param $start The character or sub-string to use as the start index.
		*
		*	@param $fin The character or sub-string to use as the end index.
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function entre($string:String, $start:String, $fin:String):String {
			var str:String = '';
			if ($string == null) { return str; }
			var startIdx:int = $string.indexOf($start);
			if (startIdx != -1) {
				startIdx += $start.length; // RM: should we support multiple chars? (or ++startIdx);
				var endIdx:int = $string.indexOf($fin, startIdx);
				if (endIdx != -1) { str = $string.substr(startIdx, endIdx-startIdx); }
			}
			return str;
		}

		/**
		*	Méthode utilitaire qui rompt intelligemment votre chaîne, vous permettant de créer des blocs de texte lisible. 
		*	Cette méthode renvoie la correspondance la plus proche possible en fonction du paramètre $limite et ceci tout en gardant la longueur du texte via le paramter $longueur. 
		*	Si un match ne peut être trouvé dans la longueur spécifié un'...' est ajouté au bloc et le blocage se poursuit jusqu'à ce que tout le texte est été divisé ".
		*
		*	@param $string La  chaine de caractère à briser.
		*
		*	@param $longueur  longueur maximum de chaque bloc de texte.
		*
		*	@param $limite delimter la longueur de  fin des blocs de texte, par défaut '.' est utilisé
		*
		*	@returns Array
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function  block ( $string:String="" , $longueur:uint=1 , $limite:String = "." ):Array {
			if ( $longueur < 1 ){  $longueur=1;}else{$longueur=$longueur;}
			var arr:Array = new Array();
			if ($string == null || !comporte($string, $limite)) { return arr; }
			var chrIndex:uint = 0;
			var strLen:uint = $string.length;
			var replPatt:RegExp = new RegExp("[^"+modelEchapement($limite)+"]+$");
			while (chrIndex <  strLen) {
				var subString:String = $string.substr(chrIndex, $longueur);
				if (!comporte(subString, $limite)){
					arr.push(tronquer(subString, subString.length));
					chrIndex += subString.length;
				}
				subString = subString.replace(replPatt, '');
				arr.push(subString);
				chrIndex += subString.length;
			}
			return arr;
		}

		/**
		*	Capitallizes le premier mot  ou tous les mots d'une chaîne..
		*
		*	@param $string La  chaine de caractère comparative.
		*
		*	@param $all (optionel) Valeur booléenne indiquant si  tous les mots sont à capitaliser ou seulement le premier.
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function capitaliser($string:String, ...args):String {
			var str:String = SuppEspaceGauche($string);
			trace('capl', args[0])
			if (args[0] === true) { return str.replace(/^.|\b./g, _majuscule);}
			else { return str.replace(/(^\w)/, _majuscule); }
		}

		/**
		*	Determines si un caractère est présent dans la chaine au moins une fois
		*
		*	@param $string La  chaine de caractère comparative.
		*
		*	@param $caracteres Caractère ou sous-chaine présent dans la chaine.
		*
		*	@returns Boolean
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function comporte($string:String, $caracteres:String):Boolean {
			if ($string == null) { return false; }
			return $string.indexOf($caracteres) != -1;
		}

		/**
		*	Détermine le nombre de fois où un charactère ou une sous-chaîne apparaît dans la chaîne.
		*
		*	@param $string La  chaine de caractère comparative.
		*
		*	@param $caracteres Caractère ou sous-chaine à comptabiliser.
		*
		*	@param $caseSensitive (optionel, true par défaut) Un booléen pour indiquer si la recherche est sensible à la casse
		*
		*	@returns uint
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function compteurLettre($string:String, $caracteres:String, $caseSensible:Boolean = true):uint {
			if ($string == null) { return 0; }
			var char:String = modelEchapement($caracteres);
			var flags:String = (!$caseSensible) ? 'ig' : 'g';
			return $string.match(new RegExp(char, flags)).length;
		}

		/**
		*	Levenshtein distance (editeur de distance) est une mesure utilisé pour détérminer les similitudes entre les deux chaînes, 
		*	La distance est le nombre de suppressions, insertions ou des substitutions nécessaires pour transformer  $source en $cible.
		*
		*	@param $source La source de la chaine.
		*
		*	@param $cible La cible de la chaine.
		*
		*	@returns uint
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function editDistance($source:String, $cible:String):uint {
			var i:uint;

			if ($source == null) { $source = ''; }
			if ($cible == null) { $cible = ''; }

			if ($source == $cible) { return 0; }

			var d:Array = new Array();
			var cost:uint;
			var n:uint = $source.length;
			var m:uint = $cible.length;
			var j:uint;

			if (n == 0) { return m; }
			if (m == 0) { return n; }

			for (i=0; i<=n; i++) { d[i] = new Array(); }
			for (i=0; i<=n; i++) { d[i][0] = i; }
			for (j=0; j<=m; j++) { d[0][j] = j; }

			for (i=1; i<=n; i++) {

				var s_i:String = $source.charAt(i-1);
				for (j=1; j<=m; j++) {

					var t_j:String = $cible.charAt(j-1);

					if (s_i == t_j) { cost = 0; }
					else { cost = 1; }

					d[i][j] = _minimum(d[i-1][j]+1, d[i][j-1]+1, d[i-1][j-1]+cost);
				}
			}
			return d[n][m];
		}

		/**
		*	Détermine si la chaîne spécifiée se termine par le suffixe spécifié.
		*
		*	@param $string La  chaine de caractère comparative that the suffic will be checked against.
		*
		*	@param $fin The suffix that will be tested against the string.
		*
		*	@returns Boolean
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function terminePar($string:String, $fin:String):Boolean {
			return $string.lastIndexOf($fin) == $string.length - $fin.length;
		}

		/**
		*	Détermine si le texte spécifié  comporte la chaîne.
		*
		*	@param $string La  chaine de caractère à vérifier.
		*
		*	@returns Boolean
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function comporteText($string:String):Boolean {
			var str:String = supprimeBigEspace($string);
			return !!str.length;
		}

		/**
		*	Détermine si la chaîne spécifiée Comporte tous les caractères.
		*
		*	@param $string La  chaine de caractère à verifier
		*
		*	@returns Boolean
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function estVide($string:String):Boolean {
			if ($string == null) { return true; }
			return !$string.length;
		}

		/**
		*	Determine si la chaine est numérique
		*
		*	@param $string La  chaine de caractère comparative.
		*
		*	@returns Boolean
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function estNumeric($string:String):Boolean {
			if ($string == null) { return false; }
			var regx:RegExp = /^[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?$/;
			return regx.test($string);
		}

		/**
		* Pads $string un caractère déterminé, à une longueur spécifiée par la gauche.
		*
		*	@param $string String to pad
		*
		*	@param p_padChar Character for pad.
		*
		*	@param $longueurgth Length to pad to.
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function padLeft($string:String, p_padChar:String, $longueurgth:uint):String {
			var s:String = $string;
			while (s.length < $longueurgth) { s = p_padChar + s; }
			return s;
		}

		/**
		* Pads $string au caractère déterminé, à une longueur spécifiée par la droite.
		*
		*	@param $string String to pad
		*
		*	@param p_padChar Character for pad.
		*
		*	@param $longueurgth Length to pad to.
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function padRight($string:String, p_padChar:String, $longueurgth:uint):String {
			var s:String = $string;
			while (s.length < $longueurgth) { s += p_padChar; }
			return s;
		}

		/**
		*	Properly cases' la chaîne en format «sentence».
		*
		*	@param $string La  chaine de caractère à verifier
		*
		*	@returns String.
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function nettoieLettre($string:String):String {
			if ($string == null) { return ''; }
			var regx:RegExp=/\b([^.?;!]+)/
			var str:String = $string.toLowerCase().replace(regx, capitaliser);
			return str.replace(/\b[i]\b/, "I");
		}

		/**
		*	Ajout de citation via la délimitation de guillemets. Ex citation : "message"
		*
		*	@param $string Chainse de caractères vérifiées pour les instances supprimer
		*	string
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function citer($string:String):String {
			var regx:RegExp = /[\\"\r\n]/g;
			return '"'+ $string.replace(regx, _citer) +'"'; //"
		}

		/**
		*	Supprime toutes les instances de la chaîne indiqué dans la chaîne d'entrée.
		*
		*	@param $string Chaines de caractères vérifiées pour les instances supprimer
		*	string
		*
		*	@param $strgSupp Chaines de caractères qui seront retirés de la chaîne d'entrée.
		*
		*	@param $caseSensible An optional boolean indicating if the replace is case sensitive. Default is true.
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function supprime($string:String, $strgSupp:String, $caseSensible:Boolean = true):String {
			if ($string == null) { return ''; }
			var rem:String = modelEchapement($strgSupp);
			var flags:String = (!$caseSensible) ? 'ig' : 'g';
			return $string.replace(new RegExp(rem, flags), '');
		}

		/**
		*	Supprime les grands espaces ( tabulations, ligne sauts, etc) dans la chaine specifié.
		*
		*	@param $string Chaine de caractère dont les espacements en trop seront supprimed.
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function supprimeBigEspace($string:String):String {
			if ($string == null) { return ''; }
			var str:String = SuppEspaceExtremite($string);
			return str.replace(/\s+/g, ' ');
		}

		/**
		*	Renvoie la chaîne spécifiée dans l'ordre inverse.
		*
		*	@param $string La chaîne qui sera inversé.
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function inverse($string:String):String {
			if ($string == null) { return ''; }
			return $string.split('').inverse().join('');
		}

		/**
		*	Renvoie la chaîne spécifiée dans l'ordre des mots inverse.
		*
		*	@param $string La chaîne qui sera inversée.
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function inverseMots($string:String):String {
			if ($string == null) { return ''; }
			return $string.split(/\s+/).inverse().join('');
		}

		/**
		*	Determine le pourcentage de similitude, baser sur editDistance
		*
		*	@param $source Chaine source.
		*
		*	@param $cible Chaine cible.
		*
		*	@returns Number
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function similitude($source:String, $cible:String):Number {
			var ed:uint = editDistance($source, $cible);
			var maxLen:uint = Math.max($source.length, $cible.length);
			if (maxLen == 0) { return 100; }
			else { return Math.floor((1 - ed/maxLen) * 100); }
		}

		/**
		*	Supprimer tout <et> balises basé partir d'une chaîne
		*
		*	@param $string Source de la chaine.
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function dissoutTags($string:String):String {
			if ($string == null) { return ''; }
			return $string.replace(/<\/?[^>]+>/igm, '');
		}

		/**
		*	Echange l'enveloppe d'une chaine
		*
		*	@param $string Source de la chaine.
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function echangeLettre($string:String):String {
			if ($string == null) { return ''; }
			return $string.replace(/(\w)/, _echangeLettre);
		}

		/**
		*	Supprime les espaces de l'avant et la fin spécifié
		*	string.
		*
		*	@param $string La chaîne de caractères dont le début et les espaces se terminant
		*	will be supprimed.
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function SuppEspaceExtremite($string:String):String {
			if ($string == null) { return ''; }
			return $string.replace(/^\s+|\s+$/g, '');
		}

		/**
		*	Supprime les espaces de l'avant (côté gauche) de la chaîne spécifiée.
		*
		*	@param $string La chaîne de caractères dont le début des espaces seront supprimés.
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function SuppEspaceGauche($string:String):String {
			if ($string == null) { return ''; }
			return $string.replace(/^\s+/, '');
		}

		/**
		*	Enlève les espaces à partir de la fin (côté droit) de la chaîne spécifiée.
		*
		*	@param $string La chaîne de caractères dont la fin des espaces seront supprimés.
		*
		*	@returns String	.
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function SuppEspaceDroite($string:String):String {
			if ($string == null) { return ''; }
			return $string.replace(/\s+$/, '');
		}

		/**
		*	Décrit que le nombre de mots dans une chaîne.
		*
		*	@param $string La chaine de caractère utilisé pour le comptage.
		*
		*	@returns uint
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function compteurMots($string:String):uint {
			if ($string == null) { return 0; }
			return $string.match(/\b\w+\b/g).length;
		}

		/**
		*	Retourne une chaîne tronquée à une longueur spécifiée et suffixe optionnel
		*
		*	@param $string La  chaine de caractère comparative.
		*
		*	@param $longueur La longueur de la chaîne devant être reduite
		*
		*	@param$suffix (optional, default=...) La  chaine de caractère comparative to append to the end of the tronquerd string.
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		*/
		public static function tronquer($string:String, $longueur:uint,$suffix:String = "..."):String {
			if ($string == null) { return ''; }
			$longueur -=$suffix.length;
			var trunc:String = $string;
			if (trunc.length > $longueur) {
				trunc = trunc.substr(0, $longueur);
				if (/[^\s]/.test($string.charAt($longueur))) {
					trunc = SuppEspaceDroite(trunc.replace(/\w+$|\s+$/, ''));
				}
				trunc +=$suffix;
			}

			return trunc;
		}
		
		/**
		*	Retourne une valueur formater, les nombres se voient  ajouter un ou plusieurs 0 en fonction nombre d'unité
		*
		*	@param $nb Valeur numérique devant être formaté
		*
		*	@param $nbU Nombre d'unité choisie, plus la valeur est élevé, plus le nombre de 0 placer devant la valeur numérique sera importante
		*
		*	@returns String
		*
		* 	@langversion ActionScript 3.0
		*	@playerversion Flash 9.0
		*	@tiptext
		**/
		public static function formate($nb:Number=10 , $nbU:int=1):String
		{
			var _nbU;
			var nbF:String = String($nb);
			
			_nbU = ($nbU>3)?3:$nbU &&($nbU<1)?1:$nbU;
			
			if($nbU==1)nbF = ($nb < 10 && $nb > -1) ? "0" + nbF : nbF ;
			else if($nbU==2)nbF = ($nb < 10 && $nb > -1) ? ("00" + nbF) : nbF && ($nb < 100 && $nb > 9) ? '0' + nbF : nbF;
			else nbF = ($nb < 10 && $nb > -1) ? ("000" + nbF): nbF && ($nb < 100 && $nb > 9) ? '00' + nbF : nbF && ($nb < 1000 && $nb > 99) ? '0' + nbF : nbF;
			
			return nbF;
		}	

		/* **************************************************************** */
		/*	Méthodes d'assistance utilisés par certaines méthodes employées ci-dessus.		*/
		/* **************************************************************** */
		private static function modelEchapement($model:String):String {
			// RM: risque d'exposer celle-ci, je l'ai utilisé quelques fois déjà.
			return $model.replace(/(\]|\[|\{|\}|\(|\)|\*|\+|\?|\.|\\)/g, '\\$1');
		}

		private static function _minimum(a:uint, b:uint, c:uint):uint {
			return Math.min(a, Math.min(b, Math.min(c,a)));
		}

		private static function _citer($string:String, ...args):String {
			switch ($string) {
				case "\\":
					return "\\\\";
				case "\r":
					return "\\r";
				case "\n":
					return "\\n";
				case '"':
					return '\\"';
				default:
					return '';
			}
		}

		private static function _majuscule($caracteres:String, ...args):String {
			trace('cap latter ',$caracteres)
			return $caracteres.toUpperCase();
		}

		private static function _echangeLettre($caracteres:String, ...args):String {
			var lowChar:String = $caracteres.toLowerCase();
			var upChar:String = $caracteres.toUpperCase();
			switch ($caracteres) {
				case lowChar:
					return upChar;
				case upChar:
					return lowChar;
				default:
					return $caracteres;
			}
		}

	}
}