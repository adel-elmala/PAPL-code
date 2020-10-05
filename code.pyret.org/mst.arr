# CSCI0190 (Fall 2018)
provide *
provide-types *

import shared-gdrive("mst-support.arr", 
  "1NWo987lW1EmeT5bU6qC1asG_K4lq8KBr") as S

# Imports below
import lists as L
# Imports above
type Graph = S.Graph
type Edge = S.Edge

edge = S.edge

#####################################
### DO NOT CHANGE ABOVE THIS LINE ###
#####################################
data Element<T>:
  |elt(val :: T, ref parent :: Option<Element>)
end

fun is-in-same-set(e1 :: Element, e2 :: Element) -> Boolean:
  s1 = fynd(e1)
  s2 = fynd(e2)
  identical(s1, s2)
end

fun update-set-with(child :: Element, parent :: Element):
  child!{parent: some(parent)}
end

fun fynd(e :: Element) -> Element:
  cases (Option) e!parent block:
    | none => e
    | some(p) =>
      new-parent = fynd(p)
      e!{parent: some(new-parent)}
      new-parent
  end
end
fun union(e1 :: Element, e2 :: Element):
  s1 = fynd(e1)
  s2 = fynd(e2)
  if identical(s1, s2):
    s1
  else:
    update-set-with(s1, s2)
  end
end
# MST Functions


test-graph3 :: Graph = [list : 
  edge('0','1',4),
  edge('0','7',8),
  edge('1','2',8),
  edge('1','7',11),
  edge('7','8',7),
  edge('7','6',1),
  edge('2','8',2),
  edge('2','5',4),
  edge('2','3',7),
  edge('8','6',6),
  edge('6','5',2),
  edge('3','4',9),
  edge('3','5',14),
  edge('5','4',10)
]




test-graph :: Graph = [list : edge('a','b',1),
  edge('a','c',2),
  edge('a','d',7),
  edge('a','e',3),
  edge('b','c',4),
  edge('b','d',4),
  edge('b','e',6),
  #edge('b','a',1),
  edge('c','d',5),
  #edge('c','a',5),
  edge('c','e',1),
  #edge('c','b',4),
  edge('d','e',4)
  #edge('d','c',5),
  #edge('d','a',7),
  #edge('d','b',4),
]

test-graph2 :: Graph = [list : edge('a','b',3),

  edge('b','c',2),
  edge('c','d',1),
  edge('d','a',4),

]
## sort the egdes based on thier weights ascendingly 
## take the min egde if doesn't create cycles !! 
## finish if number of edges = no. verticies - 1

fun graph-nodes(graph :: Graph) -> List<String>:
  L.distinct(graph-nodes-helper(graph))
end

fun graph-nodes-helper(graph :: Graph) -> List<String>:
  cases (List) graph:
    |empty => empty
    |link(f,r) => 
      link(f.a,link(f.b,graph-nodes(r)))
  end

end

fun sort-edges(graph :: Graph )-> List<Edge>:
  cases (List) graph:
    | empty => empty
    | link(f,r) =>
      min = sort-edges-helper(graph,graph.first)
      link(min,sort-edges(drop-edge(graph,min)))
  end

end
fun drop-edge(graph :: Graph,edg :: Edge) -> Graph:
  cases (List) graph:
    |empty => empty
    |link(f,r) =>
      if f == edg:
        r
      else:
        link(f,drop-edge(r,edg))
      end
  end
end
fun sort-edges-helper(graph :: Graph , min :: Edge)-> Edge:
  cases (List) graph:
    | empty => min
    | link(f,r) =>
      if f.weight < min.weight:
        new-min = f
        sort-edges-helper(r,new-min)
      else:
        sort-edges-helper(r,min)
      end
  end
end

fun min-edge(graph :: Graph )-> Edge:
  sort-edges-helper(graph , graph.first)
end

fun get-set-elt(seet :: List<Element>,nd :: String)-> Element:
  cases (List) seet:
    |empty => raise("Empty")
    |link(f,r) =>
      if f.val == nd:
        f
      else:
        get-set-elt(r,nd)
      end
  end


