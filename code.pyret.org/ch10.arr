
data NumList:
  | nl-empty
  | nl-link(first :: Number, rest :: NumList)
end


nl-link(1,
  nl-link(2,
    nl-link(3,
      nl-link(4,
        nl-link(5,
          nl-link(6,
            nl-link(7,
              nl-link(8,
                nl-empty))))))))