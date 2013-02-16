define ["js/gallery", "js/manipulater"], (Gallery, Manipulater) ->  
  class Photos   
    constructor: (@source, numToDisplay) ->
      @currentSetStartNum = 0
      @NUM_TO_GET = 9
      @numPicturesRetrieved=0
      @allPhotosArray = []
      @prevGalleryArray = []
      @currentGalleryArray = []
      @nextGalleryArray = []
      @url = "http://#{@source}/api/read/json?num="+@NUM_TO_GET
      @gallery = new Gallery "photoGallery"
      @galleryNext = new Gallery "photoGallery2"
      @domEditor = new Manipulater()
      @numOfPictures = numToDisplay
      @smallImgTags

    format : (data, photoArray) =>
      for post in data.posts
        if post.type is "photo"
          if post.photos.length is 0
            @allPhotosArray.push({
              tiny : post["photo-url-75"],
              small : post["photo-url-250"],
              big : post["photo-url-1280"],
              caption : post["photo-caption"]})
          else
            for photo in post.photos
              @allPhotosArray.push({
                tiny : photo["photo-url-75"],
                small : photo["photo-url-250"],
                big : photo["photo-url-1280"]}) 
      @numPicturesRetrieved = @allPhotosArray.length
    get : (startNum=0, photoArray=0, callBack) =>
      unless startNum is 0
        @url = @url + "&start=#{startNum}"
      $.ajax( @url, {
        dataType:"jsonp"
        crossDomain: true
        success: (data) =>
          @format(data)
          if callBack
            callBack()
        error: () ->
          console.log("error")
      })
    cacheNextGallery : ()=>
      if @numPicturesRetrieved < 18
        @get(@currentSetStartNum + @numOfPictures, 1, @setupImages)  
      else
        @nextGalleryArray = @allPhotosArray.slice(@numOfPictures, @numOfPictures + @numOfPictures) 
        @setupNextGalleryImages()

    setupNextGalleryImages : () =>
      smallImgTags = @domEditor.createTags(
        @nextGalleryArray.slice(0,@numOfPictures),
        "img",
        "small",
        "src")
      smallImgTags = @domEditor.wrapTags(
        smallImgTags,
        @.nextGalleryArray.slice(0, @numOfPictures),
        "a",
        "big",
        "href")
      @galleryNext.setup(smallImgTags)
      $(".forwardButton").on("click", (event) =>
        #debugger;
        @gallery.hide()
        @galleryNext.display("body")
        )

    createButton : (container, listener) =>
      tinyImgTags = @domEditor.createTags( 
        @allPhotosArray.slice(0,@numOfPictures),
        "img", 
        "tiny", 
        "src")
      @domEditor.injectInto(container, tinyImgTags)
      listener()
      smallImgTags = @domEditor.createTags( 
        @allPhotosArray.slice(0,@numOfPictures),
        "img", 
        "small", 
        "src")
      @smallImgTags = @domEditor.wrapTags(
        smallImgTags,
        @allPhotosArray.slice(0,@numOfPictures),
        "a",
        "big",
        "href")
    setupGallery : () ->
      @gallery.setup(@smallImgTags)
      @cacheNextGallery()
  return Photos