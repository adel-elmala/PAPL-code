# mine works fine HoHo
fun dbl_count(lst1 :: List<Any>  , lst2 :: List<Any>) -> Number:
  cases (List) lst1:
    | empty => # 1*(k+1)
      cases (List) lst2: 
        |empty => 0 
        |link(ff,rr) => 1 + dbl_count(lst1, rr)
      end
    | link(f,r) => 
      cases (List) lst2:
        |empty =>  1 + dbl_count(r, lst2)
        |link(ff,rr) => 2 + dbl_count(r,rr)
      end
  end
end


# Dosen't work hehe
fun dbl-count2(list1, list2):
  cases (List) list1:
    | empty => 0
    | link(f, r) =>
      cases (List) list2:
        | empty => 0
        | link(ff, rr) => 1 + dbl-count2(r) + 1 + dbl-count2(rr)
      end
  end
end   