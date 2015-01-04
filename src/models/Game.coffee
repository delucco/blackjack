class window.Game extends Backbone.Model

  initialize: ->
    @set('gameRunning', true)
    @set('winner', '')
    @get('AppModel').get('playerHand').on('hitter', @bustChecker, @)
    @get('AppModel').get('dealerHand').on('hitter', @bustChecker, @)


  determineWinner: ->
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
      @set('winner', winner)
      console.log('game over ' + winner)
      $('.gameOver').toggleClass('hidden')
      $('.gameOver h2').text(winner + ' won!')

  redeal: ->
    console.log('redealt')
    @set('winner','')
    @set('gameRunning',true)
    @get('AppModel').set 'playerHand', @get('AppModel').get('deck').dealPlayer()
    @get('AppModel').set 'dealerHand', @get('AppModel').get('deck').dealDealer()

  #gameRunning is messing us up
  #make it obvious on the dom who won
  #add in button for deal next hand
