fun my-quickSort(lst :: List<Number>) -> List<Number>:
  cases (List) lst:
    | empty => empty
    | link(pivot,r) =>
      less = helper(r,pivot,"less")
      more = helper(r,pivot,"more")
      my-quickSort(less) + [list:pivot]  + my-quickSort(more)

      
  end
end

fun helper(sub :: List<Number> ,pivot :: Number,predicate :: String) -> List<Number>:
  cases (List) sub:
    |empty => empty
    | link(f,r) => 
      if predicate == "less":
        if f < pivot :
          link(f , helper(r,pivot,predicate))
        else:
          helper(r,pivot,predicate)
        end
      else:
        if f >= pivot:
          link(f,helper(r,pivot,predicate))
        else:
          helper(r,pivot,predicate)
        end
  end end
end
          

