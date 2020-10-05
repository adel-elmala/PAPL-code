data Element<T>:
  |elt(val :: T, ref parent :: Option<Element>)
end

#type Sets = List<Element>

fun is-in-same-set(e1 :: Element, e2 :: Element) -> Boolean:
  s1 = fynd(e1)
  s2 = fynd(e2)
  identical(s1, s2)
end

fun update-set-with(child :: Element, parent :: Element):
  child!{parent: some(parent)}
end

fun fynd(e :: Element) -> Element:
  cases (Option) e!parent block:
    | none => e
    | some(p) =>
      new-parent = fynd(p)
      e!{parent: some(new-parent)}
      new-parent
  end
end
fun union(e1 :: Element, e2 :: Element):
  s1 = fynd(e1)
  s2 = fynd(e2)
  if identical(s1, s2):
    s1
  else:
    update-set-with(s1, s2)
  end
end


s0 = map(elt(_, none), [list: 0, 1, 2, 3, 4, 5, 6, 7])
#s1 = union(s0.get( 0), s0.get(2))
#s2 = union(s0.get(0), s0.get(3))
#s3 = union(s0.get(3), s0.get(5))
