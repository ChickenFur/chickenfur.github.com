define ["js/photos"], (Photos) ->
  class Blog extends Photos
    format : (data) =>
      for post in data.posts
        if post.type is "regular"
          @allPhotosArray.push({
            title : post["regular-title"],
            date : post.date,
            link : post.url})     

    createButton : (container) =>
      postTags = @domEditor.createBlogPosts(
        @allPhotosArray.slice(0, @numOfPictures),
        "div",
        "title",
        "date",
        "link")
      @domEditor.injectInto(container, postTags)

  return Blog