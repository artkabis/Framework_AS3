package fr.artkabis.algoritms{

	import fr.artkabis.algorytms.graph.Edge;
	import fr.artkabis.algorytms.graph.Graph;
	import fr.artkabis.algorytms.utils.IndexedPriorityQ;

	public class Dijkstra {

		private var graph:Graph
		private var SPT:Vector.<Edge>
		private var cost2Node:Vector.<Number>
		private var SF:Vector.<Edge>
		private var source:int;
		private var target:int;

		public function Dijkstra(n_graph:Graph,src:int,tar=int) {
			graph=n_graph;
			source=src;
			target=tar;
			SPT= new Vector.<Edge>(graph.numNodes());
			cost2Node = new Vector.<Number>(graph.numNodes());
			SF = new Vector.<Edge>(graph.numNodes());
			search();
		}
		private function search():void
		{
			var pq:IndexedPriorityQ = new IndexedPriorityQ(cost2Node)
			pq.insert(source);
			while(!pq.isEmpty())
			{

				var NCN:int = pq.pop();

				SPT[NCN]=SF[NCN];

				if(SPT[NCN])
				{
					SPT[NCN].drawEdge(
						graph.getNode(SPT[NCN].getFrom()).getPos(),
						graph.getNode(SPT[NCN].getTo()).getPos(),
						"visited"
					);
				}

				if(NCN==target)return;

				var edges:Array=graph.getEdges(NCN);

				for each(var edge:Edge in edges)
				{
					var nCost:Number = cost2Node[NCN]+edge.getCost();

					if(SF[edge.getTo()]==null)
					{
						cost2Node[edge.getTo()]=nCost;
						pq.insert(edge.getTo());
						SF[edge.getTo()]=edge;
					}

					else if((nCost<cost2Node[edge.getTo()])&&(SPT[edge.getTo()]==null))
					{
						cost2Node[edge.getTo()]= nCost;
						pq.reorderUp();
						SF[edge.getTo()]=edge;
					}
				}
			}
		}

		public function getPath():Array
		{
			var path:Array = new Array();
			if((target<0)||(SPT[target]==null)) return path;
			var nd:int=target;
			path.push(nd);
			while((nd!=source)&&(SPT[nd]!=null))
			{
				SPT[nd].drawEdge(
					graph.getNode(SPT[nd].getFrom()).getPos(),
					graph.getNode(SPT[nd].getTo()).getPos(),
					"path"
				);
				nd = SPT[nd].getFrom()
				path.push(nd);
			}
			path = path.reverse();

			return path;
		}
	}
}
