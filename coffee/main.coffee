PICTURES_TO_DISPLAY_ON_BUTTON = 9

domEditor = new Manipulater()
myPhotos = new Photos "wisechicken.tumblr.com"
myProjects = new Photos "wpdprojects.tumblr.com"

####
#Page Loading
####
$.when(myPhotos.get()).done(()->
    myPhotos.createButton("#photoButton", addPhotoButtonListener)
  )

$.when(myProjects.get()).done(()->
    myProjects.createButton('#projectsButton', addProjectButtonListener )
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


