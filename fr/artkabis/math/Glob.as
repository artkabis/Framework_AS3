package fr.artkabis.math
{
	public class Glob
	{ 
		var xPos, yPos, wDiameter, wStroke, color wColor, diameterDelta, strokeDelta, bv1, bv2, bv3, bv4, bv5, bv6, xPosOffset, yPosOffset, xMult, yMult, dMult, xInt, yInt, xInc, yInc, dInt, dInc, waveBool;;
			  
		public function Glob ($x:int, $y:int)
		{  
			xPos = $x;
			yPos = $y; 
			
			xInt = Math.round(random(300))* random(-1,1);
			yInt = Math.round(random(300))* random(-1,1);
			dInt = Math.round(random(5))* random(-1,1);
			xInc = Math.round(random(4))* random(-1,1);
			yInc = Math.round(random(4))* random(-1,1);
			dInc = random(10);
			dMult=random(40);
			xMult=random(200)* random(-1,1);
			yMult=random(700)* random(-1,1);
			xPosOffset = random(200)* random(-.5,1);
			yPosOffset = random(200)* random(-.5,1);
			
			waveBool = Math.round(random(1));
			
			bv1=random(0);
			bv2=random(0);
			bv3=160;
			bv4=150;
			bv5=90;
			bv6=155;
		} 
		private function  update($x, $y) 
		{ 
			if(waveBool==1){
			  xPos = (Math.sin(radians(xInt))* xMult)+x; 
			  yPos = (Math.cos(radians(yInt))* yMult)+y;
			}else {
			   xPos = (Math.cos(radians(xInt))* xMult)+x; 
			  yPos = (Math.sin(radians(yInt))* yMult)+y; 
			}
			//ellipseMode(CENTER);
			//noFill();
			
			strokeWeight(.5);
			stroke(30);
			noFill();
			beginShape();
			vertex(xPos, yPos);
			bezierVertex(bv1, bv2, bv3, bv4, bv5, bv6);
			endShape();
			
			stroke(0);
			var rad = Math.sin(radians(dInt))* dMult;
			strokeWeight(.5);
			
			alpha(10);
			fill(255, 255, 255, 50);
			ellipse(xPos,yPos,rad*1.25,rad* 1.25);
			alpha(100);
			
			strokeWeight(1.25);
				
		
			fill(255,255,255);
			ellipse(xPos,yPos,rad,rad);
			//strokeWeight(.5);
			//noFill();
			//ellipse(xPos,yPos,rad*2,rad*2);
			strokeWeight(.5);
			
			fill(255,0,0);
			ellipse(xPos, yPos, 2, 2);
			
			float inc = tan(radians(dInc))*2;
			
			xInc += Math.sin(radians(xInc))* xInc* random(-1, 1);
			yInc += Math.sin(radians(yInc))* yInc* random(-1, 1);
			dInc += Math.sin(radians(dInc))* dInc* random(-1, 1);
			xInt += xInc+inc;
			yInt += yInc+inc;
			dInt += dInc;
		} 
		private function radians($degr:Number):Number
		{
			var rad:Number = Math.PI * ($degr) / 180 ;
			return rad;
		}
	}
}

		
		
