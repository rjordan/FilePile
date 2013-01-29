Array::unique = () ->
  a = []
  for e in @
    a.push(e) unless e in a
  a

Array::remove = (v) ->
  $.grep @,(e)->e!=v

#Array::contains = (item) ->
#  @.indexOf(item) != -1

Array::compact = () ->
    (item for item in @ when item isnt null)

Array::flatten = () ->
    flattened = []
    for element in @
      if element instanceof Array
        flattened = flattened.concat element.flatten()
      else
        flattened.push element
    flattened
