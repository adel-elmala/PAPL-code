provide *
provide-types *

include shared-gdrive("heaps-lab-oracle.arr", "0B15X1zsBYb5jblFlZnNjQXJQQWs")

#|data Heap:
  | mt
  | node(value :: Number, left :: Heap, right :: Heap)
   end|#

fun insert(elt :: Number, h :: Heap) -> Heap:
  doc: ```Takes in a Number elt and a proper Heap h produces
       a proper Heap that has all of the elements of h and elt.```
  mt
end

check "Running TA oracle":
  oracle(50, 10, insert, remove-min, get-min) is true
end
  

fun get-min(h :: Heap%(is-node)) -> Number:
  doc: ```Takes in a proper, non-empty Heap h and produces the
       minimum Number in h.```
  h.value
end

fun remove-min(h :: Heap%(is-node)) -> Heap:
  doc: ```Given a proper, non-empty Heap h, removes its minimum element.```
  amputated = amputate-bottom-left(h)
  top-replaced = 
    cases(Heap) amputated.heap:
      | mt => mt
      | node(val, lh, rh) =>
        node(amputated.elt, lh, rh)
    end
  reorder(rebalance(top-replaced))
end



##### remove-min helpers #####

data Amputated:
  | elt-and-heap(elt :: Number, heap :: Heap)
end

fun amputate-bottom-left(h :: Heap%(is-node)) -> Amputated:
  doc: ```Given a Heap h, produes an Amputated that contains the 
       bottom-left element of h, and h with the bottom-left element removed.```
  cases(Heap) h.left:
    | mt => elt-and-heap(h.value, mt)
    | node(_, _, _) => 
      rec-amputated = amputate-bottom-left(h.left)
      elt-and-heap(rec-amputated.elt, node(h.value, rec-amputated.heap, h.right))
  end
end

fun rebalance(h :: Heap) -> Heap:
  doc: ```Given a Heap h, switches all children along the leftmost path```
  cases(Heap) h:
    | mt => mt
    | node(val, lh, rh) =>
      node(val, rh, rebalance(lh))
  end
end

fun reorder(h :: Heap) -> Heap:
  doc: ```Given a Heap h, where only the top node is misplaced,
       produces a Heap with the same elements but in proper order.```
  cases(Heap) h:
    | mt => mt
    | node(val, lh, rh) =>
      cases(Heap) lh:
        | mt => node(val, mt, mt)
        | node(lval, llh, lrh) =>
          cases(Heap) rh:
            | mt => 
              node(num-min(val, lval), node(num-max(val, lval), mt, mt), mt)
            | node(rval, rlh, rrh) =>
              if lval <= rval:
                if val <= lval:
                  h
                else:
                  node(lval, reorder(node(val, llh, lrh)), rh)
                end
              else:
                if val <= rval:
                  h
                else:
                  node(rval, lh, reorder(node(val, rlh, rrh)))
                end
              end
          end
      end
  end
end