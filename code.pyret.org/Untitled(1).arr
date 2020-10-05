data BT:
  |leaf
  |node(v :: Number,l :: BT,r :: BT) 
end

# binary tree >> so membership is still have to me checked on each node of the tree >> still linear (or atleast not LOG)...
fun is-in-bt(e :: Number, s :: BT) -> Boolean:
  cases (BT) s:
    |leaf => false
    |node(v,l,r) =>
      if e == v:true
      else:
        is-in-bt(e,l) or is-in-bt(e,r)
      end
  end
end



fun is-a-bst(b :: BT) -> Boolean:
  cases (BT) b:
    | leaf => true
    | node(v, l, r) =>
      (is-leaf(l) or (l.v <= v)) and
      (is-leaf(r) or (v <= r.v)) and
      is-bst-helper-left(l,b.v) and
      is-bst-helper-right(r,b.v)
  end
end

fun is-bst-helper-left(b :: BT , superRoot :: Number)->Boolean:
  cases (BT) b:
    | leaf => true
    | node(v, l, r) =>
      (is-leaf(l) or (l.v <= v)) and
      (is-leaf(r) or ((v <= r.v) and (r.v <= superRoot))) and
      is-bst-helper-left(l,v) and
      is-bst-helper-left(r,v)
  end
end
fun is-bst-helper-right(b :: BT , superRoot :: Number)->Boolean:
  cases (BT) b:
    | leaf => true
    | node(v, l, r) =>
      (is-leaf(l) or ((l.v <= v) and (l.v >= superRoot))) and
      (is-leaf(r) or (v <= r.v)) and
      is-bst-helper-right(l,v) and
      is-bst-helper-right(r,v)
  end


end

fun is-a-bst-buggy(b :: BT) -> Boolean:
  cases (BT) b:
    | leaf => true
    | node(v, l, r) =>
      (is-leaf(l) or (l.v <= v)) and
      (is-leaf(r) or (v <= r.v)) and
      is-a-bst-buggy(l) and
      is-a-bst-buggy(r)
  end
end
check:
  node(5, node(3, leaf, node(4, leaf, leaf)), leaf)
    satisfies is-a-bst # FALSE!
  node(30,node(10,node(5,leaf,leaf),leaf),leaf) satisfies is-a-bst

  node(50,node(10,leaf,node(40,leaf,leaf)),node(90,leaf,leaf)) satisfies is-a-bst
end