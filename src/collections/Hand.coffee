class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    temp = @deck.pop()
    @add(temp)
    if @isBust() then @trigger 'bust'
    temp

  stand: ->
    @trigger('stand', @)

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    if @minScore() + 10 * @hasAce() > 21 then highscore = @minScore() else highscore = @minScore() + 10 * @hasAce()
    [@minScore(), @minScore() + 10 * @hasAce(), highscore]

  isNatural21: ->
    console.log(@scores()[1])
    @scores()[1] is 21

  isBust: ->
    @scores()[0] > 21
