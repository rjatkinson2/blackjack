# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'playerScore', @get('playerHand').scores()[0];
    @set 'dealerScore', @get('dealerHand').scores()[0];
    @set 'playerTurn', true

    context = @
    @get('playerHand').on 'add', (card,hand) ->
      score = hand.scores()[0]
      context.set 'playerScore', score
      if score > 21 then console.log 'Dealer Wins!'
      else console.log 'Hit or Stand!'
      return

    @get('playerHand').on 'stand', (card,hand) ->
      console.log 'stand'
      context.set 'playerTurn', false
      context.get('dealerHand').at(0).flip()
      dealerScore = context.get 'dealerScore'
      playerScore = context.get 'playerScore'
      if dealerScore > playerScore then console.log "Dealer Wins"
      else if dealerScore < 17 then context.get('dealerHand').hit()
      else console.log "Push!"
      return

    @get('dealerHand').on 'add', (card,hand) ->
      return

    return

