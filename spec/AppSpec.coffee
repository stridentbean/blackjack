assert = chai.assert

describe 'app', ->
  app = null

  beforeEach ->
    app = new App()

  describe 'natural 21', ->
    it 'should return a win if a natural 21 on opening hand with the play', ->
      app.set 'playerHand' , new Hand [new Card(rank: 11, suit:1), new Card(rank: 1, suit: 0)]
      assert.strictEqual app.result, 1

  describe 'player bust', ->
    it 'should return a loss if the players score is greater than 21', ->
      app.set 'playerHand' , new Hand [new Card(rank: 11, suit:1), new Card(rank: 11, suit: 2), new Card(rank: 11, suit: 0)]
      assert.strictEqual app.result, -1

  describe 'player push', ->
    it 'return push if the player and dealer have the same score', ->
      app.set 'playerHand' , new Hand [new Card(rank: 9, suit:1), new Card(rank: 1, suit: 0)]
      app.set 'dealerHand' , new Hand [new Card(rank: 9, suit:2), new Card(rank: 1, suit: 1)]
      assert.strictEqual app.result, 0

  describe 'player lose', ->
    it 'should return a lose if the player loses to the dealer', ->
      app.set 'playerHand' , new Hand [new Card(rank: 8, suit:1), new Card(rank: 1, suit: 0)]
      app.set 'dealerHand' , new Hand [new Card(rank: 9, suit:2), new Card(rank: 1, suit: 1)]
      assert.strictEqual app.result, -1
