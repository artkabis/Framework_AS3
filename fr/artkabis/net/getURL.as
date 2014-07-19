
/**  
* getURL (AS3), version 1.0  
*  
* 
*  
* <pre>  
*  ____              _         _      ____   
* |  __| _____  ____| |_      | | __ |__  |  
* | |   |  _  ||  _||  _| __  | |/ /    | |  
* | |   | |_| || |  | |  |__| |   <     | |  
* | |__ |_| |_||_|  |_|       |_|\_\  __| |  
* |____|                             |____|  
*   
* </pre>  
*  
* @class    :                                   getURL  
* @author   :                                   Greg.N :: Artkabis 
* @version  :                                   1.0 - class getURL (AS3)  
* @since    :                                   20-05-2009 20:52
* @usage    :                                   import fr.artkabis.net.getURL; 
*           :									getURL("url","_win");          ||           getURL("url");
*   
*/ 	
	/************************************************
	 * Classe getURL en as3, permet de simplifier   *
	 * la classe de base en utilisant les           *
	 * méthode getURL du langage as2                *
	 ************************************************/
package fr.artkabis.net{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;	
	
	public function getURL(url:String='', win:String='_self'){
			
		try {
			navigateToURL(new URLRequest(url), win);
		}catch(e:Error){
			trace("getURL::: "+e);
		}
		if(url=='')
		throw new Error('veuillez indiquer l\'url de navigation en premier paramètre');
	}
}