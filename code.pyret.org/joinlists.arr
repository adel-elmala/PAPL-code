# CSCI0190 (Fall 2018)
provide *

import shared-gdrive("join-lists-support.arr",
  "1OH25NKkXAwcOtXs9yGLAjZO3u65T6T0J") as J

# Imports below

# Imports above

type JoinList = J.JoinList
empty-join-list = J.empty-join-list
one = J.one
join-list = J.join-list

split = J.split
join-list-to-list = J.join-list-to-list
list-to-join-list = J.list-to-join-list
is-non-empty-jl = J.is-non-empty-jl

# DO NOT CHANGE ANYTHING ABOVE THIS LINE

##Implementation

fun j-first<A>(jl :: JoinList<A>%(is-non-empty-jl)) -> A:
  doc:"Returns the first element of a non-empty list."

  cases (JoinList) jl:
    | empty-join-list => raise(" shouldn't happen!")
    | one(elt) => elt
    | join-list(_,_,_) => 
      new-jl = split(jl,lam(l1,l2):l1 end)
      j-first(new-jl)
  end
where:

  l1 = list-to-join-list([list:1,2,3])
  l2 = list-to-join-list([list:4,5,6])
  l3 = l1.join(l2)
  l4 = list-to-join-list([list:4])
  #l5 = list-to-join-list([list:])

  j-first(l1) is 1
  j-first(l2) is 4
  j-first(l3) is 1
  j-first(l4) is 4
  #j-first(l5) is empty-join-list


end


fun j-rest<A>(jl :: JoinList<A>%(is-non-empty-jl)) -> JoinList<A>:
  doc:"Returns a join list containing all elements but the first of a non-empty list."

  cases (JoinList) jl:
    | empty-join-list => raise(" shouldn't happen!")
    | one(elt) => empty-join-list
    | join-list(_,_,_) => 

      jl-left = split(jl,lam(l1,l2):l1 end)
      jl-right = split(jl,lam(l1,l2):l2 end)

      j-rest(jl-left).join(jl-right)
  end
where:
  l1 = list-to-join-list([list:1,2,3])
  l2 = list-to-join-list([list:4,5,6])
  l3 = l1.join(l2)
  l4 = list-to-join-list([list:4])
  #l5 = list-to-join-list([list:])

  j-rest(l1) is list-to-join-list([list:2,3])
  j-rest(l2) is list-to-join-list([list:5,6])
  j-rest(l3) is list-to-join-list([list:2,3,4,5,6])
  j-rest(l4) is list-to-join-list([list:])
end

```
fun j-length<A>(jl :: JoinList<A>) -> Number:
  doc:"Returns the length of a join list."
  left = split(jl,lam(l1,l2):l1 end)
  right = split(jl,lam(l1,l2):l2 end)
  cases (JoinList) left:
    |empty-join-list => 0
    |one(_) => 1 + 
      cases (JoinList) right:
        |empty-join-list => 0
        |one(_) => 1 
        |join-list(_,_,_) => j-length(right)
      end
    |join-list(_,_,_) => j-length(left) + 
      cases (JoinList) right:
        |empty-join-list => 0
        |one(_) => 1 
        |join-list(_,_,_) => j-length(right)
      end
  end
end
```
fun j-length<A>(jl :: JoinList<A>) -> Number:
  doc:"Returns the length of a join list."
  cases (JoinList) jl:
    |empty-join-list => 0
    |one(_) => 1 
    |join-list(_,_,_) => 
      left = split(jl,lam(l1,l2):l1 end)
      right = split(jl,lam(l1,l2):l2 end)

      j-length(left) + j-length(right)
  end

where:

  j-length(list-to-join-list([list:2,3])) is 2
  j-length(list-to-join-list([list:1,2,3])) is 3
  j-length(list-to-join-list([list:3])) is 1
  j-length(list-to-join-list([list:])) is 0

end




fun j-nth<A>(jl :: JoinList<A>%(is-non-empty-jl),
    n :: Number) -> A:
  doc:"Returns the nth element(using a 0-based index) of a list containing at least n+1 elements."
  # check it's valid
  if j-length(jl) >= (n + 1):
    j-nth-helper(jl,n)
  else:
    raise("Invalid indexing!")
  end
end

fun j-nth-helper<A>(jl :: JoinList<A>%(is-non-empty-jl),
    n :: Number) -> A:
  doc: "helper for j-nth()"
  if n == 0 :
    j-first(jl)
  else:
    j-nth-helper(j-rest(jl), n - 1)
  end
end


fun j-max<A>(jl :: JoinList<A>%(is-non-empty-jl), 
    cmp :: (A, A -> Boolean)) -> A:
  doc:"Returns the 'maximum' value in a non-empty list"

  j-max-helper(jl,j-first(jl),cmp)



where:
  cmp = {(a,b):  if a > b: true  else: false end }

  j-max(list-to-join-list([list:100,-10,-200,60,9000,32]),cmp) is 9000
  j-max(list-to-join-list([list:100]),cmp) is 100
  j-max(list-to-join-list([list:-10,-200]),cmp) is -10
  j-max(list-to-join-list([list:-200,60,9000]),cmp) is 9000

end

