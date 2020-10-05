# CSCI0190 (Fall 2018)
provide *
provide-types *

include shared-gdrive('fluid-images-support.arr',
  '1IC9myiEkWveuFcpaHAEi0xZany7qFlDZ')

# DO NOT CHANGE ANYTHING ABOVE THIS LINE


# An example image. Feel free to remove this import.
#import broadway-tower from gdrive-js("","1V17RJyCCyQENhyNVA2m0zCeI7B7eAzgM")
#pyret1 = image-url("https://www.pyret.org/img/pyret-banner.png")

#Your liquify implementations go here.

## 1 - find all seams
## 2 - evaluate sum-energy of each seam
## 3- delete lowest energy seam 
## 4- repeat till have reached the disired width
data Coordinate:
  |crd(x :: Number,y :: Number) 
end

fun find-seams(width :: Number , height :: Number) -> List<List<Coordinate>>:

  ```
  fun find-seams-helper(current:: Coordinate , end-height :: Number,acc :: List<List<Coordinate>>) -> List<List<Coordinate>>:

    if current.y == end-height:
      empty
    else:
      center = link(current , find-seams-helper(crd(current.x ,current.y + 1 ),end-height,acc))
      
      block: 
        if current.x == 0:
          # right 
          right = link(current , find-seams-helper(crd(current.x + 1 ,current.y + 1 ),end-height,link(center,acc) ))
          link(right,[list: center])
        else if current.x == (width - 1):
          # left 
          left = link(current , find-seams-helper(crd(current.x - 1,current.y + 1 ),end-height ,link(center,acc)))
          link(left, [list: center])

        else:
          # left 
          left =  link(current , find-seams-helper(crd(current.x - 1,current.y + 1 ),end-height ,link(center,acc)))
          # right  
          right = link(current , find-seams-helper(crd(current.x + 1 ,current.y + 1 ),end-height,link(left,center)))  
          link(right,[list: link(center,[list: left])])
        end
        


      end
    end
  end
  ```
  #find-seams-helper(crd(0,0),height,empty)
end
fun find-seams-helper(original :: List<Coordinate> ,dont-slide :: List<Number>, end-height :: Number) -> List<List<Coordinate>>:
  if 
end





fun liquify-memoization(input :: Image, n :: Number) -> Image:
  doc: ``` Consumes an image and a number of times to perform the 
       operation. Returns a reduced image object.```
  ...
end

fun liquify-dynamic-programming(input :: Image, n :: Number) -> Image:
  doc: ``` Consumes an image and a number of times to perform the 
       operation. Returns a reduced image object.```
  ...
end