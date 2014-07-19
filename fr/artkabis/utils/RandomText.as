package fr.artkabis.utils
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import flash.display.MovieClip;
	
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class RandomText extends MovieClip
	{
		private var tab:Array=[];
		private var tabT:Array=[];
		private var alphaB:Array=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U'];
		private var txt:TextField;
		private var titre:MovieClip=new MovieClip();
		private var format:TextFormat = new TextFormat();
		private var _this;
		private var num:int=0;
		var l:int=0;
		var inter:uint;

		public function RandomText($this:*, $elem:TextField,$size:Number):void
		{
			_this = $this;
			$elem.text = $elem.text.toUpperCase();
			var str:String=$elem.text;
			for(var i:int=0;i< $elem.length;i++){
				txt = new TextField();
				txt.name = 't' + i;
				format.size = $size;
				format.color = 0xFB6300
				format.font = 'Franklin Gothic Medium Cond';
				txt.defaultTextFormat=format;
				txt.y = $elem.y;
				txt.x = $elem.x+($size/2.2) * i;
				tab[i] = str.charAt(i).toUpperCase();
				titre.addChild(txt);
				tabT.push( titre.getChildByName('t'+i) );
				tabT[i].text = tab[i];
			}
			$elem.text='';
			_this.removeChild($elem);
			_this.addChild(titre);
			titre.addEventListener('mouseOver',overText);

		}
		private function overText(me:MouseEvent):void
		{
			titre.removeEventListener('mouseOver',overText);
			inter = setInterval(function (){randomLettre()},1*(alphaB.length/5));
		}
		
		dynamic function randomLettre()
		{
			var r:int=Math.round( Math.random()* alphaB.length-1 );
			var lr:String = String(alphaB[num]);
			tabT[l].text =lr ;
			if(l<tab.length-2)tabT[l+1].text='_';
			num++;
			if(num===alphaB.length-1){nextLetter();num=0;};
		}
		private function nextLetter():void{
			tabT[l].text = tab[l];
			if(l===tab.length-1)
			{
				clearInterval(inter);
				titre.addEventListener('mouseOver',overText);
				l=0;
			}else{l++;}
		}
	}
}