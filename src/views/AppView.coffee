class window.AppView extends Backbone.View
  template: _.template '
    <div class="container">
    <div class="table">
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="new-game">New Game</button>
    <div class="dealer-hand-container"></div>
    <div class="player-hand-container"></div>
    </div>
    </div>
  '

  events:
    'click .hit-button': -> if @model.get('playerScore') < 21 then @model.get('playerHand').hit()
    'click .stand-button': -> if @model.get('playerTurn') then @model.get('playerHand').stand()
    'click .new-game': ->
      @model.set('playerHand', @model.get('deck').dealPlayer())
      @model.set('dealerHand', @model.get('deck').dealDealer())
      @model.set('playerTurn', true)
      @render()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

