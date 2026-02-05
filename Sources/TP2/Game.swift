final class Game {
  var player1: Player
  var player2: Player
  var deck: Deck

  init(_ player1: Player, _ player2: Player) {
    self.player1 = player1
    self.player2 = player2
    self.deck = Deck()
  }

  func dealCards() {
    print("Dealing cards...")
    while let card = deck.draw() {
      player1.receiveCard(card)

      guard let card2 = deck.draw() else {
        break
      }

      player2.receiveCard(card2)
    }

    print("\(player1.name) received \(player1.hand.count) cards")
    print("\(player2.name) received \(player2.hand.count) cards")
  }

  func playRound(_ round: Int) -> Player? {
    var draw = false
    repeat {
      for _ in 0..<3 {
        let _ = player1.playCard()
        let _ = player2.playCard()
      }

      guard let card1 = player1.playCard(), let card2 = player2.playCard() else {
        return nil
      }

      print("--- Round \(round) ---")

      print("\(player1.name) plays: \(card1.description)")
      print("\(player2.name) plays: \(card2.description)")

      if card1 == card2 {
        draw = true
        print("War! Each player plays 3 cards...")
        continue
      }
      draw = false

      if card1 > card2 {
        player1.score += 1
        return player1
      }
      player2.score += 1
      return player2
    } while draw == true
  }

  func play() {
    var round = 1
    while let roundWinner = playRound(round) {
      print("\(roundWinner.name) win this round!")
      print("Score: \(player1.name) \(player1.score) - \(player2.name) \(player2.score)")
      round += 1
    }

    print("=== GAME OVER ===")

    guard let winner = [player1, player2].max(by: { $1.score > $0.score }) else {
      print("Internal error")
      return
    }

    print("Winner: \(winner.name) with \(winner.score) points!")
    print("Final score: \(player1.name) \(player1.score) - \(player2.name) \(player2.score)")
  }
}