end

fun mst-kruskal(graph :: Graph) -> List<Edge>: 

  ordered-edges = sort-edges(graph)
  g-nodes = graph-nodes(graph)
  nodes-set = map(elt(_,none),g-nodes)


  fun mst-kruskal-helper(ascend-edges :: List<Edge>, e :: Number,n :: Number) -> List<Edge>:
    cases (List) ascend-edges:
      |empty => empty
      |link(f,r) => 
        e1 = get-set-elt(nodes-set,f.a)
        e2 = get-set-elt(nodes-set,f.b)
        if is-in-same-set(e1,e2):
          mst-kruskal-helper(r,e,n)
        else:

          if e <= (n - 1) :
            block:
              union(e1,e2)
              link(f,mst-kruskal-helper(r,e + 1,n))
              # of the added edge
            end
          else:
            mst-kruskal-helper(r,e,n)

          end
        end
    end
  end

  mst-kruskal-helper(ordered-edges,0,L.length(g-nodes))
end


## working with a list of edges graph rep. 
# get all nodes of the graph
# pick a node 
# find all edges incident on that node and pick min weight edge that does not create a cycle
# repeat till all nodes are connected

fun find-adjs-helper(graph :: Graph , node :: String) -> List<Edge>:
  cases (List) graph :
    |empty => empty
    |link(f,r) => 
      if ((f.a) == node) or ((f.b) == node):
        link(f,find-adjs-helper(r,node))
      else:
        find-adjs-helper(r,node)
      end
  end
end

fun find-adjs(graph :: Graph , nodes :: List<String>):
  cases (List) nodes:
    |empty => empty
    |link(f,r) =>
      find-adjs-helper(graph,f) + find-adjs(graph,r)
  end
end


fun mst-prim(graph :: Graph) -> List<Edge>:

  g-nodes = graph-nodes(graph)
  nodes-no = L.length(g-nodes)
  nodes-set = map(elt(_,none),g-nodes)


  fun mst-prim-helper(sol-edges :: List<Edge> , sol-nodes :: List<String>) -> List<Edge>:
    adjs = find-adjs(graph,sol-nodes)
    filtered-adjs = filter-adjs(adjs,sol-edges)

    min = mst-prim-helper2(filtered-adjs)
    new-sol-edges = link(min,sol-edges)
    new-sol-nodes = graph-nodes(sol-edges)
    if nodes-no == L.length(sol-nodes):
      new-sol-edges
    else:

      mst-prim-helper(new-sol-edges,new-sol-nodes)
    end
  end

  fun mst-prim-helper2(adjac :: List<Edge>)-> Edge:
    min = min-edge(adjac)


    e1 = get-set-elt(nodes-set,min.a)
    e2 = get-set-elt(nodes-set,min.b)
    if is-in-same-set(e1,e2):
      new-adjac = drop-edge(adjac, min)
      mst-prim-helper2(new-adjac)

    else:
      block:
        
        #raise("was here")
        union(e1,e2)
        min
      end
    end
  end

  mst-prim-helper(empty,[list: g-nodes.first ])
end

fun filter-adjs(adjs :: List<Edge> , sol :: List<Edge>):
  cases (List) sol:
    |empty => adjs
    |link(f,r) =>
      new-adjs = filter({(x): if x == f: false else: true end},adjs)
      filter-adjs(new-adjs,r)
  end
end


# Oracle Functions

fun generate-input(num-vertices :: Number) -> Graph:
  ...
end

fun mst-cmp(
    graph :: Graph,
    mst-alg-a :: (Graph -> List<Edge>),
    mst-alg-b :: (Graph -> List<Edge>))
  -> Boolean:
  ...
end

fun sort-o-cle(
    mst-alg-a :: (Graph -> List<Edge>),
    mst-alg-b :: (Graph -> List<Edge>))
  -> Boolean:
  ...
end
