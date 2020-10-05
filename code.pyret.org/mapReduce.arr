# CSCI0190 (Fall 2018)

provide *

import shared-gdrive("map-reduce-support.arr",
  "1F87DfS_i8fp3XeAyclYgW3sJPIf-WRuH") as support

import lists as L

type Tv-pair = support.Tv-pair
tv = support.tv
wc-map = support.wc-map
wc-reduce = support.wc-reduce
files = [list:tv("file1.txt","my name is adel"),tv("file2.txt","adel refat is my name"),tv("file3.txt","the name of this assignment is mapReduce")]
# DO NOT CHANGE ANYTHING ABOVE THIS LINE

## A. Your map-reduce definition

fun map-reduce<A,B,M,N,O>(input :: List<Tv-pair<A,B>>,
    mapper :: (Tv-pair<A,B> -> List<Tv-pair<M,N>>),
    reducer :: (Tv-pair<M,List<N>> -> Tv-pair<M,O>)) -> List<Tv-pair<M,O>>:

  doc:""


  mapper-out = for map(tv-pair from input):
    mapper(tv-pair)
  end
  coll-map-out = collapse(mapper-out)
  grouped = group(L.distinct(coll-map-out),coll-map-out)
  
  for map(tv-pair from grouped):
    reducer(tv-pair)
  end


where:
  nothing
end

fun collapse<T>(lst :: List<List<T>>)->List<T>:
  cases (List) lst:
    |empty => empty
    |link(f,r) => 
      f + collapse(r)
  end
end

fun group(small :: List<Tv-pair>,all :: List<Tv-pair>)-> List<Tv-pair>:
  cases (List) small:
    |empty => empty
    |link(f,r) =>
      link(tv(f.tag,group-helper(f,all)),group(r,all))
  end
end

fun group-helper(elt :: Tv-pair, lst :: List<Tv-pair>):
  cases (List) lst:
    |empty => empty
    |link(f,r) =>
      if elt.tag == f.tag:
        link(f.value,group-helper(elt,r))
      else:
        group-helper(elt,r)
      end
  end

end





## B. Your anagram implementation  

fun anagram-map(input :: Tv-pair<String, String>) 
  -> List<Tv-pair<String, String>>:
  doc:""
  ...
where:
  nothing
end

fun anagram-reduce(input :: Tv-pair<String, List<String>>) 
  -> Tv-pair<String, List<String>>:
  doc:""
  ...
where:
  nothing
end


## C. Your Nile implementation

fun recommend(title :: String, 
    book-records :: List<Tv-pair<String, String>>)
  -> Tv-pair<Number, List<String>>:
  doc:""
  ...
where:
  nothing
end

fun popular-pairs(book-records :: List<Tv-pair<String, String>>) 
  -> Tv-pair<Number, List<String>>:
  doc:""
  ...
where:
  nothing
end


