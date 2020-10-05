#include lists as l
fun f-to-c(temp :: List<Number>)-> List<Number>:
  cases (List) temp:
    | empty => empty
    |link(f,r) => link(5/9 * (f - 32),f-to-c(r))
  end
end

check:
  f-to-c([list: 131, 77, 68]) is [list: 55, 25, 20]
end

fun goldilocks(temp :: List<Number>)-> List<String>:
  cases (List) temp:
    | empty => empty
    |link(f,r) => 
      if f > 90:
        link('too hot',goldilocks(r))
      else if f < 70:
        link('too cold',goldilocks(r))
      else:
        link('just right',goldilocks(r))
      end
  end
end
check:
  goldilocks([list: 131, 77, 68]) is
  [list: "too hot", "just right", "too cold"]
end

fun status(temp :: Number)-> String:
  if temp > 90:
    'too hot'
  else if temp < 70:
    'too cold'
  else:
    'just right'
  end
end

fun goldilocks-mapped(temp:: List<Number>)-> List<String>:
  map(status,temp)
end
check:
  goldilocks-mapped([list: 131, 77, 68]) is
  [list: "too hot", "just right", "too cold"]
end


fun my-map<T,Z>(fn :: (T -> Z) , lst :: List<T>) -> List<Z>:
  doc: "Simple map function that takes a list and the function to be applied on each elemnt of the list and produces a new list of the same lenght"
  cases (List) lst:
    | empty => empty
    |link(f,r) => link(fn(f),my-map(fn,r))
  end
end

check:
  my-map(num-tostring, [list: 1, 2]) is [list: "1", "2"]
  my-map(lam(x): x + 1 end, [list: 1, 2]) is [list: 2, 3]
end



fun tl-dr<T>(lol :: List<List<T>>,length-thresh :: Number) -> List<List<T>>:
  filter({(elmt):elmt.length() < length-thresh},lol)
end

check:
  tl-dr([list:[list:1,2,3,4],[list:'a','b','s','v','a','b','s'],[list: 88,66,555,22,11,999,8],[list:'e','e','ee']],5) is [list: [list: 1, 2, 3, 4], [list: "e", "e", "ee"]]
end

fun eliminate-e(words :: List<String>) -> List<String>:
  filter({(elmnt):not(string-to-code-points(elmnt).member(101))},words)
end

check:
  eliminate-e([list:]) is empty
  eliminate-e([list:'e','we','adel','hoho','hehe']) is [list: 'hoho']
end


fun my-filter<T>(fn :: (T -> T), lst :: List<T>)-> List<T>:
  cases (List) lst:
    |empty => empty
    |link(f,r) =>
      if fn(f):
        link(f,my-filter(fn,r))
      else:
        my-filter(fn,r)
      end
  end
end
fun my-eliminate-e(words :: List<String>) -> List<String>:
  my-filter({(elmnt):not(string-to-code-points(elmnt).member(101))},words)
end

check:
  my-eliminate-e([list:]) is empty
  my-eliminate-e([list:'e','we','adel','hoho','hehe']) is [list: 'hoho']
end

fun my-tl-dr<T>(lol :: List<List<T>>,length-thresh :: Number) -> List<List<T>>:
  my-filter({(elmt):elmt.length() < length-thresh},lol)
end

check:
  my-tl-dr([list:[list:1,2,3,4],[list:'a','b','s','v','a','b','s'],[list: 88,66,555,22,11,999,8],[list:'e','e','ee']],5) is [list: [list: 1, 2, 3, 4], [list: "e", "e", "ee"]]
end


fun list-product(lon :: List<Number>) -> Number:
  fold({(acc,cur): acc * cur},1,lon)
end

fun list-max(lon :: List<Number>) -> Number:
  fold(lam(acc,cur): if cur > acc:cur else: acc end end,lon.first,lon)
end


fun my-fold<T1,T2>(folder :: (T2,T1->T2) , base :: T2 ,lst :: List<T1>)->T2:
  acc = base
  cases (List) lst:
    |empty => acc
    |link(f,r) =>
      my-fold(folder,folder(acc,f),r)
  end
end

check:
  my-fold({(acc,cur):acc * cur},1,[list:]) is 1
  my-fold({(acc,cur):acc * cur},1,[list:1,2,3,4,5,6,7,90]) is 453600
end
check:
  my-fold((lam(acc, elt): acc + elt end), 0, [list: 3, 2, 1]) is 6
  my-fold((lam(acc, elt): acc + elt end), 10, [list: 3, 2, 1]) is 16
  fun combine(acc, elt) -> String:
    tostring(elt) + " - " + acc
  end
  my-fold(combine, "END", [list: 3, 2, 1]) is "1 - 2 - 3 - END"
  my-fold(combine, "END", empty) is "END"
end

fun who-passed(score :: List<Number>, extra-crdt :: List<Boolean>) -> List<Boolean>:
  map2(lam(s,c):if (s > 75) or ((s > 65) and c):true else: false end end,score,extra-crdt)
end



check:
  score = [list: 50,49,90,89,67,65]
  crdt = [list: true,true,false,true,true,false]
  who-passed(score,crdt) is [list: false,false,true,true,true,false]
end


fun my-map2<T1,T2,T>(fn :: (T2,T1 ->T),lst1 :: List<T1>,lst2:: List<T2>)->List<T>:
  cases (List) lst1:
    |empty => empty
    |link(f,r) =>
      link(fn(f,lst2.first),my-map2(fn,r,lst2.rest))
  end
end


fun my-who-passed(score :: List<Number>, extra-crdt :: List<Boolean>) -> List<Boolean>:
  my-map2(lam(s,c):if (s > 75) or ((s > 65) and c):true else: false end end,score,extra-crdt)
end



check:
  score = [list: 50,49,90,89,67,65]
  crdt = [list: true,true,false,true,true,false]
  my-who-passed(score,crdt) is [list: false,false,true,true,true,false]
end




