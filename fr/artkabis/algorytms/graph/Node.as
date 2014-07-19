package  fr.artkabis.algorytms.graph
{
	import flash.display.Sprite;
	import flash.geom.Vector3D;

	public class Node extends Sprite
	{
		private var pos:Vector3D;
		private var index:int;
		public function Node(idx:int,n_Pos:Vector3D)
		{
			index=idx;
			pos=n_Pos;
			this.x=n_Pos.x;
			this.y=n_Pos.y;
			idx_txt.text=String(idx)
		}

		public function getIndex():int
		{
			return index;
		}
		public function setPos(n_Pos:Vector3D):void
		{
			pos=n_Pos;
		}

		public function getPos():Vector3D
		{
			return pos;
		}
	}
}
