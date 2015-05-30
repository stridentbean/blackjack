# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  result: 3
  binder = null

  initialize: ->
    binder = @
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'natural21', (event) =>
      binder.win()
    @get('dealerHand').on 'natural21', (event) =>
      binder.lose()
    @get('playerHand').on 'bust', (event) =>
      binder.lose()
    @get('dealerHand').on 'bust', (event) =>
      binder.win()
    @get('playerHand').on 'stand', (event) =>
      binder.outcome()

  outcome: ->
    if @get('dealerHand').scores()[2] < @get('playerHand').scores()[2] then @win()
    if @get('dealerHand').scores()[2] is @get('playerHand').scores()[2] then @result = 0
    if @get('dealerHand').scores()[2] > @get('playerHand').scores()[2] then @lose()
    #if @get('dealerHand').scores()[0] > 21 then return 1
    #if @get('playerHand').length is 2 and @get('playerHand').scores()[1] is 21 then return 1
    #if @get('playerHand').scores()[0] > 21 then return -1

  win: ->
    @result = 1
    console.log('You Win')
    #TODO start new game
  lose: ->
    @result = -1
    console.log('You Lose')
    #TODO start new game
