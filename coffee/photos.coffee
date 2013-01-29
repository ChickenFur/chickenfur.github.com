class Photos 
  constructor: (@source) ->
  imgLinksRetrieved : false
  photoArray : []
  format : (data) =>
    
    for post in data.posts
      if post.type is "photo"
        if post.photos.length is 0
           @photoArray.push({
            tiny : post["photo-url-75"],
            small : post["photo-url-250"],
            big : post["photo-url-1280"]})
        else
          for photo in post.photos
            @photoArray.push({
              tiny : photo["photo-url-75"],
              small : photo["photo-url-250"],
              big : photo["photo-url-1280"]}) 
    imgLinksRetrieved = true
  get : () =>
    $.ajax( "http://#{@source}/api/read/json?num=50", {
      dataType:"jsonp"
      crossDomain: true
      success: (data) =>
        @format(data)
      error: () ->
        console.log("error")
    })
