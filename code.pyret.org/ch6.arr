include math
include statistics

song = table: title,artist,play-count
  row:'5ara','7amo',10
  row: "Blinding Lights", "The Weeknd", 5
  row: "Memories", "Maroon 5", 97
  row: "The Box", "Roddy Ricch", 25
end

people = table: name,height,age
  row:'adel',170,23
  row:'ahmed',154,21
  row:'ali',140,32
  row:'zain',130,26
end
heights = extract height from people end
select play-count from song end
play-count = extract play-count from song end
#play-count.length()
play-count

tallest = sieve people using height:
  height == max(heights)
end

max(heights)
min(heights)
mean(heights)