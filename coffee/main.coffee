require ["js/blog", "js/manipulater", "js/photos", "js/projects"] , (Blog, Manipulater, Photos, Projects) -> 
  PICTURES_TO_DISPLAY_ON_BUTTON = 9
  domEditor = new Manipulater()
  myPhotos = new Photos "wisechicken.tumblr.com", PICTURES_TO_DISPLAY_ON_BUTTON
  myProjects = new Projects "wpdprojects.tumblr.com", PICTURES_TO_DISPLAY_ON_BUTTON
  myBlogs = Blog #"whitepinedev.tumblr.com"

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

  ######
  #Listeners
  ######
  addPhotoButtonListener = () ->
     $("#photoButton").on("click", (event)->
      console.log "Photo Clicked"
      $("#photoButton > img").addClass("gallery")
      myPhotos.gallery.display("body")
      myPhotos.cacheNextGallery()
      )

  addProjectButtonListener = () ->
     $("#projectsButton").on("click", (event)->
      console.log "Photo Clicked"
      $("#photoButton > img").addClass("gallery")
      myProjects.gallery.display("body")
      myProjects.cacheNextGallery()
      )


