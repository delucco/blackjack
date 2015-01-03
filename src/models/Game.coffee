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
    #else @determineWinner()

  dealerTurn: ->
    if @AppModel.get(dealerHand.scores)[0] > 16
      determineWinner()
    else
      @AppModel.get(dealerHand).hit()
      @dealerTurn()

    #if players turn, move to dealer turn
