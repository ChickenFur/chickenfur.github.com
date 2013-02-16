define ["js/gallery", "js/manipulater"], (Gallery, Manipulater) ->  
  class Photos   
    constructor: (@source, numToDisplay) ->
      @currentGalleryNumber = 1
      @NUM_TO_GET = 50
      @currentNumberPostsDownloaded = @NUM_TO_GET
      @numPicturesRetrieved=0
      @allPhotosArray = []
      @prevGalleryArray = []
      @currentGalleryArray = []
      @nextGalleryArray = []
      @url = "http://#{@source}/api/read/json?num="+@NUM_TO_GET
      @gallery = new Gallery "photoGallery"
      @galleryNext = new Gallery "photoGallery2"
      @galleryPrevious = new Gallery "photoGallery0"
      @domEditor = new Manipulater()
      @numOfPictures = numToDisplay
      @smallImgTags

    format : (data ) =>
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
    get : (startNum=0, callBack) =>
      unless startNum is 0
        console.log "startNum", startNum
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

    cachePreviousGallery : () =>
      @prevGalleryArray = @allPhotosArray.slic(@numOfPictures * (@currentGalleryNumber-1 ),
                                               @currentGalleryNumber * @numOfPictures)
      @setupPrevGalleryImages()
    cacheNextGallery : ()=>
      @nextGalleryArray = @allPhotosArray.slice(@numOfPictures * @currentGalleryNumber,
          @currentGalleryNumber * @numOfPictures + @numOfPictures) 
      @setupNextGalleryImages()         
      @currentGalleryNumber += 1

    setupPrevGalleryImages : () =>
      smallImgTags = @domEditor.createTags(
        @prevGalleryArray.slice(0,@numOfPictures),
        "img",
        "small",
        "src")
      smallImgTags = @domEditor.wrapTags(
        smallImgTags,
        @.prevGalleryArray.slice(0, @numOfPictures),
        "a",
        "big",
        "href")
      @galleryPrevious.setup(smallImgTags)
      $(".forwardButton").on "click", (event) =>
        @switchToNextGallery()
      $(".backButton").on "click", () =>
        @switchToPreviousGallery()


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
      $(".forwardButton").on "click", (event) =>
        @switchToNextGallery()
      $(".backButton").on "click", () =>
        @switchToPreviousGallery()

    switchToPreviousGallery : () =>
      @gallery.hide()
      @galleryNext.setElement @gallery.getElement()
      @gallery.setElement @galleryPrevious.getElement()
      @gallery.display("body")
      @currentGalleryNumber -= 1
      if @currentGalleryNumber > 1
        @cachePreviousGallery()
      

    switchToNextGallery : () =>
      @gallery.hide()
      @galleryPrevious.setElement( @gallery.getElement() )
      @gallery.setElement( @galleryNext.getElement() )   
      @gallery.display("body")
      @gallery.showPreviousButton();
      if @allPhotosArray[ (@currentGalleryNumber)  * @numOfPictures]
        @cacheNextGallery()
      else
        @gallery.hideNextButton();

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