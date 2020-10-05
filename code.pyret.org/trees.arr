data Person:
    person(name :: String, children:: ChildLst) 
end


data ChildLst:
  |Nochild 
  |child(p :: Person,rest :: ChildLst)
end


p1 = person("7mada",Nochild)
p2 = person("A" , child(person("B",Nochild),child(person("B",Nochild),Nochild)))  