fun j-max-helper<A>(jl :: JoinList<A>%(is-non-empty-jl), max :: A ,
    cmp :: (A, A -> Boolean)) -> A:
  doc:"Returns the 'maximum' value in a non-empty list"

  cases (JoinList) jl:
    |empty-join-list => raise("empty!!")
    |one(elt) => 
      if cmp(elt,max):
        elt
      else: max
      end
    |join-list(_,_,_) => 
      left = split(jl,lam(l1,l2):l1 end)
      right = split(jl,lam(l1,l2):l2 end)
      left-max = j-max-helper(left,max,cmp)
      right-max = j-max-helper(right,max,cmp)
      if cmp(left-max,right-max):
        left-max
      else:
        right-max
      end

  end

end



fun j-map<A,B>(map-fun :: (A -> B), jl :: JoinList<A>) -> JoinList<B>:
  doc:""
  cases (JoinList) jl: 
    | empty-join-list => empty-join-list
    | one(elt) => one(map-fun(elt))
    | join-list(_,_,_) => 
      left = split(jl,lam(l1,l2):l1 end)
      right = split(jl,lam(l1,l2):l2 end)
      j-map(map-fun,left).join(j-map(map-fun,right))
  end

where:
  f1 = {(a): a * 10}
  f2 = {(a): a * 0}
  f3 = {(a): a - 10}

  l0 = list-to-join-list([list:1])
  l1 = list-to-join-list([list:1,2,3])
  l2 = list-to-join-list([list:4,5])
  l3 = list-to-join-list([list:])

  j-map(f1 , l0) is list-to-join-list([list:10])
  j-map(f1 , l1) is list-to-join-list([list:10,20,30])
  j-map(f1 , l2) is list-to-join-list([list:40,50])
  j-map(f1 , l3) is list-to-join-list([list:])

  j-map(f2 , l0) is list-to-join-list([list:0])
  j-map(f2 , l1) is list-to-join-list([list:0,0,0])
  j-map(f2 , l2) is list-to-join-list([list:0,0])
  j-map(f2 , l3) is list-to-join-list([list:])

  j-map(f3 , l0) is list-to-join-list([list:-9])
  j-map(f3 , l1) is list-to-join-list([list:-9,-8,-7])
  j-map(f3 , l2) is list-to-join-list([list:-6,-5])
  j-map(f3 , l3) is list-to-join-list([list:])
end


fun j-filter<A>(filter-fun :: (A -> Boolean), jl :: JoinList<A>) -> JoinList<A>:
  doc:""
  cases (JoinList) jl: 
    | empty-join-list => empty-join-list
    | one(elt) => 
      if filter-fun(elt):
        one(elt)
      else:
        empty-join-list
      end
    | join-list(_,_,_) => 
      left = split(jl,lam(l1,l2):l1 end)
      right = split(jl,lam(l1,l2):l2 end)
      j-filter(filter-fun,left).join(j-filter(filter-fun,right))
  end
end



fun j-reduce<A>(reduce-func :: (A, A -> A), 
    jl :: JoinList<A>%(is-non-empty-jl)) -> A:
  doc:"Distributes an operator across a non-empty list."
  cases (JoinList) jl:
    | empty-join-list => raise("empty !")
    | one(elt) => elt
    | join-list(_,_,_) =>

      left = split(jl,lam(l1,l2):l1 end)
      right = split(jl,lam(l1,l2):l2 end)

      reduce-func(j-reduce(reduce-func,left),j-reduce(reduce-func,right))

  end
end

## doesn't behave correctly !!! but it does sort (except it somietimes drops some elemnts and sometimes duplicates some others)
fun j-sort<A>(cmp-fun :: (A, A -> Boolean), jl :: JoinList<A>) -> JoinList<A>:
  doc:""
  cases (JoinList) jl:
    | empty-join-list => empty-join-list
    | one(elt) => one(elt)
    | join-list(_,_,_) => 

      left = split(jl,lam(l1,l2):l1 end)
      right = split(jl,lam(l1,l2):l2 end)

      s-left = j-sort(cmp-fun,left)
      s-right = j-sort(cmp-fun,right)

      j-sort-helper(cmp-fun,s-left,s-right)
      #if cmp-fun(,):

      #end
  end
end

fun j-sort-helper<A>(cmp-fun :: (A, A -> Boolean), jl1 :: JoinList<A>,jl2 :: JoinList<A>) -> JoinList<A>:
  doc:""
  cases (JoinList) jl1:
    | empty-join-list => jl2
    | one(elt1) => 
      cases (JoinList) jl2:
        | empty-join-list => jl1
        | one(elt2) => 
          if cmp-fun(elt1,elt2): one(elt1).join(one(elt2))
          else:
            one(elt2).join(one(elt1))
          end
        | join-list(_,_,_) => 

          if cmp-fun(elt1 , j-first(jl2)):
            jl1.join(jl2)
          else:
            one(j-first(jl2)).join(j-sort-helper(cmp-fun,jl1,j-rest(jl2)))

          end
      end
    | join-list(_,_,_) => 
      first-sorted = j-sort-helper(cmp-fun,one(j-first(jl1)),jl2)

      j-sort-helper(cmp-fun,j-rest(jl1),first-sorted)

  end
end





jl4 = list-to-join-list([list:])
jl0 = list-to-join-list([list:1])
jl1 = list-to-join-list([list:1,2,3])
jl2 = list-to-join-list([list:4,5,6])
jl3 = jl1.join(jl2)
"JL1"
jl1
"JL2"
jl2
"JL3"
jl3
"split jl3 l1"
split(jl3,lam(l1,l2): l1 end)
"split jl3 l2"
split(jl3,lam(l1,l2): l2 end)
