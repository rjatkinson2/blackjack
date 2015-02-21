# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'playerScore', @get('playerHand').scores()[1];
    @set 'dealerScore', @get('dealerHand').scores()[1];
    @set 'playerTurn', true

    context = @
    if context.get('playerScore') is 21 then console.log 'Blackjack! Player Wins!'
    @get('playerHand').on 'add', (card,hand) ->
      # console.log context.get('deck').length
      scoreMin = hand.scores()[0]
      scoreMax = hand.scores()[1]
      if scoreMax > 21
        if scoreMin > 21 then console.log 'Dealer Wins!'
        else
          context.set 'playerScore', scoreMin
          console.log "Hit or Stand!"
      else console.log 'Hit or Stand!'
      return

    @get('playerHand').on 'stand', (card,hand) ->
      console.log 'stand'
      context.set 'playerTurn', false
      context.get('dealerHand').at(0).flip()
      context.set 'dealerScore', context.get('dealerHand').scores()[1]
      console.log 'dealerScore: ' + context.get 'dealerScore'
      dealerScore = context.get 'dealerScore'
      playerScore = context.get 'playerScore'
      if dealerScore > playerScore then console.log "Dealer Wins"
      else if dealerScore < 17 then context.get('dealerHand').hit()
      else console.log "Push!"
      return

    @get('dealerHand').on 'add', (card,hand) ->
      dealerScore = hand.scores()[1]
      playerScore = context.get('playerScore')
      console.log 'dealerScore: ' + dealerScore
      console.log 'playerscore: ' + playerScore
      if dealerScore > 21 then console.log "Player Wins!"
      else if dealerScore > playerScore then console.log "Dealer Wins"
      else if dealerScore < 17 then context.get('dealerHand').hit()
      else if dealerScore == playerScore then console.log "Push!"
      else console.log "Player Wins!"
      return

    return

