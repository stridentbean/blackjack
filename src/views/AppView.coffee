class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button><button class="restart-button" style="display: none;">Restart</button>
    <div class="reserve">Chips: <%= chips %></div>
    <div class="bet">Bet: <%= bet %></div><button class="increase-button" style="display: none;">Increase</button><button class="decrease-button" style="display: none;">Decrease</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .restart-button':->
      @model.restartGame()
    'click .increase-button': ->
      @model.increaseBet()
      @render()
      $('.hit-button').hide()
      $('.stand-button').hide()
      $('.increase-button').show()
      $('.decrease-button').show()
      $('.restart-button').show()
    'click .decrease-button': ->
      @model.decreaseBet()
      @render()
      $('.hit-button').hide()
      $('.stand-button').hide()
      $('.increase-button').show()
      $('.decrease-button').show()
      $('.restart-button').show()

  initialize: ->
    @render()
    @model.on 'gameOver', ->
      @render()
      $('.hit-button').hide()
      $('.stand-button').hide()
      $('.increase-button').show()
      $('.decrease-button').show()
      $('.restart-button').show()
    , @
    @model.on 'restartGame', ->
      @render()
      $('.restart-button').hide()
      $('.increase-button').hide()
      $('.decrease-button').hide()
    , @

  render: ->
    @$el.children().detach()
    @$el.html @template(
      bet:@model.get('bet')
      chips:@model.get('chips')
    )
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

