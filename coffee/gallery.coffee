define () ->
  class Gallery
    constructor : (@name) ->
      @element = null
      @navBar = "<span class='navHeader'><span class='backButton'><img src='./imgs/back.png'></span> \
                <span class='forwardButton'><img src='./imgs/forward.png'></span>\
                <span class='closeButton'><img src='imgs/close.png'></span></span>"
    setElement : (newElement) ->
      @element = newElement
    getElement : () ->
      elementCopy = @element
    setup : (tags) =>
      @element = $("<div id='#{@name}'/>")
      @element.append($("#{@navBar}"))
      @element.append(tags)
    display :( newParent) =>
      @element.appendTo newParent
      @element.addClass "centerGallery"
      $('.closeButton').on('click', () =>
          @.hide()
        )
    hide : () =>
      @element.detach()
    hideNextButton : () =>
      $(".forwardButton").hide()
    hidePreviousButton : () =>
      $(".backButton").hide()
    showNextButton : () =>
      $(".forwardButton").show()
    showPreviousButton : () =>
      $(".backButton").show()
    

  return Gallery