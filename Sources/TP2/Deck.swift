import Foundation

final class Deck {
  var cards: [Card] = []

  init() {
    aggregateCards()
  }

  private func aggregateCards() {
    if cards.count > 0 {
      cards = []
    }

    for suit in Suit.allCases {
      for rank in Rank.allCases {
        cards.append(Card(rank: rank, suit: suit))
      }
    }
  }

  func shuffle() {
    var rng = SystemRandomNumberGenerator()
    cards.shuffle(using: &rng)
  }

  func draw() -> Card? {
    return cards.popLast()
  }

  func reset() {
    aggregateCards()
    shuffle()
  }
}
