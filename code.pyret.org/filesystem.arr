# CSCI0190 (Fall 2018)
provide *
provide-types *
# Imports below

# Imports above
import shared-gdrive("filesystem-types.arr", 
  "1C9WPivMElRfYhBzPibLMtDkXeME8N5rI") as F
type Dir = F.Dir
type File = F.File
type Path = List<String>
dir = F.dir
file = F.file

# DO NOT CHANGE ANYTHING ABOVE THIS LINE

# Implementation:
#data File:

#  | file(name :: String, size :: Number, content :: String) 
#   end
#data Dir:

# | dir(name :: String, ds :: List<Dir>, fs :: List<File>)

#end


filesystem = (dir("TS", [list:
        dir("Text", empty, [list: file("part1", 99, "content"), file("part2", 52, "content"), file("part3", 17, "content")]),   
        dir("Libs", [list: 
            dir("Code", empty, [list: file("hang", 8, "content"), file("draw", 2, "content")]), 
            dir("Docs", empty, [list: file("read!", 19, "content")])], empty)],
      [list: file("read!", 10, "content")]))

#==========Exercise 1==========#
fun how-many(a-dir :: Dir) -> Number:
  doc: " consumes a Dir and produces the number of files in the directory tree."
  cases (Dir) a-dir:
    
    |dir(n,ds,fs)=> fs.length() + ds.foldl(how-many,0)
  end      
where:
  nothing
end
#==========Exercise 1 - Helpers ==========#
fun dir-lst(dl :: List)-> Number:
  cases (List) dl:
    |empty => 0
    |link(f,r)=> how-many(f) 
      
  end
  
end



fun is-file<T>(obj :: T)-> Boolean:

  F.is-file(obj)

end
#==========Exercise 2==========#
fun du-dir(a-dir :: Dir) -> Number:
  doc: ""
  ...
where:
  nothing
end

#==========Exercise 3==========#
fun can-find(a-dir :: Dir, fname :: String) -> Boolean:
  doc: ""
  ...
where:
  nothing
end

#==========Exercise 4==========#
fun fynd(a-dir :: Dir, fname :: String) -> List<Path>:
  doc: ""
  ...
where:
  nothing
end
