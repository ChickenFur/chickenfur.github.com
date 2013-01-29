myPhotos = new Photos "wisechicken.tumblr.com"
$.when(myPhotos.get()).done(()->
  console.log(myPhotos.photoArray)
  ) 
