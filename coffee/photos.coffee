class Photos 
  constructor: (@source) ->
  photoArray : []
  format : (data) ->
    data = data.slice(data.indexOf('{'), data.length -2 )
    results = JSON.parse(data)
    for post in results
      if post.type is "photo"
        if post.photos.length is 0
           @photoArray.push({
            small : results.posts[i]["photo-url-250"],
            big : results.posts[i]["photo-url-1280"]})
        else
          for photo in post.photos
            @photoArray.push({
              small : photo["photo-url-250"],
              big : photo["photo-url-1280"]})                      
  get : () ->
    $.ajax( "http://#{@source}/api/read/json?num=50", {
      type:"jsonp"
      crossDomain: true
      success: (data) ->
        @format(data)
      error: () ->
        console.log("error")
    })
