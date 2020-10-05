import image as I
import reactors as R

airplane-url = "http://world.cs.brown.edu/1/clipart/airplane-small.png"


AIRPLANE =  I.image-url(airplane-url)

AIRPLANE-X-MOVE = 5
AIRPLANE-Y-MOVE = 3
KEY-DISTANCE = 10


data Posn:
  | posn(x, y)
end



WIDTH = 800
HEIGHT = 500

BASE-HEIGHT = 50
WATER-WIDTH = 500

BLANK-SCENE = I.empty-scene(WIDTH, HEIGHT)
WATER = I.rectangle(WATER-WIDTH, BASE-HEIGHT, "solid", "blue")
LAND = I.rectangle(WIDTH - WATER-WIDTH, BASE-HEIGHT, "solid", "brown")

BASE = I.beside(WATER, LAND)

BACKGROUND =
  I.place-image(BASE,
    WIDTH / 2, HEIGHT - (BASE-HEIGHT / 2),
    BLANK-SCENE)


fun move-airplane-x-on-tick(w):
  num-modulo(w + AIRPLANE-X-MOVE, WIDTH)
end

fun move-airplane-wrapping-x-on-tick(w):
  
  move-airplane-x-on-tick(w)
  
end
fun move-airplane-y-on-tick(w):
  w + AIRPLANE-Y-MOVE
end






fun move-airplane-xy-on-tick(w):
  posn(move-airplane-wrapping-x-on-tick(w.x),
    move-airplane-y-on-tick(w.y))
end




fun alter-airplane-y-on-key(w, key):
  ask:
    | key == "up"   then: posn(w.x, w.y - KEY-DISTANCE)
    | key == "down" then: posn(w.x, w.y + KEY-DISTANCE)
    | otherwise: w
  end
end
















fun place-airplane-xy(w):
  I.place-image(AIRPLANE,
    w.x,
    w.y,
    BACKGROUND)
end

anim = reactor:
  init: posn(50,17.5),
  on-tick: move-airplane-xy-on-tick,
  on-key:alter-airplane-y-on-key,
  to-draw: place-airplane-xy
end


play = {():R.interact(anim)}















