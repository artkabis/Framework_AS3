 
 
 package fr.artkabis.text
 {
 import flash.display.Sprite;
 
  import flash.text.TextField;
   import flash.text.StyleSheet;
    import flash.text.AntiAliasType;
     import flash.text.TextFieldAutoSize;
       
        /**
          * La classe DrawText offre une large gamme d'outils pour créer et manipuler des objets de type textField .
            * <p>Il est possible d'utiliser 90 % des paramètres proposés par la classe TextField tout en offrant une simplicité d'utilisation.</p>
               *
                 *	@author			NICOLLE-Gregory - Artkabis
                    * 	@email			artkabis@artkabis.net
                      *	@website		www.urliss35.free.fr 
                         *	@forum			www.artkabis.net  
                            *	@version		1.2
                               *	@date			10.08.2010
                                   *	@langversion 	ActionScript 3.0
                                      * 	@playerversion 	Flash 10
                                         
                                             *	@tiptext
                                                *
                                                    *	@example Dans cet exemple, vous la classe DrawText est utilisé de deux manières, l'une en paramètrage défaut et l'autre via les méthodes ascensseurs (getter setter):
                                                       *	
                                                           * 
                                                              *
                                                                  * <listing version="1.0">
                                                                     *	import fr.artkabis.text.DrawText;
                                                                        *	
                                                                            *	//================================================================================
                                                                               *	//Utilisation Simple via les paramètres du constructeur
                                                                                  *	//================================================================================
                                                                                     *	var params:Object = new Object();
                                                                                       *									params.text='Artkabis',
                                                                                          *									params.size=20;
                                                                                            *								params.width=100;
                                                                                               *							params.color='#888888';
                                                                                                 *							params.font='arial';
                                                                                                   *						params.autosize='L';
                                                                                                    *						params.gras=false;
                                                                                                      *						params.style='O';
                                                                                                       *					params.x=0;
                                                                                                        *					params.y=0;
                                                                                                         *					params.selectable=false;
                                                                                                          *					params.info = false;
                                                                                                          *	
                                                                                                          *	var t2:DrawText = new DrawText(params);
                                                                                                          *	this.addChild(t2);
                                                                                                          *	
                                                                                                          *	
                                                                                                         *	//================================================================================
                                                                                                        *	//Utilisation secondaire via les getters-setters
                                                                                                       *	//================================================================================
                                                                                                     *	var params1:Object = new Object();//paramètres (vide)	
                                                                                                    *	var t:DrawText = new DrawText(params1);//création du texte
                                                                                                  *	
                                                                                                *		t.contenu='Artkabis';//contenu du texte(htmlText)
                                                                                              *		t.color= '#FF9900';//couleur du texte
                                                                                            *	  t.taille = 50;//taille du   texte (size)
                                                                                         *		t.large = 350;
                                                                                      *		t.font='Circus';//pollice du texte
                                                                                    *		t.x_=0;//position du texte en x
                                                                                 *		t.y_=100;//position du text en y
                                                                              *		t.autosize='L';//autosize: center('C'),left('L'),right('R'),none('N')
                                                                           *		t.style = 'O';//style: Italic,Oblic,Normal
                                                                       *		t.gras = true;//Activer le mode bold
                                                                    *		t.selectable = false;//activer ou non le mode selectabled
                                                                 *		t.mouseE=false;//activer ou non le mouseEnabled
                                                             *		t.multiligne = false;//activer ou non le mode multiligne
                                                          *		t.info = true;//afficher l'ensemble des paramètres
                                                      *	
                                                   *	this.addChild(t);//mise en place du texte	* </listing>
                                               */
                                            
                                        /**
                                     * Création d'une instance de DrawText
                                  */
                               
                           public class DrawText extends Sprite
                        {
                      /**
                   *@private
                *Contenu textuel
              */
            private var _contenu                       :String;
          
        /**
      *@private
     *Couleur du texte
   */
  private var _color                        :String;
  
 /**
 *@private
 *Taille du texte
 */
 private var _taille                       :int;
 
  /**
   *@private
     *Police du texte
      */
        private var _font                         :String;
         
           /**
              *@private
                *Objet textField
                   */
                     private var _texte                        :TextField;
                        
                           /**
                              *@private
                                 *Auto size C,L,R,N (center,left,right,none)
                                     */
                                        private var _aSize                        :String;
                                           
                                               /**
                                                  *@private
                                                      *Auto size C,L,R,J (center,left,right,justify)
                                                         */
                                                             private var _align                        :String;
                                                                
                                                                    /**
                                                                       *@private
                                                                          *Position X
                                                                             */
                                                                                private var _X                            :int;
                                                                                   
                                                                                      /**
                                                                                         *@private
                                                                                           *Position Y
                                                                                              */
                                                                                                private var _Y                            :int;
                                                                                                  
                                                                                                    /**
                                                                                                     *@private
                                                                                                       *Style du texte bold, italic, etc
                                                                                                        */
                                                                                                         private var _style                        :String;
                                                                                                          
                                                                                                          /**
                                                                                                          *@private
                                                                                                          *Activation du mode multiligne
                                                                                                          */
                                                                                                          private var _multiligne                   :Boolean;
                                                                                                         
                                                                                                        /**
                                                                                                       *@private
                                                                                                      *Activation du mode bold
                                                                                                     */
                                                                                                   private var _gras                         :Boolean;
                                                                                                 
                                                                                               /**
                                                                                             *@private
                                                                                          *Activation du paramètre selectable
                                                                                        */
                                                                                     private var _selectable                   :Boolean;
                                                                                  
                                                                               /**
                                                                            *@private
                                                                         *Activation intercation souris
                                                                     */
                                                                  private var _mouseEnabled                 :Boolean;
                                                               
                                                           /**
                                                        *@private
                                                    *Largeur du texte
                                                 */
                                             private var _largeur                      :int;
                                          
                                      /**
                                   *@private
                                *Choix du mode Autosize 
                             *(C,L,R,N >> Center,Left,Right,None
                          */
                       private var _autoS                         :String;
                    
                 /**
               * @private
             *Choix parmis les paramètres
          *italic,bold,normal
        */
       private var _stylise                      :String;
     
    /**
   * @private
  *Choix parmis les paramètres
 *center,left,right,justify
 */
 private var _tAlign                       :String;
 
 /**
 * @private
  *Choix du mode bold
   */
    private var _weight                       :String;
     
       /**
         * @private
           * Recupérteur des reglages
             * passé depuis le css
               */
                  private var _s                            :Object;
                    
                       /**
                          * @private
                             * Recupérteur des reglages
                                * passé depuis le css
                                   */
                                       private var _p                            :Object
                                          
                                              /**
                                                 * @private
                                                    * Varialbe lié au css
                                                        */
                                                           private var _sheet                        :StyleSheet;
                                                               
                                                                  /**
                                                                      * @private
                                                                         * Gestion des infos
                                                                            */
                                                                               private var _info                         :Boolean;
                                                                                  
                                                                                     /**
                                                                                        * @private
                                                                                          * Paramètre utilisé
                                                                                             */
                                                                                               private var params                        :Object;	
                                                                                                 
                                                                                                   
                                                                                                     /***********************************************************
                                                                                                      /***********************************************************
                                                                                                       /** Mise en place des getters setters                     ** 
                                                                                                         /** pour activer la lecture est reecriture                ** 
                                                                                                         /** des paramètres: get pour la lecture, set: écriture    **
                                                                                                          /***********************************************************
                                                                                                          /***********************************************************/
                                                                                                          
                                                                                                          
                                                                                                          //==================================================================================================
                                                                                                          /**
                                                                                                         * Représente le contenu textuel du textField
                                                                                                        */
                                                                                                       public function get contenu():String{return _contenu;}
                                                                                                     /**
                                                                                                    * @private
                                                                                                  */
                                                                                                public function set contenu(pContenu:String){_contenu=pContenu;editer();}
                                                                                              //==================================================================================================
                                                                                           
                                                                                         
                                                                                      //==================================================================================================
                                                                                   /**
                                                                                * Représente la couleur du textField
                                                                             **/
                                                                          public function get color():String{return _color; }
                                                                       /**
                                                                   * @private
                                                                */
                                                            public function set color(pColor:String){_color =  String(pColor);editer();}
                                                         //==================================================================================================
                                                      
                                                  
                                               //==================================================================================================
                                           /**
                                        * Représente la taille du TextField
                                    * @return int
                                 **/
                              public function get taille():int{return _taille; }
                           /**
                        * @private
                     */
                  public function set taille(pTaille:int){_taille = int(pTaille);editer();}
                //==================================================================================================
             
           
         //==================================================================================================
       /**
      * Représente la police du TextField
    *	@return String
   */
  public function get font():String{return _font; }
 /**
 * @private
 */
 public function set font(pFont:String){_font = String(pFont);editer();}
 //==================================================================================================
 
  
  //==================================================================================================
    /**
     * Représente le caractère lié à l'auto-size C,L,R,N (center,left,right,none)
      */
        public function get autosize():String{return _autoS; }
          /**
            * @private
              */
                 public function set autosize(pAutoS:String){ _autoS = String(pAutoS);init();editer();}
                   //==================================================================================================
                      
                         //==================================================================================================
                            /**
                               * Représente le caractère lié à l'auto-size C,L,R,N (center,left,right,none)
                                  */
                                     public function get align():String{return _align; }
                                         /**
                                            * @private
                                                */
                                                   public function set align(pAlign:String){ _align = String(pAlign);init();editer();}
                                                       //==================================================================================================
                                                          
                                                             
                                                                 //==================================================================================================
                                                                    /**
                                                                        * Représente l'activation du mode bold
                                                                           */
                                                                              public function get gras():Boolean{return _gras; }
                                                                                 /**
                                                                                    * @private
                                                                                       */
                                                                                         public function set gras(pGras:Boolean){_gras = Boolean(pGras);init();editer();}
                                                                                            //==================================================================================================
                                                                                              
                                                                                                
                                                                                                  //==================================================================================================
                                                                                                    /**
                                                                                                      * Représente le style du TextField : italic, oblic, normal
                                                                                                       * return String
                                                                                                        */
                                                                                                         public function get style():String{return _style; }
                                                                                                          /**
                                                                                                          * @private
                                                                                                          */
                                                                                                          public function set style(pStyle:String){_style = String(pStyle);init();editer();}
                                                                                                          //==================================================================================================
                                                                                                          
                                                                                                         
                                                                                                        //==================================================================================================
                                                                                                       /**
                                                                                                      * Représente la position en x du Textfield
                                                                                                    * @return int
                                                                                                   */
                                                                                                 public function get x_():int{return _X; }
                                                                                              /**
                                                                                            * @private
                                                                                          */
                                                                                       public function set x_(pX:int){_X = int(pX);editer();}
                                                                                    //==================================================================================================
                                                                                 
                                                                              
                                                                           //==================================================================================================
                                                                        /**
                                                                     * Représente la position en y du Textfield
                                                                 * @return int
                                                              */
                                                          public function get y_():int{return _Y; }
                                                       /**
                                                   * @private
                                                */
                                            public function set y_(pY:int){_Y = int(pY);editer();}
                                         //==================================================================================================
                                      
                                  
                               //==================================================================================================
                            /**
                         * Représente l'activation du mode selectable
                      * @return Boolean
                   */
                 public function get selectable():Boolean{return _selectable; }
              /**
            * @private
          */
        public function set selectable(pSelectable:Boolean){_selectable = Boolean(pSelectable);editer();}
      //==================================================================================================
     
    
   //==================================================================================================
  /**
 * Représente le mode multiligne
 * @return Boolean
 */
 public function get multiligne():Boolean{return _multiligne; }
 /**
 * @private
  */
   public function set multiligne(pMultiline:Boolean){_multiligne = Boolean(pMultiline);editer();}
    //==================================================================================================
      
       
         //==================================================================================================
           /**
             * Représente la largeur du TextField
                * @return int
                  */
                     public function get large():int{return _largeur; }
                        /**
                           * @private
                              */
                                 public function set large(pLarge:int){_largeur = int(pLarge);editer();}
                                    //==================================================================================================
                                       
                                           
                                              //==================================================================================================
                                                  /**
                                                     * Représente l'activation du paramètre mouseEnabled
                                                         * @return Boolean
                                                            */
                                                                public function get mouseE():Boolean{return _mouseEnabled; }
                                                                   /**
                                                                      * @private
                                                                          */
                                                                             public function set mouseE(pEnable:Boolean){_mouseEnabled = Boolean(pEnable);editer();}
                                                                                //==================================================================================================
                                                                                   
                                                                                      //==================================================================================================
                                                                                        /**
                                                                                           * Représente l'activation de le'affichage de l'ensemble des info lié aux paramètres de la classe DrawText
                                                                                             * @return Boolean
                                                                                                */
                                                                                                  public function get info():Boolean{return _info;}
                                                                                                   /**
                                                                                                     * @private
                                                                                                      */
                                                                                                        public function set info(pInfo:Boolean){_info = Boolean(pInfo);editer();}
                                                                                                         //==================================================================================================
                                                                                                          
                                                                                                          
                                                                                                          
                                                                                                          //==================================================================================================
                                                                                                          /**
                                                                                                          * Création d'une instance de DrawText
                                                                                                         */
                                                                                                         public function DrawText(params:Object):void
                                                                                                        //==================================================================================================
                                                                                                      {
                                                                                                     _texte        = new TextField ();
                                                                                                   _sheet        = new StyleSheet();
                                                                                                 _s            = new Object();
                                                                                               _contenu      =  params.text;
                                                                                             _largeur      =  params.width;
                                                                                           _multiligne   =  params.multiline;
                                                                                        _color        =  params.color;
                                                                                     _taille       =  params.size;
                                                                                   _font         =  params.font;
                                                                                _align        =  params.align;
                                                                            _autoS        =  params.autosize;
                                                                         _gras         =  params.gras;
                                                                      _style        =  params.style;
                                                                   _X            =  params.x;
                                                               _Y            =  params.y;
                                                            _mouseEnabled =  params.enabled;
                                                        _selectable   = params.selectable;
                                                     _info         = params.info;
                                                 
                                              init();
                                          }
                                       
                                    //==================================================================================================
                                private function init():void
                             //==================================================================================================
                          {
                       switch( _autoS )
                     {
                  case 'C':
               _aSize =  TextFieldAutoSize.CENTER;
             break;
           case 'L':
         _aSize =  TextFieldAutoSize.LEFT;
       break;
      case 'R':
    _aSize =  TextFieldAutoSize.RIGHT;
   break;
  case 'N':
 _aSize =  TextFieldAutoSize.NONE;
 break;
 default:
 _aSize =  TextFieldAutoSize.LEFT;
 }
 switch (_align){
  case 'C':
   _tAlign =  'center';
    break;
     case 'L':
       _tAlign =  'left';
        break;
          case 'R':
            _tAlign =  'right';
               break;
                 case 'J':
                    _tAlign =  'justify';
                      break;
                         default:
                            _tAlign =  'left';
                               }
                                   switch( _style )
                                      {
                                         case 'I':
                                             _stylise =  'italic';
                                                break;
                                                    case 'O':
                                                       _stylise =  'oblic'
                                                           break;
                                                              case 'N':
                                                                  _stylise =  'normal';
                                                                     break;
                                                                        default:
                                                                            _stylise =  'normal';
                                                                               }
                                                                                  
                                                                                     _contenu ||=  'défaut';
                                                                                       _font    ||=  'arial' ;
                                                                                          _color   ||=  '#000000';
                                                                                            
                                                                                               (_largeur==0)       ?  _largeur=_texte.width   : _largeur = _largeur;
                                                                                                 (_taille== 0)       ?  _taille=12              : _taille=_taille;
                                                                                                   (_X==isNaN( _X ))   ?  _X=0                    : _X;
                                                                                                    (_Y==isNaN( _Y))    ?  _Y=0                    : _Y;
                                                                                                      (_selectable)       ? _texte.selectable = true : _texte.selectable =false;
                                                                                                       
                                                                                                        //○○○---Les fonctions editer et afficheInfo sont lancés
                                                                                                         //○○○---et le texte est ajouté à la liste d'affichage.
                                                                                                          editer();
                                                                                                          this.addChild( _texte );
                                                                                                          }
                                                                                                          
                                                                                                          //==================================================================================================
                                                                                                          private function editer():void
                                                                                                         //==================================================================================================
                                                                                                        {
                                                                                                       if(_gras) _weight        ='bold' ;else _weight='normal';
                                                                                                     if(_info)affichInfo();
                                                                                                    _s.fontWeight            = String ( _weight );
                                                                                                  _texte.multiline         = Boolean( _multiligne );
                                                                                                _s.fontStyle             = String( _stylise  );
                                                                                              _s.color                 = String( _color  );
                                                                                            _s.fontFamily            = String( _font  );
                                                                                         _texte.width             = int( _largeur );
                                                                                      _s.fontSize              = int( _taille )
                                                                                    _s.embedFonts            = true;
                                                                                 _texte.autoSize          = String( _aSize );
                                                                              _sheet.setStyle           (".s", _s);
                                                                           _sheet.setStyle           ("p", _p);
                                                                       _texte.styleSheet        = _sheet; 
                                                                    _texte.antiAliasType     = AntiAliasType.ADVANCED;
                                                                 this.x                   = int ( _X );
                                                             this.y                   = int ( _Y );
                                                          _texte.mouseEnabled      = Boolean( _mouseEnabled );
                                                      _texte.htmlText          = ("<p align='"+_tAlign+"'><span class='s'>"+String(_contenu)+"</span></p>");
                                                   
                                               }
                                            
                                        //==================================================================================================
                                     /**
                                  * Affichage de l'ensemble des informations liées à la classe
                               */
                           public function affichInfo():void
                        //==================================================================================================
                      {		
                   trace(':::::::::::::::::::::::::::::::::○○○_______Propriétés public_______○○○:::::::::::::::::::::::::::::::::'); 
                trace('_______________________________________________________________________________________________________');
              trace('||        ||        ||        ||        ||        ||        ||        ||        ||        ||        || ');
            trace('_______________________________________________________________________________________________________');
          trace('○○○__:: _contenu::'+_contenu+',  _color::'+_color+',  _taille::'+_taille+',  _font::'+_font+', _autoSize::'+
        _aSize+', weight='+_weight+', multiligne='+_multiligne+', largeur='+_largeur+', _autoSize::'+_aSize);
      trace('○○○__::_stylise::'+_stylise+',  _X::'+_X+', Y::'+_Y+',  _selectable::'+_selectable+', _s.embedFonts='+_s.embedFonts);
     trace('_______________________________________________________________________________________________________');
   trace('||        ||        ||        ||        ||        ||        ||        ||        ||        ||        || ');
  trace('_______________________________________________________________________________________________________\n\n\n');
  }
 }//___○○○---End of DrawText
 }//_____○○○---En of package