lst = [list: 1, 2, 3 ]
h1 = lst.first
l1 = lst.rest
h2 = l1.first
l2 = l1.rest
h3 = l2.first
l3 = l2.rest

check:
  lst is link(1,(link(2,link(3,empty))))
  h1 is 1
  h2 is 2
  h3 is 3
  l1 is [list:2,3]
  l2 is [list:3]
  l3 is empty
end

fun my-len(l):
  cases (List) l:
    | empty => 0
    | link(f,r) => 1 + my-len(r) 
  end
end

fun my-sum(l):
  cases (List) l:
    | empty => 0
    | link(f,r) => f + my-sum(r) 
  end
end
fun my-str-len(l):
  cases (List) l:
    | empty => empty
    | link(f,r) => link(string-length(f) , my-str-len(r)) 
  end
end




fun my-pos-nums(l):
  cases (List) l:
    | empty => empty
    | link(f,r) => 
      if f > 0 :
        link(f,my-pos-nums(r))
      else:
        my-pos-nums(r)
      end
  end
end


fun my-num-max(x :: Number,y :: Number)->Number:
  if x > y:
    x
  else if x < y :
    y
  else:
    x
  end

end


check:
  my-num-max(-2,-1) is -1
  my-num-max(0,0) is 0
  my-num-max(0,1) is 1
  my-num-max(-66.00001,-66.00002) is -66.00001 
  my-num-max(55,62) is 62 
  my-num-max(-9,9) is 9  

end


fun my-alter(l,keep):
  cases (List) l: 
    | empty => empty
    | link(f,r) =>
      if keep:
        link(f,my-alter(r,false))
      else:
        my-alter(r,true)
      end
  end
end

fun my-alternate(l):
  my-alter(l,true)
end

fun my-mx(l,max):
  cases (List) l:
    |empty => max
    |link(f,r) => 
      if f > max:
        currentmax = f
        my-mx(r,currentmax)
      else:
        my-mx(r,max)
      end
  end
end

fun my-maximum(l):
  if l == empty:
    empty
  else:
    my-mx(l,l.first)
  end
end


fun my-member<T>(elmt :: T,l :: List<T>)->Boolean:
  cases (List) l :
    | empty => false 
    |link(f,r) => 
      if f == elmt:
        true
      else:
        my-member(elmt,r)
      end
  end
end


check:
  my-pos-nums([list: 1, -2, 3, -4]) is link(1, my-pos-nums([list: -2, 3, -4]))
  my-pos-nums([list:    -2, 3, -4]) is         my-pos-nums([list:     3, -4])
  my-pos-nums([list:        3, -4]) is link(3, my-pos-nums([list:        -4]))
  my-pos-nums([list:           -4]) is         my-pos-nums([list:          ])
  my-pos-nums([list:             ]) is         [list: ]
end














check:
  my-str-len([list: "hi", "there", "mateys"]) is link(2, [list: 5, 6])
  my-str-len([list:       "there", "mateys"]) is link(5, [list:    6])
  my-str-len([list:                "mateys"]) is link(6, [list:     ])
  my-str-len(empty) is empty
end



check:
  my-len([list: 7, 8, 9]) is 1 + my-len([list: 8, 9])
  my-len([list:    8, 9]) is 1 + my-len([list:    9])
  my-len([list:       9]) is 1 + my-len([list:     ])
  my-len([list:        ]) is 0
end

check:
  my-sum([list: 7, 8, 9]) is 7 + my-sum([list: 8, 9])
  my-sum([list:    8, 9]) is 8 + my-sum([list:    9])
  my-sum([list:       9]) is 9 + my-sum([list:     ])
  my-sum([list:]) is 0
end
