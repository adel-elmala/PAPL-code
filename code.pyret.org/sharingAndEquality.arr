import lists as ls
data BinTree:
  | leaf
  | node(v, l :: BinTree, r :: BinTree)
end

a-tree =
  node(5,
    node(4, leaf, leaf),
    node(4, leaf, leaf))


four-node = node(4, leaf, leaf)

b-tree = node(5,
  four-node,
  four-node)





check:

  a-tree is b-tree

  a-tree.l is b-tree.l

  a-tree.l is a-tree.r

  b-tree.l is b-tree.r
  b-tree.l is a-tree.l 

end


check:
  a-tree is-not%(identical) b-tree
  a-tree.l is%(identical) a-tree.l
  a-tree.l is-not%(identical) a-tree.r
  b-tree.l is%(identical) b-tree.r
end


L = range(0,10)


L1 = link(5,L)
L2 = link(15,L)

check:
  L1.rest is%(identical) L
  L2.rest is%(identical) L
  L1.rest is%(identical) L2.rest
end






rec web-colors = link("white", link("grey", web-colors))





