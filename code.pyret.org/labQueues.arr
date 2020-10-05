data Queue<T>:
  |queue(enqueue-to :: List<T> , dequeue-from :: List<T>)
end

fun requeue<T>(q :: Queue<T>) -> Queue<T>:# O(n)
  if q.enqueue-to == empty:
    raise("Queue is empty")
  else:
    queue(empty,q.enqueue-to.reverse())
  end
end
#==========Enqueue==========#

fun enqueue<T>(q :: Queue<T>, elt :: T) -> Queue<T>: #O(1)
  queue(link(elt,q.enqueue-to),q.dequeue-from)
end

#==========Dequeue==========#

data Dequeued<T>:
  | none-left
  | elt-and-q(e :: T, q :: Queue<T>)
end

fun dequeue<T>(q :: Queue<T>) -> Dequeued<T>: 
  cases (List) q.dequeue-from:
    |empty => dequeue(requeue(q)) # O(n)
    |link(f,r) =>
      elt-and-q(f,queue(q.enqueue-to,r)) # O(1)

  end
end


q1 = queue([list: 9,8,7,6],[list:1,2,3,4,5])
q2 = queue([list: 9,8,7,6],empty)
q3 = queue(empty,empty)




data PriorityElement<T>:
  |plt(elt :: T,p :: Number) 

end

data PriorityQueue<T>:
    # one of many possible data definitions (more on this later)
  |pq(lst :: List<T>)
end

fun insert-with-priority<T>(elt :: T, p :: Number, pqueue :: PriorityQueue<PriorityElement>) -> PriorityQueue<PriorityElement>:
  doc: "Inserts elt into pq with priority p"
  pq(pqInsert-helper(elt,p,pqueue.lst))
end

fun pqInsert-helper<T>(elt :: T, p :: Number, pqlist :: List<PriorityElement>) -> List<PriorityElement>:
  cases (List) pqlist:
    |empty => link(plt(elt,p),empty)
    |link(f,r) => 
      if f.p > p :
        link(f,pqInsert-helper(elt,p,r))
      else:
        link(plt(elt,p),pqlist)
      end
  end
end
  
fun get-highest-priority<T>(pqueue :: PriorityQueue<T>) -> T:
  doc: "Produces the element in pq with the highest associated prioirty."
  pqueue.lst.first
end

fun remove-highest-priority<T>(pqueue :: PriorityQueue<T>) -> PriorityQueue<T>:
  doc: "Produces a Priority Queue like pq but with the element with the highest priority removed."

  pq(pqueue.lst.rest)
end

p = pq([list: plt("adel",9)])
p2 = insert-with-priority("notAdel",2,p)
p3 = insert-with-priority("moreAdel",15,p2)