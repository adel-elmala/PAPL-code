provide *
provide-types *

# Imports below

import lists as L

# Imports above

data Person:
  | person(name :: String, age :: Number)
end

# DO NOT CHANGE ANYTHING ABOVE THIS LINE

fun generate-input(n :: Number) -> List<Person>:
  doc:``` 
      generate a list of persons randomly on lenght 'n'

      ```
  if n < 0 :
    raise("Number: Can't be a negative number")

  else if n > 0 :
    link(person(string-from-code-points([list:num-random(26) + 65,num-random(26) + 65,num-random(26) + 65]),num-random(80)),generate-input(n - 1))
  else:
    empty
  end
end


fun is-valid(original :: List<Person>, sorted :: List<Person>) -> Boolean: 

  doc:```
      checks whether the second list is the sorted version of the first
      ```

  if same-unordered(original,sorted):
    if my-sorted(sorted):true
    else: false
    end
  else:
    false
  end

end
fun my-sorted(lst :: List<Person>)->Boolean:
  cases (List) lst:
    |empty => true
    |link(f,r)=>
      if r == empty:
        true
      else if f.age <= r.first.age:
        my-sorted(r)
      else:
        false
      end
  end
end
fun same-unordered<T>(lst1 :: List<T>,lst2 :: List<T>)->Boolean:
  doc:```
      checks if two lists have the same elements and same length but not essentially 
      the same order

      ```
  if my-len(lst1) == my-len(lst2):
    if my-intersection(lst1,lst2) == lst1:
      true
    else:
      false
    end

  else:
    false
  end


end

fun my-member<T>(item :: T,lst :: List<T>)-> Boolean:
  doc:```
      consumes an item and a list and produces a boolean to indicate if this item is 
      found in the list or not

      ```
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

fun my-len<T>(lst:: List<T>)->Number:
  doc:```
      returns the length of a list
      ```
  fold(lam(base , elt): base + 1 end,0,lst)
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



fun oracle(sorter :: (List<Person> -> List<Person>)) -> Boolean:

  doc:``` 
      An oracle for sorting functions ,that test whether that function produce the 
      correct output or not.

      ```
  

    in1 = generate-input(5)
    in2 = generate-input(0)
    in3 = generate-input(4)
    in4 = generate-input(8)
  
  if
    ((is-valid(in1,sorter(in1)) == true) and
      (is-valid(in2,sorter(in2)) == true) and
        (is-valid(in3,sorter(in3)) == true) and
          (is-valid(in4,sorter(in4)) == true) and
            (is-valid(in1,sorter(in4)) == false) and
              (is-valid(in4,sorter(in3)) == false))  :
    true
  else: false




  end
end





fun correct-sorter(people :: List<Person>) -> List<Person>:

  doc: ```Consumes a list of people and produces a list of people

       that are sorted by age in ascending order.```



  L.sort-by(people,

    lam(p1, p2): p1.age < p2.age end,

    lam(p1, p2): p1.age == p2.age end)

where:

  mlitt2   = person("Michael", 18)

  msantoma = person("Mia", 65)

  zwegweis = person("Zak", 32)



  correct-sorter(empty) is empty

  correct-sorter([list: msantoma]) is [list: msantoma]

  correct-sorter([list: msantoma, mlitt2]) is [list: mlitt2, msantoma]

  correct-sorter([list: mlitt2, msantoma]) is [list: mlitt2, msantoma]

  correct-sorter([list: mlitt2, msantoma, zwegweis])

    is [list: mlitt2, zwegweis, msantoma]

end





oracle(correct-sorter)








