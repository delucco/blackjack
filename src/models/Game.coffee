class window.Game extends Backbone.Model

  initialize: ->
    @set('gameRunning', true)
    @get('AppModel').get('playerHand').on('hitter', @bustChecker, @)
    @get('AppModel').get('dealerHand').on('hitter', @bustChecker, @)

    #@set 'turn', 0

  determineWinner: ->
    #invoke gameOver()
    playerScores = @get('AppModel').get('playerHand').scores()
    maxPlayer = if playerScores[1] <= 21 then playerScores[1] else playerScores[0]
    dealerScores = @get('AppModel').get('dealerHand').scores()
    maxDealer = if dealerScores[1] <= 21 then dealerScores[1] else dealerScores[0]
    if maxPlayer > maxDealer
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

    #maybe ask if the double get below is best practice
    dealerScores = @get('AppModel').get('dealerHand').scores()
    if ( dealerScores[1] > 17 and dealerScores[1] <=21 ) or dealerScores[0] > 16
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

  #make it obvious on the dom who won
  #add in button for deal next hand
