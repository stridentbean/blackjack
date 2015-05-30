# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  defaults:
    chips: 2000
    bet: 500

  initialize: ->
    @restartGame()

  outcome: ->
    if @get('dealerHand').scores()[2] > 21 then return @win()
    if @get('dealerHand').scores()[2] < @get('playerHand').scores()[2] then return @win()
    if @get('dealerHand').scores()[2] is @get('playerHand').scores()[2] then return @push()
    if @get('dealerHand').scores()[2] > @get('playerHand').scores()[2] then return @lose()
    #if @get('dealerHand').scores()[0] > 21 then return 1
    #if @get('playerHand').length is 2 and @get('playerHand').scores()[1] is 21 then return 1
    #if @get('playerHand').scores()[0] > 21 then return -1

  dealerPlays: ->
    #logic for dealer hit and standing
    @get('dealerHand').at(0).flip()
    while(@get('dealerHand').scores()[0] < 17)
      @get('dealerHand').hit()
    @get('dealerHand').stand()

  restartGame: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    if @get('playerHand').isNatural21() then @win()
    @get('dealerHand').on 'natural21', @lose, @
    @get('playerHand').on 'bust', ->
      @get('dealerHand').at(0).flip()
      @lose()
    , @
    @get('playerHand').on 'stand', @dealerPlays, @
    @get('dealerHand').on 'stand', @outcome, @
    @trigger 'restartGame'

  win: ->
    console.log('You Win')
    @gameOver()
    #TODO start new game

  lose: ->
    console.log('You Lose')
    @gameOver()
    #TODO start new game

  push: ->
    console.log('Push')
    @gameOver()

  gameOver: ->
    @trigger 'gameOver'

  increaseBet: ->
    @set 'bet', @get('bet') + 100
    @set 'chips', @get('chips') - 100

  decreaseBet: ->
    @set 'bet', @get('bet') - 100
    @set 'chips', @get('chips') + 100

