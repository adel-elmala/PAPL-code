data Box:
  |box(ref v)
end



b0 = box("a value")
b1 = box("a value")
b2 = b1
b4 = box(b1!v)

l0 = [list: b0]
l1 = [list: b1]
l2 = [list: b2]

check:
  b0!v is b1!v
  b1!v is b2!v

  b0 is-not%(identical) b1
  b1 is%(identical) b2
  b0 is-not%(identical) b2
end


check:

  b1!v is b4!v
  b1!v is%(identical) b4!v
  b1 is-not%(identical) b4
end



hold-b1-value = b1!v


#b1!{v: "a different value"}



data Clink:
  |clink(v , ref r) 
end


white-list = clink("white","r")
grey-list = clink("grey","r")


white-list!{r: grey-list}

grey-list!{r: white-list}





table-list = white-list


fun take(n :: Number, li :: Clink) -> List:

  if n == 0 :
    empty
  else: 
    link(li!v,take(n - 1,li!r))
  end

end

fun make-counter():
  b = box(0)
  lam() block:
    b!{v : b!v + 1}
    b!v
  end
end

var x = 0



x := 5










