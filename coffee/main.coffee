PICTURES_TO_DISPLAY_ON_BUTTON = 9

domEditor = new Manipulater()
myPhotos = new Photos "wisechicken.tumblr.com"
photoGallery = new Gallery("photoGallery")
projectGallery = new Gallery("projectGallery")

####
#Page Loading
####
$.when(myPhotos.get()).done(()->
    imgTags = domEditor.createTags( 
      myPhotos.photoArray.slice(0,PICTURES_TO_DISPLAY_ON_BUTTON),
      "img", 
      "small", 
      "src")
    domEditor.injectInto("#photoButton", imgTags)
    addPhotoButtonListener()
    photoGallery.setup(imgTags)
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

