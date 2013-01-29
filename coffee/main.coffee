PICTURES_TO_DISPLAY_ON_BUTTON = 9

domEditor = new Manipulater()
myPhotos = new Photos "wisechicken.tumblr.com"
$.when(myPhotos.get()).done(()->
    imgTags = domEditor.createTags( 
      myPhotos.photoArray.slice(0,PICTURES_TO_DISPLAY_ON_BUTTON),
      "img", 
      "small", 
      "src")
    domEditor.injectInto("#photoButton", imgTags)
  )


