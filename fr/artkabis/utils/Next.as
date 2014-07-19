package fr.artkabis.utils
{
	/**
	* La classe Next est utiliser pour regrouper la navigation de plusieur symboles. <p>Il est possible d'utiliser trois types de navigations : gts, gtp, nf. Le choix des frames de chaque élément est aussi paramètrable.</p>
	*
	* @author		NICOLLE-Gregory - Artkabis
	* @version		1.0
	* @date 		26.03.2010
	*
	* @example Dans le premier exemple, il est créé une navigation sur les éléments ayant comme noms d'occurrences (sur la scène) monClip0, monClip1,...,monClip4. Chaque élément utilisera la méthode gotoAndPlay( $frames ).$frames étant les valeurs récupérés depuis le dernier paramètre de la méthode add (Array). Attention, vous devez absolument donner des noms d'occurrences similaire à l'ensemble de vos clips, puis ajouté une valeur numérique après la dernière lettre de ceux-ci, exemple monClip0,monClip1,etc. Pour finir sachez que si vous utilisé les modes gtp ou gts, alors vous devrez indiqué dans le dernier paramètre, un nombre de frame équivalent au nombre d'élément (clip), sachez aussi que la navigation se fera par correspondance, ceci veut dire que le premier élément aura une navigation qui correspondera à première valeur indiqué dans le tableau (celui des frames). Si par contre vous avez choisis le mode "nf", dans ce cas, vous n'êtes pas obligé de remplir le dernier paramètre (inutile puisque le nextFrame ne comporte pas deparamètre relié à une frame).
	* 
	*
	* <listing version="1.0">
	*     Next.add ( this, "monClip", 5,  "gotoAndPlay", new Array(2,3,4,5,6) );
	*
	*		// autre méthode:
	*
	*	    var MassivNav:Next = Next.add( this, "monClip", 5,  "nextFrame" );
	*  </listing>
	*/

	public class Next
	{
		/**
		* nom d'occurrence de base des éléments utilisant la navigation, attention la valeur numérique ne doit pas être indiqué (elem et non elem0)
		*/
		public static var _mcName               :String                    ;
		
		/**
		* Mode de navigation utilisé pour les éléments, peut être : "gts"(gotoAndStop), "gtp"(gotoAndPlay) ou "nf"(nextFrame)
		*/
		public static var _modes                :String                    ;
		
		/**
		* nombre d'élément utilisant cette classe (ce nombre sera utilisé pour identifier les occurrences, ex :  si _mcName vaut "elem" et que _nb vaut 2, alors les éléments devront être nommés elem0,elem1 dans votre projet)
		*/
		public static var _nb                   :int                       ;
		
		/**
		* Cette variable regroupera l'ensemble des éléments utilisant les fonctionnalités de cette classe
		*/
		private static var _elems                :*                         ;
		
		/**
		* Cette variable est un tableau appelé lorsqu'un autre mode que "nf" est précisé, il regroupe les frames à visités de chaque élément (mcName). Il doit aussi comporter un nombre de valeur équivalent à celui du paramètre _nb
		*/
		public static var _frames               :*                         ;
		
		/**
		* Le paramètre scene est utilisé comme pont entre l'application et la classe Next. Ce qui est indispensable pour la récupération des éléments utilisant la navigation
		*/
		public static var _scene                :*                         ;
		
		/**
		* La constante NF représente le mode de navigation nextFrame
		*/
		public static const NF                   :String = "nf"      ;
		
		/**
		* La constante NF représente le mode de navigation gotoAndPlay
		*/
		public static const GP                   :String = "gtp"    ;
		
		/**
		* La constante NF représente le mode de navigation gotoAndStop
		*/
		public static const GS                   :String = "gts"    ;
		
		
		/**
		* Mise en place d'une navigation groupé
		*
		* <p>La mise en place de la classe Next doit passer par la méthode add.</p>
		*
		* @param $scene 	Le paramètre scene est utilisé comme pont entre l'application et la classe Next. Il est indispensable pour la récupération des éléments utilisant la navigation
		* @param $mcName 	Nom d'occurrence de base des éléments utilisant la navigation, attention la valeur numérique ne doit pas être indiqué (elem et non elem0)
		* @param $nb		Nombre d'élément utilisant cette classe (ce nombre sera utilisé pour identifier les occurrences, ex :  si _mcName vaut "elem" et que _nb vaut 2, alors les éléments devront être nommés elem0,elem1 dans votre projet)
		* @param $mode		Mode de navigation utilisé pour les éléments, peut être : "gts"(gotoAndStop), "gtp"(gotoAndPlay) ou "nf"(nextFrame)
		* @param $frames	Ce paramètre regroupe (dans un tableau) les frames à visités et ceci pour chacun des éléments (mcName), il est appelé lorsqu'un autre mode que "nf" est précisé. Il doit aussi comporter un nombre de valeur équivalente à celui qui a été définit dans le paramètre _nb.
		* @see Next
		*/
		public static function add( $scene:*=null, $mcname:String = 'mc' , $nb:int = 2 , $modes:String = 'nextFrame' , $frames:* = ( 1 , 2 ) )
		{
			_mcName = $mcname;
			_nb     = $nb;
			_modes  = $modes;
			_frames = $frames;
			_scene  = $scene;
			
			trace('.:: PARAMÈTRAGES FONCTION NEXT ::.\n**********************************\n.:: Scene:'+_scene,'\n.:: Nom mc:'+_mcName,'\n.:: Nombre mc:'+_nb,'\n.:: Mode:'+_modes );
			for( var i:int = 0; i < $nb; i++ )
			{
				if($modes!='next'){trace('.:: Frame '+_mcName+i+':'+_frames[i] )};
				_elems = $scene.getChildByName( String( $mcname ) + i );
				switch($modes)
				{
					case NF   :   _elems.nextFrame  (              )  ;break ;
					case GP   :   _elems.gotoAndPlay( _frames[ i ] )  ;break ;
					case GS   :   _elems.gotoAndStop( _frames[ i ] )  ;break ;
				}
			}
			trace("**********************************");
		}
		/**
		* @exemple EXEMPLE
		*<code>
		*	import fr.artkabis.graphics.DessineRect;
		*
		*	var cont:MovieClip;
		*	var rect:Shape;
		*	const NB_ELEM
		*	for(var i:int=0; i<NB_ELEM; i++){
		*		rect = DessineRect.draw(0,0,150,50,Math.random()*0xFFFFFF);
		*		rect.name = 'rect'+i;
		*		rect.x = 150* i;
		*	}
		*	
		*	Next.add ( this, "monClip", 5,  "gotoAndPlay", new Array(2,3,4,5,6) );
		*</code>
		**/
	}
}