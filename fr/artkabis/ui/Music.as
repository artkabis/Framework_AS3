#
/ création du conteneur du son
#
var conteneurSon:Sound = new Sound();
#
// url du fichier mp3
#
var fichierMP3:URLRequest = new URLRequest("sons/monSon.mp3");
#
// Objet permettant de contrôler le son
#
var canal:SoundChannel = new SoundChannel();
#
// chargement du mp3 dans le conteneur
#
conteneurSon.load(fichierMP3);
#
// Lecture du son et stockage dans le canal
#
canal = conteneurSon.play();
