class window.Game extends Backbone.Model

  initialize: ->
    @set 'turn', 0

  determineWinner: ->
    if @get('AppModel').get('playerHand').scores()[0] > @get('AppModel').get('dealerHand').scores()[0]
      console.log('player wins')
    else
      console.log('dealer wins')

  stand: ->
      @dealerTurn()
    # if @get 'turn' is 0
    #   console.log('stand is invoked')
    #   @set 'turn', 1

  dealerTurn: ->
    #flip dealer card
    console.log(@get('AppModel').get('dealerHand') )
    if @get('AppModel').get('dealerHand').scores()[0] > 16
      @determineWinner()
    else
      @get('AppModel').get('dealerHand').hit()
      @dealerTurn()

  #need to handle aces in dealer turn and determineWinner, and busts
  #dealer turn is not invoking
