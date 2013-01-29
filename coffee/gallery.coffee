class Gallery
  constructor : (@name) ->
  element : null
  setup : (tags) =>
    @element = $("<div id='#{@name}'/>").append(tags)
  display :( newParent) =>
    @element.appendTo(newParent)
  hide : () =>
    @element.detach()