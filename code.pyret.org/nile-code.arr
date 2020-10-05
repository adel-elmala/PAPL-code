provide *
provide-types *

data File:
  | file(name :: String, content :: String)
end

data Recommendation:
  | recommendation(count :: Number, names :: List<String>)
end

#--------- 1-  need to check if a string is present in a list of strings
#--------- 2-  need to get the interseciton between two lists 

fun my-member<T>(item :: T,lst :: List<T>)-> Boolean:
  cases (List) lst:
    |empty => false
    |link(f,r) =>
      if f == item:
        true
      else:
        my-member(item,r)
      end
  end
end

fun my-intersection<T>(lst1:: List<T>, lst2 :: List<T>) -> List<T>:
  cases (List) lst1:
    |empty => empty
    |link(f,r) =>
      if my-member(f,lst2):
        link(f,my-intersection(r,lst2))
      else:
        my-intersection(r,lst2)
      end
  end
end
#--------- need to parse files into a list of strings
fun parse-file(fl :: File)-> List<String>:
  str = fl.content
  str-asci = string-to-code-points(str)
  my-split-at(10,str-asci,"")
end
fun my-split-at(delim :: Number,lst :: List<Number>,acc :: String)-> List<String>:
  current = acc
  cases (List) lst:
    |empty => link(current,empty) 
    |link(f,r) => 
      if f == delim:
        link(current,my-split-at(delim,r,""))
      else:
        my-split-at(delim,r,current + string-from-code-point(f))
      end
  end
end

fun recommend(title :: String, book-records :: List<File>) -> Recommendation:
  doc: ```Takes in the title of a book and a list of files,
       and returns a recommendation of book(s) to be paired with title
       based on the files in book-records.```
  # helper-recommend(title,map(parse-file,book-records))

  recommendation(0, empty)

end

fun helper-recommend(title :: String, book-records :: List<List<String>>):

  cases (List) book-records:
    |empty => empty
    |link(f,r)=>
      if my-member(title,f) :
        link(f,helper-recommend(title,r))
      else:
        helper-recommend(title,r)
      end
  end
end

fun intersect-lists(lst :: List<List<String>>,acc :: List<String>)-> List<String>:
  cases (List) lst:
    |empty => acc
    |link(f,r)=>

      intersect-lists(r,my-intersection(f,acc))
  end
end
fun popular-pairs(records :: List<File>) -> Recommendation:
  doc: ```Takes in a list of files and returns a recommendation of
       the most popular pair(s) of books in records.```
  recommendation(0, empty)
end

check:

  r1 = file("a", "1984\nCrime and Punishment\nHeaps are Lame\nLord of the Flies")
  r2 = file("b", "1984\nHeaps are Lame\nLord of the Flies")
  r3 = file("c", "1984\nCrime and Punishment\nHeaps are Lame\nCalculus")
  r4 = file("d", "Crime and Punishment\n1984\nLord of the Flies")
  input = [list: r1,r2,r3,r4]

  recommend("1984",input) is recommendation(3,[list: "Crime and Punishment","Heaps are Lame","Lord of the Flies"])

end
