// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(["js/gallery", "js/manipulater"], function(Gallery, Manipulater) {
    var Photos;
    Photos = (function() {

      function Photos(source, numToDisplay) {
        this.source = source;
        this.createButton = __bind(this.createButton, this);

        this.switchToNextGallery = __bind(this.switchToNextGallery, this);

        this.switchToPreviousGallery = __bind(this.switchToPreviousGallery, this);

        this.setupNextGalleryImages = __bind(this.setupNextGalleryImages, this);

        this.setupPrevGalleryImages = __bind(this.setupPrevGalleryImages, this);

        this.cacheNextGallery = __bind(this.cacheNextGallery, this);

        this.cachePreviousGallery = __bind(this.cachePreviousGallery, this);

        this.get = __bind(this.get, this);

        this.format = __bind(this.format, this);

        this.currentGalleryNumber = 1;
        this.NUM_TO_GET = 50;
        this.currentNumberPostsDownloaded = this.NUM_TO_GET;
        this.numPicturesRetrieved = 0;
        this.allPhotosArray = [];
        this.prevGalleryArray = [];
        this.currentGalleryArray = [];
        this.nextGalleryArray = [];
        this.url = ("http://" + this.source + "/api/read/json?num=") + this.NUM_TO_GET;
        this.gallery = new Gallery("photoGallery");
        this.galleryNext = new Gallery("photoGallery2");
        this.galleryPrevious = new Gallery("photoGallery0");
        this.domEditor = new Manipulater();
        this.numOfPictures = numToDisplay;
        this.smallImgTags;
      }

      Photos.prototype.format = function(data) {
        var photo, post, _i, _len, _ref, _results;
        _ref = data.posts;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          post = _ref[_i];
          if (post.type === "photo") {
            if (post.photos.length === 0) {
              _results.push(this.allPhotosArray.push({
                tiny: post["photo-url-75"],
                small: post["photo-url-250"],
                big: post["photo-url-1280"],
                caption: post["photo-caption"]
              }));
            } else {
              _results.push((function() {
                var _j, _len1, _ref1, _results1;
                _ref1 = post.photos;
                _results1 = [];
                for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
                  photo = _ref1[_j];
                  _results1.push(this.allPhotosArray.push({
                    tiny: photo["photo-url-75"],
                    small: photo["photo-url-250"],
                    big: photo["photo-url-1280"]
                  }));
                }
                return _results1;
              }).call(this));
            }
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      };

      Photos.prototype.get = function(startNum, callBack) {
        var _this = this;
        if (startNum == null) {
          startNum = 0;
        }
        if (startNum !== 0) {
          console.log("startNum", startNum);
          this.url = this.url + ("&start=" + startNum);
        }
        return $.ajax(this.url, {
          dataType: "jsonp",
          crossDomain: true,
          success: function(data) {
            _this.format(data);
            if (callBack) {
              return callBack();
            }
          },
          error: function() {
            return console.log("error");
          }
        });
      };

      Photos.prototype.cachePreviousGallery = function() {
        this.prevGalleryArray = this.allPhotosArray.slic(this.numOfPictures * (this.currentGalleryNumber - 1), this.currentGalleryNumber * this.numOfPictures);
        return this.setupPrevGalleryImages();
      };

      Photos.prototype.cacheNextGallery = function() {
        this.nextGalleryArray = this.allPhotosArray.slice(this.numOfPictures * this.currentGalleryNumber, this.currentGalleryNumber * this.numOfPictures + this.numOfPictures);
        this.setupNextGalleryImages();
        return this.currentGalleryNumber += 1;
      };

      Photos.prototype.setupPrevGalleryImages = function() {
        var smallImgTags,
          _this = this;
        smallImgTags = this.domEditor.createTags(this.prevGalleryArray.slice(0, this.numOfPictures), "img", "small", "src");
        smallImgTags = this.domEditor.wrapTags(smallImgTags, this.prevGalleryArray.slice(0, this.numOfPictures), "a", "big", "href");
        this.galleryPrevious.setup(smallImgTags);
        $(".forwardButton").on("click", function(event) {
          return _this.switchToNextGallery();
        });
        return $(".backButton").on("click", function() {
          return _this.switchToPreviousGallery();
        });
      };

      Photos.prototype.setupNextGalleryImages = function() {
        var smallImgTags,
          _this = this;
        smallImgTags = this.domEditor.createTags(this.nextGalleryArray.slice(0, this.numOfPictures), "img", "small", "src");
        smallImgTags = this.domEditor.wrapTags(smallImgTags, this.nextGalleryArray.slice(0, this.numOfPictures), "a", "big", "href");
        this.galleryNext.setup(smallImgTags);
        $(".forwardButton").on("click", function(event) {
          return _this.switchToNextGallery();
        });
        return $(".backButton").on("click", function() {
          return _this.switchToPreviousGallery();
        });
      };

      Photos.prototype.switchToPreviousGallery = function() {
        this.gallery.hide();
        this.galleryNext.setElement(this.gallery.getElement());
        this.gallery.setElement(this.galleryPrevious.getElement());
        this.gallery.display("body");
        this.currentGalleryNumber -= 1;
        if (this.currentGalleryNumber > 1) {
          return this.cachePreviousGallery();
        }
      };

      Photos.prototype.switchToNextGallery = function() {
        this.gallery.hide();
        this.galleryPrevious.setElement(this.gallery.getElement());
        this.gallery.setElement(this.galleryNext.getElement());
        this.gallery.display("body");
        this.gallery.showPreviousButton();
        if (this.allPhotosArray[this.currentGalleryNumber * this.numOfPictures]) {
          return this.cacheNextGallery();
        } else {
          return this.gallery.hideNextButton();
        }
      };

      Photos.prototype.createButton = function(container, listener) {
        var smallImgTags, tinyImgTags;
        tinyImgTags = this.domEditor.createTags(this.allPhotosArray.slice(0, this.numOfPictures), "img", "tiny", "src");
        this.domEditor.injectInto(container, tinyImgTags);
        listener();
        smallImgTags = this.domEditor.createTags(this.allPhotosArray.slice(0, this.numOfPictures), "img", "small", "src");
        return this.smallImgTags = this.domEditor.wrapTags(smallImgTags, this.allPhotosArray.slice(0, this.numOfPictures), "a", "big", "href");
      };

      Photos.prototype.setupGallery = function() {
        this.gallery.setup(this.smallImgTags);
        return this.cacheNextGallery();
      };

      return Photos;

    })();
    return Photos;
  });

}).call(this);
