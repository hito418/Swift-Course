// TP2 - Card Game System
// Card Game Manager with Singleton Pattern

import Foundation

// Game Manager avec singleton pattern
final class CardGameManager {
    @MainActor static let shared = CardGameManager()

    private init() {}

    // TODO: 3-7. Implémenter les autres composants
    // - Class Deck (3 pts)
    // - Protocol Player (2 pts)
    // - Classes HumanPlayer/AIPlayer (2 pts)
    // - Class Game (7 pts)
    // - Extensions Array<Card> (2 pts)

    func run() {
        print("Card Game: War")
        print("=================\n")

        let player1 = HumanPlayer("Alice")
        let player2 = AiPlayer("Bob")

        let game = Game(player1,player2)
        game.dealCards()
        game.play()

        print("=== EXTENSION TEST ===")
        let testCardList: [Card] = [Card(rank: .five, suit: .hearts), Card(rank: .king, suit: .spades), Card(rank: .three, suit: .diamonds)]
        print("Test Cards: \(testCardList.description())")
        if let highestCard = testCardList.highest() {
            print("Highest card: \(highestCard.description)")
        } else {
            print("No cards in the list.")
        }

        // TODO: Créer deux joueurs
        // let player1 = HumanPlayer(name: "Alice")
        // let player2 = AIPlayer(name: "Bob")

        // TODO: Créer et lancer une partie
        // let game = Game(player1: player1, player2: player2)
        // game.play()
    }
}