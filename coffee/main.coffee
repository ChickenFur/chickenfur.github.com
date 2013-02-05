PICTURES_TO_DISPLAY_ON_BUTTON = 9

domEditor = new Manipulater()
myPhotos = new Photos "wisechicken.tumblr.com"
myProjects = new Photos "wpdprojects.tumblr.com"
photoGallery = new Gallery "photoGallery"
projectGallery = new Gallery "projectGallery"

####
#Page Loading
####
$.when(myPhotos.get()).done(()->
    tinyImgTags = domEditor.createTags( 
      myPhotos.photoArray.slice(0,PICTURES_TO_DISPLAY_ON_BUTTON),
      "img", 
      "tiny", 
      "src")
    domEditor.injectInto("#photoButton", tinyImgTags)
    addPhotoButtonListener()
    smallImgTags = domEditor.createTags( 
      myPhotos.photoArray.slice(0,PICTURES_TO_DISPLAY_ON_BUTTON),
      "img", 
      "small", 
      "src")
    photoGallery.setup(smallImgTags)
  )

$.when(myProjects.get()).done(()->
    tinyImgTags = domEditor.createTags( 
      myProjects.photoArray.slice(0,PICTURES_TO_DISPLAY_ON_BUTTON),
      "img", 
      "tiny", 
      "src")
    domEditor.injectInto("#projectsButton", tinyImgTags)
    addProjectButtonListener()
    smallImgTags = domEditor.createTags( 
      myProjects.photoArray.slice(0,PICTURES_TO_DISPLAY_ON_BUTTON),
      "img", 
      "small", 
      "src")
    projectGallery.setup(smallImgTags)
  )
######
#Listeners
######
addPhotoButtonListener = () ->
   $("#photoButton").on("click", (event)->
    console.log "Photo Clicked"
    $("#photoButton > img").addClass("gallery")
    photoGallery.display("body")
    )
addProjectButtonListener = () ->
   $("#projectsButton").on("click", (event)->
    console.log "Photo Clicked"
    $("#photoButton > img").addClass("gallery")
    projectGallery.display("body")
    )

