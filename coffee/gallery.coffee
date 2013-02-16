define () ->
  class Gallery
    constructor : (@name) ->
      @element = null
      @navBar = "<div class='navHeader'><span class='backButton'><img src='./imgs/back.png'></span> \
                <span class='forwardButton'><img src='./imgs/forward.png'></span>\
                <span class='closeButton'><img src='imgs/close.png'></span></div>"
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

    

  return Gallery