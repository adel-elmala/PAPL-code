#provide *
import lists as L
# DO NOT CHANGE ANYTHING ABOVE THIS LINE
# vector list


fun max(n1 :: Number , n2 :: Number) -> Number:
  if n1 > n2:
    n1
  else if n1 < n2:
    n2
  else:
    n1
  end
end

fun dotp(vec1 :: List<Number> , vec2 :: List<Number>) -> Number:

  cases (List) vec1:
    | empty => 0 
    | link(f,r) =>

      (f * vec2.first) + dotp(r,vec2.rest)
  end
where:
  dotp([list:1,2,5],[list:9,8,7]) is 9 + 16 + 35 
  dotp([list:1,0,2],[list:5,3,2]) is 5 + 0 + 4 

end

# create a list that contains the unique words of both docs in a ascenging order
fun create-vec(d1 :: List<String>, d2 :: List<String>) -> List<String>:
  L.distinct(d1 + d2).sort()

end

fun count(s :: String, d :: List<String>) -> Number:
  cases (List) d:
    | empty => 0
    | link(f,r) =>
      if f == s:
        1 + count(s,r)
      else:
        count(s,r)
      end
  end
end


fun my-map(vector :: List<String> , d :: List<String>) -> List<Number>:
  cases (List) vector:
    |empty => empty
    |link(f,r) =>
      link(count(f,d),my-map(r,d))
  end
end


fun overlap(doc1 :: List<String>, doc2 :: List<String>) -> Number:
  # doc: "consumes two lists representing docs and computes the overlap between them"
  dist = create-vec(doc1,doc2)
  vec1 = my-map(dist,doc1)
  vec2 = my-map(dist,doc2)
  numenator = dotp(vec1,vec2)
  denom = max(dotp(vec1,vec1),dotp(vec2,vec2))
  numenator / denom



end







overlap([list: "The", "quick", "brown", "fox", "jumps"],[list: "The", "quick", "brown", "fox", "Jumps"])







#my-map([list:'a','b','c'],[list:'a','b','s','a','b','s','a','b','s','a','b','s','a'])














#vector = create-vec([list:'a','c','s'],[list:'b','d'])
#count('s',[list: 'a','b','s','a','b','s','a','b','s','a','b','s'])