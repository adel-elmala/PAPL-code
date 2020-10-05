data Box:
  | box(ref v)
end
b0 = box("a value")

b1 = box("a value")

b2 = b1

b4 = box(b1!v)


check:
  b1!v is b4!v
  b1!v is%(identical) b4!v
  b1 is-not%(identical) b4
end




fun make-counter():
  ctr = box(0)
  lam() block:
    ctr!{v : (ctr!v + 1)}
    ctr!v
  end
end

l1 = make-counter()
