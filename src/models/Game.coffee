class window.Game extends Backbone.Model

  initialize: ->
    @set 'turn', 0

  determineWinner: ->
    if @AppModel.get(playerHand.scores)[0] > @AppModel.get(dealerHand.scores)[0]
      console.log('player wins')
    else
      console.log('dealer wins')

  stand: ->
    if @get 'turn' is 0
      @set 'turn', 1
      @dealerTurn()

  dealerTurn: ->
    console.log('dealer turn is invoked')
    if @AppModel.get(dealerHand.scores)[0] > 16
      determineWinner()
    else
      @AppModel.get(dealerHand).hit()
      @dealerTurn()

  #need to handle aces in dealer turn and determineWinner, and busts
  #dealer turn is not invoking
