class Manipulater
  createTags :  (anArray, tagType, key, attr) ->
    results = ""
    for n in anArray
      results+= "<#{tagType} #{attr}=#{n[key]} >"
    results
  injectInto  : (parentDiv, elements) ->
    $("#{parentDiv}").append(elements)