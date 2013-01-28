// Generated by CoffeeScript 1.4.0
(function() {
  var Photos, myPhotos;

  Photos = (function() {

    function Photos(source) {
      this.source = source;
    }

    Photos.prototype.photoArray = [];

    Photos.prototype.format = function(data) {
      var photo, post, results, _i, _len, _results;
      data = data.slice(data.indexOf('{'), data.length(-2));
      results = JSON.parse(data);
      _results = [];
      for (_i = 0, _len = results.length; _i < _len; _i++) {
        post = results[_i];
        if (post.type === "photo") {
          if (post.photos.length === 0) {
            _results.push(this.photoArray.push({
              small: results.posts[i]["photo-url-250"],
              big: results.posts[i]["photo-url-1280"]
            }));
          } else {
            _results.push((function() {
              var _j, _len1, _ref, _results1;
              _ref = post.photos;
              _results1 = [];
              for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
                photo = _ref[_j];
                _results1.push(this.photoArray.push({
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

    Photos.prototype.get = function() {
      return $.ajax("http://" + this.source + "/api/read/json?num=50", {
        type: "jsonp",
        crossDomain: true,
        success: function(data) {
          return this.format(data);
        },
        error: function() {
          return console.log("error");
        }
      });
    };

    return Photos;

  })();

  myPhotos = new Photos("wisechicken.tumblr.com");

  myPhotos.get();

}).call(this);