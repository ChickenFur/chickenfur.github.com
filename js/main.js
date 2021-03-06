// Generated by CoffeeScript 1.4.0
(function() {

  require(["js/blog", "js/manipulater", "js/photos", "js/projects"], function(Blog, Manipulater, Photos, Projects) {
    var PICTURES_TO_DISPLAY_ON_BUTTON, POSTS_TO_DISPLAY, addPhotoButtonListener, addProjectButtonListener, domEditor, myBlogs, myPhotos, myProjects;
    PICTURES_TO_DISPLAY_ON_BUTTON = 9;
    POSTS_TO_DISPLAY = 4;
    domEditor = new Manipulater();
    myPhotos = new Photos("wisechicken.tumblr.com", PICTURES_TO_DISPLAY_ON_BUTTON);
    myProjects = new Projects("wpdprojects.tumblr.com", PICTURES_TO_DISPLAY_ON_BUTTON);
    myBlogs = new Blog("whitepinedev.tumblr.com", POSTS_TO_DISPLAY);
    $.when(myPhotos.get()).done(function() {
      myPhotos.createButton("#photoButton");
      return myPhotos.setupGallery();
    });
    $.when(myProjects.get()).done(function() {
      myProjects.createButton('#projectsButton', addProjectButtonListener);
      return myProjects.setupGallery();
    });
    $.when(myBlogs.get()).done(function() {
      return myBlogs.createButton('#techBlogButton');
    });
    addPhotoButtonListener = function() {
      $("#photoButton").on("click", function(event) {
        console.log("Photo Clicked");
        $("#photoButton > img").addClass("gallery");
        myPhotos.gallery.display("body");
        myPhotos.gallery.hidePreviousButton();
        return myPhotos.cacheNextGallery();
      });
      return $('#photosTitle').on("click", function() {
        return $("#photoButton").click();
      });
    };
    return addProjectButtonListener = function() {
      $("#projectsButton").on("click", function(event) {
        console.log("Photo Clicked");
        $("#photoButton > img").addClass("gallery");
        myProjects.gallery.display("body");
        myProjects.gallery.hidePreviousButton();
        myProjects.gallery.hidePreviousButton();
        return myProjects.cacheNextGallery();
      });
      return $('#projectsTitle').on("click", function() {
        return $("#projectsButton").click();
      });
    };
  });

}).call(this);
