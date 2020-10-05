import lists as L
include math
fun is-palindrome(str :: String)->Boolean:

  doc: ```
       consumes a (string) and produces a (boolean) indicating whether the string with 
       all spaces and punctuation removed is a string with the same letters in each of 
       forward and reverse order (ignoring capitalization).
       ```

  original = string-to-code-points(remove-punc(str))
  reversed = L.reverse(original)
  original == reversed

where:
  is-palindrome("a man, a plan, a canal: Panama") is true
  is-palindrome("abca") is false
  is-palindrome("yes, he did it") is false
  is-palindrome("1221") is true
  is-palindrome("01001") is false  
end




fun remove-punc(str :: String)->String:
  doc: ```
       remove all punctuation and spaces from a string and returns a new string
       with all letters lowercased
       ```
  lst = string-to-code-points(str)
  down-cases = string-to-code-points("az")
  upper-cases = string-to-code-points("AZ")
  digits = string-to-code-points("09")

  allowed = range(down-cases.first,down-cases.rest.first + 1) + range(upper-cases.first,upper-cases.rest.first + 1) + range(digits.first,digits.rest.first + 1)  

  string-to-lower(string-from-code-points(filter(lam(elt): allowed.member(elt) end,lst)))
end


fun sum-largest(table :: List<List<Number>>)->Number:
  doc: ```
       produces the sum of the largest item from each list
       ```

  fold(lam(base,elt):max(elt) + base end,0,table)

where:
  sum-largest([list:[list:1,7,5,3],[list:20],[list:6,9]]) is (7 + 20 + 9)
end


fun adding-machine(lst :: List<Number>)-> List<Number>:

  doc:```
      consumes a list of numbers and produces a list of the sums of each non-empty 
      sublist separated by zeros. Ignores input elements that occur after the first 
      occurrence of two consecutive zeros

      ```

  adding-machine-helper(lst,0)

where:
  adding-machine([list: 1, 2, 0, 7, 0, 5, 4, 1, 0, 0, 6]) is [list: 3, 7, 10]
end

fun adding-machine-helper(lst :: List<Number> , acc :: Number)-> List<Number>:
  cases (List) lst:
    |empty => empty
    |link(f,r) =>
      if not(f == 0):
        adding-machine-helper(r,acc + f)
      else if  (not(r == empty)) and (f == 0) and (r.first == 0):
        link(acc,empty)
      else:
        link(acc,adding-machine-helper(r,0))
      end
  end



end



