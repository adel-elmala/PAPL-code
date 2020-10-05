include image

fun moon-weight(earth-weight :: Number) -> Number:
  earth-weight * 1/6
where:
  moon-weight(100) is 100 * 1/6
  moon-weight(150) is 150 * 1/6
  moon-weight(90) is 90 * 1/6


end

fun japan-flag(unit :: Number) -> Image:
  bg-width :: Number = unit * 3
  bg-height :: Number = unit * 2
  circ-rad :: Number = 3/5 * 1/2 * bg-height
  red-circ :: Image = circle(circ-rad, "solid", "red")
  white-rect :: Image = rectangle(bg-width, bg-height, "solid", "white")
  overlay(red-circ, white-rect)
end



fun hours-to-wages-at-rate(rate :: Number , hours :: Number) -> Number:
  doc: "Compute total wage from hours, accounting for overtime, at the given rate"
  if hours <= 40:
    hours * rate

  else:
    (40 * rate) + ((hours - 40) * (1.5 * rate))
  end
where:
  hours-to-wages-at-rate(10 ,40) is 40 * 10 
  hours-to-wages-at-rate(10 ,0) is 0 * 10 
  hours-to-wages-at-rate(10 ,44) is (40 * 10) + (4 * 1.5 * 10)  
end


fun has-overtime(hours :: Number) -> Boolean:
  doc: "checks if the provided hours has over time or not"
  if hours < 0:
    raise("Negative")
  else if hours > 40:
    true
  else:
    false
  end

where:
  has-overtime(40) is false
  has-overtime(41) is true
  has-overtime(0) is false
  has-overtime(-1) raises "Negative"

end




