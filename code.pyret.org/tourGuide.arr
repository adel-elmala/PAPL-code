# CSCI0190 (Fall 2018)

provide *
provide-types *

import brown-university-landmarks, brown-university-tours from shared-gdrive(
  "tour-guide-data.arr", 
  "1u_UPQ0Z2N867XQQqJkGDo5MFFS97yysX")

include shared-gdrive(
  "tour-guide-definitions.arr",
  "1hVLncE2-w5JjhSucmLJdVaoxNWEylPjX")

## DO NOT EDIT ABOVE THIS LINE


# 1- what do i have ? 
#   = a graph , ** which representaion ? -> = a collection of vetricies (key,position,adjs) .
#   = a staring vertiex (Source) .
# 2- what i need to do ? 
#   = find the lightest (shortest) path from the source to all other verticies in the     graph.
# 3- plan to solve it -> 
#   = 2 sets of verticies , one for the verticies that have the total minimum distance (from source) (initially is the source node), another for the verticies that are not yet have been visitied .
# how to expand the minimum dist. set ?
#   = find all adjacent nodes to the nodes in the minimum set and pick the one that are not yet added and have total min. dist from source . then repeat till  the set contains all verticies in the graph 


# what helper funcs. might use?
#   = fun that extract nodes' names and attach a accumlator distance from source to each name (effectivly  a node) 

data Tag:
  |tag(name :: Name, acc :: Number)
end

fun total-distance-nodes(graph :: Graph)-> List<Tag>:
  doc:"attach an accumalator distance (initially '-99') to each node name in the graph"
  node-names = graph.names().to-list()

  map(tag(_,99999),node-names)

end

fun adjs(node :: Name , graph :: Graph) -> List<Name>:
  doc:"gets the adjacent node names"
  graph.get(node).neighbors.to-list()

end

fun drop(name :: Name ,tags :: List<Tag>) -> List<Tag>:
  cases (List) tags:
    |empty => empty
    |link(f,r) => 
      if f.name <=> name :
        r
      else:
        link(f,drop(name, r))
      end
  end
end

fun find-min(unvisited :: List<Tag>) -> Tag:
  find-min-helper(unvisited,unvisited.first)
end
fun find-min-helper(unvisited :: List<Tag>,min :: Tag) -> Tag:
  cases (List) unvisited:
    |empty => min
    |link(f,r) =>
      if min.acc > f.acc:
        find-min-helper(r,f)
      else:
        find-min-helper(r,min)
      end
  end
end
fun dijkstra(start :: Name, graph :: Graph) :
  # Implement me!
  block:
    number-of-nodes = graph.names().to-list().length()
    # attached accum. dist. to each node (initially 'none' to indicate unvisited)
    unvisited-list = total-distance-nodes(graph)
    # initialize a list that contain the start node
    minimum-list = [list: tag(start,0)]
    # drop the source from the unvisited list
    drop(start,unvisited-list)
    minimum-list
    #dijkstra-helper([list:tag("Wayland",0),tag("The-Ratty",5)],unvisited-list,graph,number-of-nodes)
    dijkstra-helper(minimum-list,unvisited-list,graph,number-of-nodes)

  end
end

fun dijkstra-helper(minimum :: List<Tag>,unvisited :: List<Tag>, graph :: Graph,n :: Number):
  # 1-  find adjs of each node in the minimum list (not in the minimum list already)
  # 2-  compute the accum distance from source to each adjs
  # 3-  add the least accum distance node to minimum list and drop it from the unvisited list 
  # 4-  repeat
  if n == minimum.length():
    minimum
  else:

    adjacents = eleminate-mins-from-adjs(adjs-to-min(minimum,graph),minimum)

    updated-unvisited = unvisited-updater(adjacents,minimum,unvisited,graph)

    min = find-min(updated-unvisited)
    new-minimum = minimum + [list: min] 
    new-unvisited = drop(min.name,updated-unvisited)
    dijkstra-helper(new-minimum ,new-unvisited,graph,n)
  end


end

fun unvisited-updater(adj :: List<List<Name>> ,minimum :: List<Tag>,unvisited :: List<Tag>,graph :: Graph) -> List<Tag>:

  cases (List) minimum:
    |empty => unvisited
    |link(f,r) => 
      cases (List) adj:
        |empty => unvisited
        | link(f2,r2) => 
          updated= unvisited-updater-helper(f2,f,unvisited,graph)
          unvisited-updater(r2,r,updated,graph)
      end


  end
end

fun unvisited-updater-helper(adj :: List<Name> ,minimum :: Tag,unvisited :: List<Tag>,graph :: Graph)-> List<Tag>:
  cases (List) adj:
    | empty => unvisited
    | link(f,r) =>
      new-unvisited= map({(x): if f <=> x.name: if ( (minimum.acc + graph.get(minimum.name).distance(graph.get(x.name))) < x.acc):  tag(x.name,minimum.acc + graph.get(minimum.name).distance(graph.get(x.name))) else: x end else:x end },unvisited)
      unvisited-updater-helper(r,minimum ,new-unvisited ,graph) 
  end
end


fun adjs-to-min(minimum :: List<Tag>, graph :: Graph) -> List<Name>:
  cases (List) minimum:
    | empty => empty
    | link(f,r) =>
      link(adjs(f.name,graph) ,adjs-to-min(r,graph))
  end
end

fun eleminate-mins-from-adjs(adj :: List<Name>,min :: List<Tag>) -> List<Name>:
  cases (List) min:
    |empty => adj
    |link(f,r) =>
      filtered-adjs = map({(l):filter({(a) : if a == f.name:false else:true end},l)},adj)
      eleminate-mins-from-adjs(filtered-adjs,r)
  end
end
```
fun campus-tour(
    tours :: Set<Tour>,
    start-position :: Point,
    campus-data :: Graph) -> Path:
  # Implement me!
  ...
end
```


test-graph  :: Graph = [set: 
  place("a",
    point(0,0),
    [set: "b",
      "c",
      "h"
    ]),
  place("b",
    point(10,10 ),
    [set: "a",
      "e",
      "f"
    ]),
  place("c",
    point(50,10),
    [set: "a",
      "d",
      "e"]),
  place("d",
    point(50, 30),
    [set: "c",
      "g",
      "f",
      "e"]),
  place("e",
    point(30,30),
    [set: "b",
      "d",
      "f",
      "c"]),
  place("f",
    point(30,60),
    [set: "e",
      "d",
      "b",
      "g",
      "h"
    ]),
  place("g",
    point(50, 80),
    [set: "h",
      "f",
      "d"]),

  place("h",
    point(10, 50),
    [set: "g",
      "f",
      "a"])] ^ to-graph

