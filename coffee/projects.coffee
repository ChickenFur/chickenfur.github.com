define ["js/photos"], (Photos) ->
  class Projects extends Photos

    setupGallery: () ->
      @addTitle()
      @gallery.setup(@smallImgTags)
    addTitle : () ->
      images = @smallImgTags.split('</a>')
      images.pop()
      for data,  index in @currentGalleryArray
        images[index] = "<div> " + images[index] +
                        "</a> #{@currentGalleryArray[index].caption}</div>"
      newImages = images.join()  
      noCommas = newImages.replace(",", "")
      @smallImgTags = noCommas

  return Projects
