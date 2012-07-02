Array.prototype.unique = () ->
  a = []
  for e in @
    a.push(e) unless e in a
  return a

Array.prototype.remove = (v) =>
   $.grep @,(e)-> e!=v

#Array.prototype.contains = (item) ->
#  @.indexOf(item) != -1

Array.prototype.compact = () ->
    (item for item in @ when item isnt null)

Array.prototype.flatten = () ->
    flattened = []
    for element in @
      if element instanceof Array
        flattened = flattened.concat element.flatten()
      else
        flattened.push element
    flattened
