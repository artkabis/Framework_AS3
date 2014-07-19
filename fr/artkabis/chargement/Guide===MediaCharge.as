//Aprés bah tu l´utilise comme ca (écriture non flemmard) : 
 
var mc:MediaCharge = new MediaCharge("tonfichier.tonext"); 
mc.addEventListener(Event.CHANGE,$progression); 
mc.addEventListener(Event.COMPLET,$chargement_ok); 
 
function $progresssion(e:Event):void 
{ 
trace(mc.getTauxFormat + "%"); 
} 
 
function $chargement_ok(e:Event):void 
{ 
addChild(mc.getMedia); 




//Ou comme ca si tu es flemmard ^^ 
 
new MediaCharge("tonfichier").addEventListener(Event.CHANGE,$progression); 
function $progression(e:Event):void 
{ 
trace(e.currentTarget.getTauxFormat + "%"); 
e.currentTarget.addEventListener(Event.COMPLETE,$complete); 
} 
 
function $complete(e:Event):void 
{ 
addChild(e.currentTarget.getMedia); 
