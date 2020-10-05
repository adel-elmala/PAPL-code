data Element<T>:
  |elt(val :: T, parent :: Option<Element>)
end

type Sets = List<Element>


#s0 = map(elt(_,none),[list:1,2,3,4,5,6,7,8,9])


fun is-same-element(e1 :: Element,e2 :: Element)-> Boolean:

  identical(e1.val,e2.val)

end



fun  is-in-same-set(e1 :: Element,e2 :: Element, s :: Sets)-> Boolean: 
  s1 = fynd(e1,s)
  s2 = fynd(e2,s)
  is-same-element(s1,s2)
end


fun fynd(e :: Element , s :: Sets)-> Element:
  cases (List) s:
    | empty => raise("Empty set !")
    |link(f,r) => 
      if is-same-element(f,e) : 
        cases (Option) f.parent:
          |none => f
          |some(parent) => fynd(parent,s)
        end
      else:
        fynd(e,r)
      end
  end

end


fun union(e1 :: Element,e2 :: Element,s :: Sets)->Sets:
  s1 = fynd(e1,s)
  s2 = fynd(e2,s)

  if s1 <=> s2:
    s
  else:
    update-set-with(s, s1, s2)
  end

end


fun update-set-with(s :: Sets, child :: Element, parent :: Element)->Sets:
  cases (List) s:
    |empty => empty
    |link(f,r) =>
      if is-same-element(f,child):
        link(elt(f.val,some(parent)),r)
      else:
        link(f,update-set-with(r,child,parent))
      end
  end
end

fun index(s :: Sets, n :: Number)-> Element:
  s.get(n)
end

s0 = map(elt(_, none), [list: 0, 1, 2, 3, 4, 5, 6, 7])
s1 = union(index(s0, 0), index(s0, 2), s0)
s2 = union(index(s1, 0), index(s1, 3), s1)
s3 = union(index(s2, 3), index(s2, 5), s2)
check:

  print(s3)
  is-same-element(fynd(index(s0, 0), s3), fynd(index(s0, 5), s3)) is true
  is-same-element(fynd(index(s0, 2), s3), fynd(index(s0, 5), s3)) is true
  is-same-element(fynd(index(s0, 3), s3), fynd(index(s0, 5), s3)) is true
  is-same-element(fynd(index(s0, 5), s3), fynd(index(s0, 5), s3)) is true
  is-same-element(fynd(index(s0, 7), s3), fynd(index(s0, 7), s3)) is true
end




