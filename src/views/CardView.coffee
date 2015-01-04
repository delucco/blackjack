class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img src=img/cards/<%= rankName %>-<%= suitName %>.png></img>'
  #template: _.template '<%= rankName %> of <%= suitName %>'
  #background-image: url("../img/card-back.png");

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'

