class Photos   
  constructor: (@source, @startNum=0) ->
    @NUM_TO_GET = 9
    @imgLinksRetrieved = false
    @photoArray = []
    @url = "http://#{@source}/api/read/json?num="+@NUM_TO_GET+"&start=#{@startNum}"
    @.gallery = new Gallery "photoGallery"
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
    @imgLinksRetrieved = true
  get : () =>
    $.ajax( @url, {
      dataType:"jsonp"
      crossDomain: true
      success: (data) =>
        @format(data)
      error: () ->
        console.log("error")
    })
  createButton : (container, listener) =>
    tinyImgTags = domEditor.createTags( 
      @.photoArray.slice(0,PICTURES_TO_DISPLAY_ON_BUTTON),
      "img", 
      "tiny", 
      "src")
    domEditor.injectInto(container, tinyImgTags)
    listener()
    smallImgTags = domEditor.createTags( 
      @.photoArray.slice(0,PICTURES_TO_DISPLAY_ON_BUTTON),
      "img", 
      "small", 
      "src")
    smallImgTags = domEditor.wrapTags(
      smallImgTags,
      @.photoArray.slice(0,PICTURES_TO_DISPLAY_ON_BUTTON),
      "a",
      "big",
      "href")
    @.gallery.setup(smallImgTags)
