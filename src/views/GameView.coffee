class window.GameView extends Backbone.View
  template: _.template '
    <div class="gameOver hidden">
      <h2></h2>
      <button class="playAgain-button">Play Again!</button>
    </div>
  '

  events:
    'click .playAgain-button': ->
      @model.redeal()

  initialize: ->
    @render()
    @on 'click', -> @model.redeal()

  render: ->
    @$el.children().detach()
    @$el.html @template()

