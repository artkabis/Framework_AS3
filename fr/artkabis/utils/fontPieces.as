package fr.artkabis.utils {
    import flash.display.Sprite;
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.display.Bitmap;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.geom.Point;
 
    // taille du fichier Flash pour le compilateur FLEX 2
    [SWF(frameRate='300',width='500',height='500',backgroundColor='0x869CA7')]
 
    public class fondPieces extends Sprite
    {
        // on déclare un objet Loader
        private    var pictLdr:Loader;
 
        // on déclare les pixels de notre image de fond
        // on déclare le bitmap de l'image chargée
        // ATTENTION, ne pas confondre
        // Bitmap ------> l'image
        // BitmapData --> les pixels de l'image
        private var fondBitmap:BitmapData; // le bitmapData de l'image affiché
        private var pictLoad:Bitmap; // le bitmap de l'image chargée
 
        public function fondPieces()
        {
            // on définit l'objet Loader
            pictLdr = new Loader();
 
            // quand le chargement sera fini, on lancera onImgLoaded
            pictLdr.contentLoaderInfo.addEventListener(Event.COMPLETE, onImgLoaded);
 
            // l'adresse URL de l'image
            var pictURL:String = "Design_bubble.jpg";
            // on récupère le path complet du movie Flash, on enlève le nom du fichier Flash
            // et on ajoute le nom de l'image
            pictURL = (root.loaderInfo.url.substring(0, (root.loaderInfo.url).lastIndexOf("/") + 1 ) ) + pictURL
 
            // on fait une requête pour l'URL de l'image
            var pictURLReq:URLRequest = new URLRequest(pictURL);
 
            // on lance le chargement de l'image concernée
            // équivalent à pictLdr.load(new URLRequest("pieces.png"));
            pictLdr.load(pictURLReq);
 
            // maintenant on fait la création d'une image vide à la taille de la scène
            // d'abord le bitmap de l'image
            // (largueur, hauteur, opaque ou non (alpha-channel), couleur de remplissage)
            fondBitmap = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x00000000);
            // à partir de ces pixels, on définit l'image qui y fait référence
            // on fabrique l'image, car il est imposible de faire un addChild d'un bitmapData
            var fondImage:Bitmap = new Bitmap(fondBitmap);
 
             // on ajoute notre image dans la liste d'affichage
             addChild(fondImage);
        }
 
        public function onImgLoaded(event:Event):void {
            // on vient de finir de charger notre image
            pictLoad = Bitmap(pictLdr.content);
 
            // on définit maintenant un évènement qui réagit à chaque EnterFrame
            // On choisit le type d'évènement dans la classe Event
            // Le nom de la s/s routine peut être ce que l'on veut
            // onEnterFrame ou toto mais
            // par convention onEnterFrame, c'est mieux
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
         }
 
        public function onEnterFrame(event:Event):void {
            // on vient de finir de charger notre image
 
            // la largueur/hauteur de chaque piece
            // 1--> 105 pixels, 2--> 95 pixels (voir fichier "pieces.png")
            var taillePieces:Array = [0, 105, 95, 94, 80, 77, 69];
 
            // on tire le numéro d'une pièce au hasard
            var numPiece:int = rand(1,9)
 
            // coté de la pièce que l'on affiche 1->face, 0->pile
            var cotePiece:int = rand(0, 1)
 
            // on fait notre rectangle de découpe de la pièce dans l'image de fond
            // la position en X du carré de découpe de la pièce
            var decoupeX:int = 0
            // on compte à l'horizontale la distance de toutes les pièces
            // qui se trouvent avant
            for (var i:int = 1; i <  numPiece; i++){
                decoupeX += taillePieces[i];
            }
 
            // la position en Y du carré de découpe de la pièce (pile ou face)
            var decoupeY:int = (1 - cotePiece) * taillePieces[numPiece];
 
            // on met la pièce dans le bitmap graphique de l'image du fond
 
            //le rectangle de découpe de l'image de base dans l'image de départ
            var rectDecoupe:Rectangle = new Rectangle(decoupeX, decoupeY, taillePieces[numPiece], taillePieces[numPiece]);
 
            // le point d'arrivé sur l'image de fond
            var ptArrivee:Point = new Point(rand(-30,320+30), rand(-30, 160+ 30));
 
            // on met dans fondBitmap, l'image de la pièce découpée
            // 3 premiers paramètres obligatoires, les suivants pour gérer l'alpha channel et ne pas 'écraser l'ancien'
            // (bitmapData de départ, rect de découpe, point d'arrivée,
            // bitmapData qui contient l'alpha channel, position de la découpe
            fondBitmap.copyPixels(pictLoad.bitmapData, rectDecoupe, ptArrivee, pictLoad.bitmapData, new Point(decoupeX, decoupeY), true);
        }
 
        private function rand(minimum:Number, maximum:Number):Number {
            // on retourne un nombre aléatoire entier compris entre minimum et maximum
            return Math.floor(minimum + Math.random()*(maximum - minimum + 1));
        }
    }
}