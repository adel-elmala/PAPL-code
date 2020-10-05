import lists as L
# Graph Rep. No. 1 (foucsed around the vertecies)
data edgeW:
  |edw(adjKey :: String ,weight :: Number )
end
data Vertex:
  |vertex(key :: String , adj :: List<edgeW> )
end

type KnGraph = List<Vertex> 

# Graph Rep. No. 2 (foucsed around the edges)
data Edge:
  |edge(src :: String , dst :: String,weight :: Number)
end


type edgeGraph = List<Edge>

# rep.1
#type Node = Vertex
#type Graph1 = KnGraph


# rep.2

#type Graph2 = edgGraph

# rep.1

MIA = vertex("MIA",[list: edw("SFO",2),edw("ORD",4)])
SFO = vertex("SFO",[list: edw("ORD",3)])
ORD = vertex("ORD",[list: edw("ATL",1)])
BOS = vertex("BOS",[list:edw("ORD",2)])
ATL = vertex("ATL",[list:edw("BOS",6),edw("MIA",3)])

graph1 :: KnGraph = [list: MIA,SFO,ORD,BOS,ATL]


# rep.2


MIA-SFO = edge("MIA","SFO",2)
MIA-ORD = edge("MIA","ORD",4)
SFO-ORD = edge("SFO","ORD",3)
ORD-ATL = edge("ORD","ATL",1)
BOS-ORD = edge("BOS","ORD",2)
ATL-BOS = edge("ATL","BOS",6)
ATL-MIA = edge("ATL","MIA",3)


graph2 :: edgeGraph = [list : MIA-SFO,MIA-ORD,SFO-ORD,ORD-ATL,BOS-ORD,ATL-BOS,ATL-MIA]






data C-Weight:
  | c-weight(vtx :: String, w :: Number)
end

#weightslst = [list:c-weight("SFO",),c-weight(,)c-weight(,)c-weight(,)c-weight(,) ]

fun get-weight(vtx :: String, weights :: List<C-Weight>) -> Number:

  cases (List) weights:
    |empty => none
    |link(f,r) => 
      if f.vtx <=> vtx: f.w 
      else: get-weight(vtx,r)
      end
  end
end

fun set-weight(vtx :: String, w :: Number, weights :: List<C-Weight>) -> List<C-Weight>:
  cases (List) weights:
    |empty => link(c-weight(vtx,w),empty) 
    |link(f,r) => 
      if f.vtx <=> vtx:
        link(c-weight(vtx,w),r)
      else:
        link(f,set-weight(vtx,w,r))

      end
  end


end

fun get-vertices-helper(graph :: edgeGraph) -> List<String>:
  cases (List) graph:
    |empty => empty
    |link(f,r) =>
      link(f.src,link(f.dst,get-vertices-helper(r)) )
  end
end


fun get-vertices(graph :: edgeGraph) -> List<String>:
  L.distinct(get-vertices-helper(graph))

end



fun bellman-ford(graph :: edgeGraph, src :: String) -> List<C-Weight>:
  # assign inf to cumulitive weight inf to each vertex execpt src
  vertices = get-vertices(graph)
  c-weighted-verices = map(lam(v): 
    if v <=> src : c-weight(v,0) else: c-weight(v,999) end 
    end , vertices)
  #c-weighted-verices
  bellman-ford-repeat(graph.length(),graph,c-weighted-verices,bellman-ford-helper)
end

fun bellman-ford-helper(graph :: edgeGraph , weights) -> List<C-Weight>:
  cases (List) graph:
    |empty => weights
    |link(f,r) =>
      cum-w = get-weight(f.src,weights) + f.weight
      if cum-w < get-weight(f.dst,weights):
        bellman-ford-helper(r,set-weight(f.dst,cum-w,weights))
      else: bellman-ford-helper(r,weights)
      end
  end
end

fun bellman-ford-repeat(n :: Number ,graph :: edgeGraph,weights :: List<C-Weight>, f :: (edgeGraph,List<C-Weight>-> List<C-Weight>)) -> List<C-Weight>:
  
  result = f(graph,weights)
  
  if n > 0:
    bellman-ford-repeat(n - 1, graph,result,f)
  else: result
  end
end




a-b = edge("a","b",-1)
a-c = edge("a","c",4)
b-c = edge("b","c",3)
b-d = edge("b","d",2)
b-e = edge("b","e",2)
d-b = edge("d","b",1)
e-d = edge("e","d",-3)




graph3 :: edgeGraph = [list:a-b ,a-c ,b-c ,b-d ,b-e ,d-b,e-d]







