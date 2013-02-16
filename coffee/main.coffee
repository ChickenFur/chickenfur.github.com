require ["js/blog", "js/manipulater", "js/photos", "js/projects"] , (Blog, Manipulater, Photos, Projects) -> 
  PICTURES_TO_DISPLAY_ON_BUTTON = 9
  POSTS_TO_DISPLAY = 4
  domEditor = new Manipulater()
  myPhotos = new Photos "wisechicken.tumblr.com", PICTURES_TO_DISPLAY_ON_BUTTON
  myProjects = new Projects "wpdprojects.tumblr.com", PICTURES_TO_DISPLAY_ON_BUTTON
  myBlogs =  new Blog "whitepinedev.tumblr.com", POSTS_TO_DISPLAY

  ####
  #Page Loading
  ####
  $.when(myPhotos.get()).done(()->
      myPhotos.createButton("#photoButton", addPhotoButtonListener)
      myPhotos.setupGallery()
    )

  $.when(myProjects.get()).done(()->
      myProjects.createButton('#projectsButton', addProjectButtonListener )
      myProjects.setupGallery()
    )
  $.when(myBlogs.get()).done( ()->
      myBlogs.createButton('#techBlogButton')
    )

  ######
  #Listeners
  ######
  addPhotoButtonListener = () ->
     $("#photoButton").on("click", (event)->
      console.log "Photo Clicked"
      $("#photoButton > img").addClass("gallery")
      myPhotos.gallery.display("body")
      myPhotos.gallery.hidePreviousButton();
      myPhotos.cacheNextGallery()
      )

  addProjectButtonListener = () ->
     $("#projectsButton").on("click", (event)->
      console.log "Photo Clicked"
      $("#photoButton > img").addClass("gallery")
      myProjects.gallery.display("body")
      myProjects.gallery.hidePreviousButton();
      myProjects.gallery.hidePreviousButton();
      myProjects.cacheNextGallery()
      )


