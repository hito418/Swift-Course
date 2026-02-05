// TP2 - Card Game System
// Card Model

import Foundation

// 1. ENUMS (1 point)
// Code fourni - Décommenter et compléter

enum Suit: String, CaseIterable {
  case hearts = "♥️"
  case diamonds = "♦️"
  case clubs = "♣️"
  case spades = "♠️"
}

enum Rank: Int, CaseIterable, Comparable {
  case two = 2
  case three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace

  // TODO: Ajouter computed property name qui retourne "2", "3", ..., "Jack", "Queen", "King", "Ace"
  var name: String {
    switch self {
    case .two:
      return "two"
    case .three:
      return "three"
    case .four:
      return "four"
    case .five:
      return "five"
    case .six:
      return "six"
    case .seven:
      return "seven"
    case .eight:
      return "eight"
    case .nine:
      return "nine"
    case .ten:
      return "ten"
    case .jack:
      return "Jack"
    case .queen:
      return "Queen"
    case .king:
      return "King"
    case .ace:
      return "Ace"
    }
  }

  static func < (lhs: Rank, rhs: Rank) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
}

// 2. STRUCT CARD (2 points)
// TODO: Implémenter la structure Card

struct Card: Comparable, Equatable {
  var rank: Rank
  var suit: Suit
  // TODO: Ajouter les propriétés rank et suit

  // TODO: Computed property description qui retourne "Ace of ♠️"
  var description: String {
    return "\(rank.name) of \(suit.rawValue)"
  }

  // TODO: Implémenter Comparable (comparer par rank)
  static func < (lhs: Card, rhs: Card) -> Bool {
    return lhs.rank < rhs.rank
  }

  static func == (lhs: Card, rhs: Card) -> Bool {
    return lhs.rank == rhs.rank
  }
}

extension Array where Element == Card {
  func highest() -> Card? {
    return self.max { $1.rank > $0.rank }
  }

  func description() -> String {
    self.map({ $0.description }).joined(separator: ", ")
  }
}
