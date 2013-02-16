define ["js/photos"], (Photos) ->
  class Projects extends Photos
    setupGallery: () ->
      @addTitle()
      @gallery.setup(@smallImgTags)
    addTitle : () ->
      images = @smallImgTags.split('</a>')
      images.pop()
      for data,  index in @allPhotosArray
        images[index] = "<div> " + images[index] +
                        "</a> #{@allPhotosArray[index].caption}</div>"
      @smallImgTags = images.join('')
  return Projects
