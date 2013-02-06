class Photos   
  constructor: (@source) ->
    @currentSetStartNum = 0
    @NUM_TO_GET = 9
    @imgLinksRetrieved = false
    @photoArray = []
    @nextGalleryArray = []
    @url = "http://#{@source}/api/read/json?num="+@NUM_TO_GET
    @.gallery = new Gallery "photoGallery"
    @.galleryNext = new Gallery "photoGallery2"

  format : (data, photoArray) =>
    photoArrays = [@photoArray, @nextGalleryArray]
    for post in data.posts
      if post.type is "photo"
        if post.photos.length is 0
          photoArrays[photoArray].push({
            tiny : post["photo-url-75"],
            small : post["photo-url-250"],
            big : post["photo-url-1280"]})
        else
          for photo in post.photos
            photoArrays[photoArray].push({
              tiny : photo["photo-url-75"],
              small : photo["photo-url-250"],
              big : photo["photo-url-1280"]}) 
    @imgLinksRetrieved = true
  get : (startNum=0, photoArray=0, callBack) =>
    unless startNum is 0
      @url = @url + "&start=#{startNum}"
    $.ajax( @url, {
      dataType:"jsonp"
      crossDomain: true
      success: (data) =>
        @format(data, photoArray)
        if callBack
          callBack()
      error: () ->
        console.log("error")
    })
  cacheNextGallery : ()=>
    @.get(@currentSetStartNum + PICTURES_TO_DISPLAY_ON_BUTTON, 1, () =>
      smallImgTags = domEditor.createTags(
        @.nextGalleryArray.slice(0,PICTURES_TO_DISPLAY_ON_BUTTON),
        "img",
        "small",
        "src")
      smallImgTags = domEditor.wrapTags(
        smallImgTags,
        @.nextGalleryArray.slice(0, PICTURES_TO_DISPLAY_ON_BUTTON),
        "a",
        "href")
      @.galleryNext.setup(smallImgTags)
      $(".forwardButton").on("click", (event) =>
        @.gallery.hide()
        @.galleryNext.display("body")
        )
    )
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
