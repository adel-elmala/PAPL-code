
include pick
data ITunesSong:

    song(name :: String, singer :: String , year :: Number) 

end

data TLColor:
  |Red
  |Yellow
  |Green
end
s1 :: ITunesSong = song("a1","b1",1995)

lver ::  ITunesSong = song("a2","b2",1996)


so :: ITunesSong = song("a3","b3",1997)

wnkkhs :: ITunesSong = song("a4","b4",1998)
#slst = [list: s1,s2,s3,s4]

fun advice(c :: TLColor) -> String:
  cases (TLColor) c:
    | Red => "wait!"
    | Yellow => "get ready..."
    | Green => "go!"
  end
end


fun oldest-song(sl :: List<ITunesSong>) -> ITunesSong:
  cases (List) sl:
    | empty => raise("not defined for empty song lists")
    | link(f, r) =>
      cases (List) r:
        | empty => f
        | else =>
          osr = oldest-song(r)
          if osr.year < f.year:
            osr
          else:
            f
          end
      end
  end
  
end




song-set = [set: lver, so, wnkkhs]

fun an-elt(s :: Set):
  cases (Pick) s.pick():
    | pick-none => error("empty set")
    | pick-some(e, r) => e
  end
end















