data Box:
  |box(ref v)
end


b0 = box(0)
b1 = box(1)
b2 = b1


check:
  b1 <=> b2
  #b1!v is 1
end

#b1!{v: 5}
