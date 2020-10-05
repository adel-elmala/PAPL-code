data Queue<T>:
  |queue(head:: List<T> , tail :: List<T>)
end
mt-q = queue(empty,empty)
fun enqueue<T>(q :: Queue,elt :: T)-> Queue<T>:
  
  queue(q.head,link(elt,q.tail))
  
end



data Response<T>:
  |response(e :: T , q :: Queue )
end


fun dequeue(q :: Queue) -> Response:
  cases (List) q.head:
    | empty =>
      new-head = q.tail.reverse()
      response(new-head.first,queue(new-head.rest,empty))
      
      
    |link(f,r) =>
      response(f,queue(r,q.tail))
  end
end