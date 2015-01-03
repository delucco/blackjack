assert = chai.assert

ace = new Card 27
two = new Card 2
five = new Card 18
nine = new Card 9
ten = new Card 10
jack = new Card 11

testAppModel = new App();
#debugger
#testAppView = new AppView({collection: testAppModel})

playerHand = testAppModel.get('playerHand')
dealerHand = testAppModel.get('dealerHand')
game = testAppModel.get('gameModel')

describe 'Game', ->
  spy = sinon.spy(game, 'gameOver')

  it 'player busts only when over 21', ->
    playerHand.hit()
    if playerHand.scores()[0] > 21
      assert spy.called
    else
      playerHand.hit()
      playerHand.hit()
      playerHand.hit()
      playerHand.hit()
      playerHand.hit()
      playerHand.hit()
      playerHand.hit()
      assert spy.called

  game.stand()

  it 'should call determineWinner if dealer turn', ->
    assert spy.called

  it 'should toggle revealed status on stand', ->
    assert.equal dealerHand.models[0].get('revealed'), true

