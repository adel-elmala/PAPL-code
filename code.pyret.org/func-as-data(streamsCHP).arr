epsilon = 0.0001
fun d-dx(f :: (Number -> Number)) -> (Number -> Number):
  {(x :: Number) -> Number: (f(x + epsilon) - f(x)) /  epsilon}

end




check:

  d-dx({(x) : x * x })(5) is%(within(0.0001)) 10

end

data Stream<T>:
  | lzlink( h :: T , r :: ( -> Stream<T>))  
end

rec ones = lzlink(1,{():ones})


fun nats(n):
  
  lzlink(n,{():nats(n + 1)})
end


fun lz-first<T>(s :: Stream<T>) -> T:
  s.h
end


fun lz-rest<T>(s :: Stream<T>) -> Stream<T>:
  s.r()
end



fun take<T>(s :: Stream<T> , n :: Number) -> List<T>:
  if n > 0:
    
    link(lz-first(s), take(lz-rest(s),n - 1))
  else:
    empty
  end
  
end

fun lz-map2<A,B,C>(f :: (A , B -> C), s1 :: Stream<A>, s2 :: Stream<B>) -> Stream<C>:
  
  lzlink(
    f(lz-first(s1),lz-first(s2))
    
    ,
    {(): lz-map2(f, lz-rest(s1), lz-rest(s2))}
    )
  
end







