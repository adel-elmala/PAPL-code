data BinT:
  | leaf
  | node(v, l :: ( -> BinT), r :: ( -> BinT))
end


rec tr = node("rec", lam(): tr end, lam(): tr end)
t0 = node(0, lam(): leaf end, lam(): leaf end)
t1 = node(1, lam(): t0 end, lam(): t0 end)
t2 = node(2, lam(): t1 end, lam(): t1 end)


## wrong imp. to count nodes (doesn't take in account identical nodes so theya re counted multiple times instead of only once)
fun sizeinf(t :: BinT) -> Number:
  cases (BinT) t:
    | leaf => 0
    | node(v, l, r) =>
      ls = sizeinf(l())
      rs = sizeinf(r())
      1 + ls + rs
  end
end


#check:
# size(tr) is 1
# size(t0) is 1
# size(t1) is 2
# size(t2) is 3
#end


## still counts identical nodes more than once ,as it forgets the traversed left side and seenlist of the right is just the current node and the parents not the deeper left side also.
fun sizect(t :: BinT) -> Number:
  fun szacc(shadow t :: BinT, seen :: List<BinT>) -> Number:
    if has-id(seen, t):
      0
    else:
      cases (BinT) t:
        | leaf => 0
        | node(v, l, r) =>
          ns = link(t, seen)
          ls = szacc(l(), ns)
          rs = szacc(r(), ns)
          1 + ls + rs
      end
    end
  end
  szacc(t, empty)
end


fun size(t :: BinT) -> Number:
  fun szacc(shadow t :: BinT, seen :: List<BinT>)
    -> {n :: Number, s :: List<BinT>}:
    if has-id(seen, t):
      {n: 0, s: seen}
    else:
      cases (BinT) t:
        | leaf => {n: 0, s: seen}
        | node(v, l, r) =>
          ns = link(t, seen)
          ls = szacc(l(), ns)
          rs = szacc(r(), ls.s)
          {n: 1 + ls.n + rs.n, s: rs.s}
      end
    end
  end
  szacc(t, empty).n
end


fun has-id<A>(seen :: List<A>, t :: A):
  cases (List) seen:
    | empty => false
    | link(f, r) =>
      if f <=> t: true
      else: has-id(r, t)
      end
  end
end











## Graph rep #1 key-links

type key = String # assuming that the unique identifier of the node is the name of the node

data KeyNode:
  |keyed-node(key :: key , content , adj :: List<String>)
end

type kNgraph = List<KeyNode>


type Graph = kNgraph
type Node = KeyNode




kn-cities :: kNgraph = block:
  knWAS = keyed-node("was", "Washington", [list: "chi", "den", "saf", "hou", "pvd"])
  knORD = keyed-node("chi", "Chicago", [list: "was", "saf", "pvd"])
  knBLM = keyed-node("bmg", "Bloomington", [list: ])
  knHOU = keyed-node("hou", "Houston", [list: "was", "saf"])
  knDEN = keyed-node("den", "Denver", [list: "was", "saf"])
  knSFO = keyed-node("saf", "San Francisco", [list: "was", "den", "chi", "hou"])
  knPVD = keyed-node("pvd", "Providence", [list: "was", "chi"])
  [list: knWAS, knORD, knBLM, knHOU, knDEN, knSFO, knPVD]
end


## graph rep #2 indexed-keys (the keys are not part of the datum(Node) put infered from other datastructure (the graph)  ) 
data IndexedNode:
  | idxed-node(content, adj :: List<Number>)
end

type IXGraph = List<IndexedNode>

#type Node = IndexedNode
#type Graph = IXGraph


ix-cities :: IXGraph = block:
  inWAS = idxed-node("Washington", [list: 1, 4, 5, 3, 6])
  inORD = idxed-node("Chicago", [list: 0, 5, 6])
  inBLM = idxed-node("Bloomington", [list: ])
  inHOU = idxed-node("Houston", [list: 0, 5])
  inDEN = idxed-node("Denver", [list: 0, 5])
  inSFO = idxed-node("San Francisco", [list: 0, 4, 3])
  inPVD = idxed-node("Providence", [list: 0, 1])
  [list: inWAS, inORD, inBLM, inHOU, inDEN, inSFO, inPVD,inWAS] ## weakness here is that even the same identical node (inWAS @ Zero & @ 7th indix) now have the 2 different keys (0 and 7) so one way to restrict that is to check for membership before inserting new nodes into the graph (which must be done anyway so not a problem really :D)
end


## graph rep. #3 link-of-egdes (treats the graph as a collection of edges (that is a src to dist rep of an edge))

data Edge:
  |edge(src :: String, dst :: String) 

end

type LEgraph = List<Edge>

le-cities :: LEgraph =
  [list:
    edge("Washington", "Chicago"),
    edge("Washington", "Denver"),
    edge("Washington", "San Francisco"),
    edge("Washington", "Houston"),
    edge("Washington", "Providence"),
    edge("Chicago", "Washington"),
    edge("Chicago", "San Francisco"),
    edge("Chicago", "Providence"),
    edge("Houston", "Washington"),
    edge("Houston", "San Francisco"),
    edge("Denver", "Washington"),
    edge("Denver", "San Francisco"),
    edge("San Francisco", "Washington"),
    edge("San Francisco", "Denver"),
    edge("San Francisco", "Houston"),
    edge("Providence", "Washington"),
    edge("Providence", "Chicago") ] ## one of the backdraws of this rep is that nodes that aren't connected to other nodes doses'nt not appear in the graph
## another weakness is that to encode all info of a single node , multiples edges have to be inserted as above






#map(_.content, map(find-kn(_, kn-cities), ns))


fun find-kn(key :: key, graph :: Graph) -> Node:
  matches = for filter(n from graph):
    n.key == key
  end
  matches.first # there had better be exactly one!
end

fun kn-neighbors(city :: key,  graph :: Graph) -> List<key>:
  city-node = find-kn(city, graph)
  city-node.adj
end

neighbors = kn-neighbors
fun ormap(fun-body, l):
  cases (List) l:
    | empty => false
    | link(f, r) =>
      if fun-body(f): true else: ormap(fun-body, r) end
  end
end
fun reach-3(s :: key, d :: key, g :: Graph) -> Boolean:
  fun reacher(src :: key, dst :: key, visited :: List<key>) -> Boolean:
    if visited.member(src):
      false
    else if src == dst:
      true
    else:
      new-visited = link(src, visited)
      for ormap(n from neighbors(src, g)):
        reacher(n, dst, new-visited)
      end
    end
  end
  reacher(s, d, empty)
end





test :: kNgraph = block:
  a = keyed-node("a", "a", [list: "b", "e"])
  b = keyed-node("b", "b", [list: "c"])
  c = keyed-node("c", "c", [list: "d"])
  d = keyed-node("d", "d", [list: "b"])
  e = keyed-node("e", "e", [list: "b"])
  [list: a, b, c, d, e]
end

test2 :: kNgraph = block:
  a = keyed-node("a", "a", [list: "b", "e"])
  b = keyed-node("b", "b", [list: "c"])
  c = keyed-node("c", "c", [list: "d"])
  d = keyed-node("d", "d", [list: ])
  e = keyed-node("e", "e", [list: "b"])
  [list: a, b, c, d, e]
end
fun reach-1(src :: key, dst :: key, g :: Graph) -> Boolean:

  fun loop(ns):

    cases (List) ns:

      | empty => false

      | link(f, r) =>

        if reach-1(f, dst, g): true else: loop(r) end

    end

  end
  if src == dst:

    true

  else:


    loop(neighbors(src, g))

  end

end