protocol Player: AnyObject {
  var name: String { get }
  var hand: [Card] { get set }
  var score: Int { get set }

  func playCard() -> Card?
  func receiveCard(_ card: Card)
}

final class HumanPlayer: Player {
  var name: String

  var hand: [Card]

  var score: Int

  init(_ name: String) {
    self.name = name
    self.hand = []
    self.score = 0
  }

  func playCard() -> Card? {
    return hand.popLast()
  }

  func receiveCard(_ card: Card) {
    hand.append(card)
  }
}

final class AiPlayer: Player {
  var name: String

  var hand: [Card]

  var score: Int

  init(_ name: String) {
    self.name = name
    self.hand = []
    self.score = 0
  }

  func playCard() -> Card? {
    return hand.popLast()
  }

  func receiveCard(_ card: Card) {
    hand.append(card)
  }
}
