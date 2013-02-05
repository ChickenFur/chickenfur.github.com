class Manipulater
  createTags :  (anArray, tagType, key, attr) ->
    results = ""
    for n in anArray
      results+= "<#{tagType} #{attr}=#{n[key]} >"
    results
  wrapTags : (tagsToWrap, keyDataArray, tagType, key, attr) ->
    results = ""
    tagsArray = tagsToWrap.split(">")
    tagsArray.pop()
    for n, index in tagsArray
      results+= "<#{tagType} #{attr}='#{keyDataArray[index][key]}'> #{n}> </#{tagType}>"
    results
  injectInto  : (parentDiv, elements) ->
    $("#{parentDiv}").append(elements)

