class window.Game extends Backbone.Model

  initialize: ->
    @set('gameRunning', true)
    @get('AppModel').get('playerHand').on('hitter', @bustChecker, @)
    @get('AppModel').get('dealerHand').on('hitter', @bustChecker, @)

    #@set 'turn', 0

  determineWinner: ->
    #invoke gameOver()
    if @get('AppModel').get('playerHand').scores()[0] > @get('AppModel').get('dealerHand').scores()[0]
      @gameOver('player')
    else
      @gameOver('dealer')

  stand: ->
    @get('AppModel').get('dealerHand').models[0].flip()
    @dealerTurn()

    # if @get 'turn' is 0
    #   console.log('stand is invoked')
    #   @set 'turn', 1

  dealerTurn: ->
    #flip dealer card
    if @get('AppModel').get('dealerHand').scores()[0] > 16
      @determineWinner()
    else
      @get('AppModel').get('dealerHand').hit()
      @dealerTurn()

  bustChecker: ->
    if @get('AppModel').get('playerHand').scores()[0] > 21
      @gameOver('dealer')
    if @get('AppModel').get('dealerHand').scores()[0] > 21
      @gameOver('player')

  gameOver: (winner) ->
    if @get('gameRunning')
      @set('gameRunning', false)
      console.log('game over ' + winner)


  #need to handle aces in dealer turn and determineWinner
  #add in button for deal next hand
  #make it obvious on the dom who won
  #immediate game over on bust
