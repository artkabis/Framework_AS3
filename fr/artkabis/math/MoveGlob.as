package fr.artkabis.math
{
	public class MoveGlob
	{
		var nbGlob=100;
		var glob:Glob;
		var widgets:Array=[];
		public function MoveGlob():void
		{
			float inc1=100;
			float inc2=150;
			float inc3=50;
			for(var i=0; i<nbGlob; i++)
			{
				glob=new Glob(); 
				glob.name='glob'+i;
				widgets.push(getChildByName('glob'+i));
				//random(400), random(400)
			}
		}


		function draw()
		{
			//translate(width/1.4,height/2);
			//scale(2);
			//rotate(30);
			background(255);
			  for(var i=0; i<nbGlob; i++)
			  {
				if(i==0) widgets[i].update(-50, -150); 
				else 
				{
					if(i%2==1) widgets[i].update(widgets[i-1].xPos, widgets[i-1].yPos); 
					else widgets[i].update(widgets[0].xPos, widgets[0].yPos); 
				}
			}
		}
	}
}
		
		
		
