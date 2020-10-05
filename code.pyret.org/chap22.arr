data MemoryCell:
  | mem(in, out)
end

#var memory :: List<MemoryCell> = empty

fun catalan1(n):
  if n == 0: 1
  else if n > 0:
    for fold(acc from 0, k from range(0, n)):
      acc + (catalan1(k) * catalan1(n - 1 - k))
    end
  end
end

fun memoize<T,U>( f :: (T -> U) ) -> (T -> U):

  var memory :: List<MemoryCell> = empty

  lam(n):
    answer = find(lam(elt): elt.in == n end,memory)
    cases (Option) answer block:
      |some(v) => v.out 

      |none =>  
        result = f(n)
        memory := link(mem(n,result),memory)
        result
    end
  end
end

rec catalan2 = memoize(
  lam(n):
    if n == 0: 1
    else if n > 0:
      for fold(acc from 0, k from range(0, n)):
        acc + (catalan2(k) * catalan2(n - 1 - k))
      end
    end
  end

  ) 


```
fun catalan(n):
  answer = find(lam(elt): elt.in == n end,memory)
  cases (Option) answer block:
    | none =>
      result = 
        if n == 0: 1
        else if n > 0:
          for fold(acc from 0, k from range(0, n)):
            acc + (catalan(k) * catalan(n - 1 - k))
          end
        end
      memory := link(mem(n,result),memory)
      result

    | some(v) => v.out

  end
end```