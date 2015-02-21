# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'playerScore', @get('playerHand').scores()[0];
    @set 'dealerScore', @get('dealerHand').scores()[0];
    console.log @get 'playerScore'

    context = @
    @get('playerHand').on 'add', (card,hand) ->
      console.log hand
      score = hand.scores()[0]
      context.set 'playerScore', score
      if score > 21 then console.log 'Dealer Wins!'
      else console.log 'Hit or Stand!'
      return

    @get('dealerHand').on 'add', (card,hand) ->
      console.log hand
      return

    return

