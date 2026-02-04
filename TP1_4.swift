var movieList: [(title: String, year: Int, rating: Double, genre: String)] = [
    (title: "Inception", year: 2010, rating: 8.8, genre: "Sci-Fi"),
    (title: "The Dark Knight", year: 2008, rating: 9.0, genre: "Action"),
    (title: "Pulp Fiction", year: 1994, rating: 8.9, genre: "Crime"),
    (title: "The Shawshank Redemption", year: 1994, rating: 9.3, genre: "Drama"),
    (title: "Interstellar", year: 2014, rating: 8.6, genre: "Sci-Fi"),
    (title: "The Matrix", year: 1999, rating: 8.7, genre: "Sci-Fi"),
    (title: "Forrest Gump", year: 1994, rating: 8.8, genre: "Drama"),
    (title: "Fight Club", year: 1999, rating: 8.8, genre: "Drama"),
    (title: "The Godfather", year: 1972, rating: 9.2, genre: "Crime"),
    (title: "Gladiator", year: 2000, rating: 8.5, genre: "Action"),
]

func displayMovie(_ movie: (title: String, year: Int, rating: Double, genre: String)) {
    print("📽️  \(movie.title) (\(movie.year)) - \(movie.genre)\n⭐ Rating: \(movie.rating)/10")
}

func addMovie(
    title: String, year: Int, rating: Double, genre: String,
    to: inout [(title: String, year: Int, rating: Double, genre: String)]
) {
    let newMovie = (title: title, year: year, rating: rating, genre: genre)
    to.append(newMovie)
}

func findMovie(
    byTitle title: String, in movies: [(title: String, year: Int, rating: Double, genre: String)]
) -> (title: String, year: Int, rating: Double, genre: String)? {
    return movies.first { $0.title.lowercased() == title.lowercased() }
}

func filterMovies(
    _ movies: [(title: String, year: Int, rating: Double, genre: String)],
    matching criteria: ((title: String, year: Int, rating: Double, genre: String)) -> Bool
) -> [(title: String, year: Int, rating: Double, genre: String)] {
    return movies.filter(criteria)
}

func getUniqueGenres(from movies: [(title: String, year: Int, rating: Double, genre: String)])
    -> Set<String>
{
    return Set<String>(movies.map { $0.genre })
}

func averageRating(of movies: [(title: String, year: Int, rating: Double, genre: String)]) -> Double
{
    let sum = movies.reduce(0.0, { $0 + $1.rating })
    return sum / Double(movies.count)
}

func bestMovie(in movies: [(title: String, year: Int, rating: Double, genre: String)]) -> (
    title: String, year: Int, rating: Double, genre: String
)? {
    return movies.max(by: { $1.rating > $0.rating })
}

func moviesByDecade(_ movies: [(title: String, year: Int, rating: Double, genre: String)])
    -> [String: [(title: String, year: Int, rating: Double, genre: String)]]
{
    let decades = Set<Int>(movies.map { $0.year / 10 * 10 })
    var dic: [String: [(title: String, year: Int, rating: Double, genre: String)]] = [:]

    for decade in decades {
        dic[String(decade)] = movies.filter({ $0.year / 10 * 10 == decade })
    }

    return dic
}

func displayMenu() {
    print(
        """
        === 🎬 Movie Manager ===
        1. Afficher tous les films
        2. Rechercher un film
        3. Filtrer par genre
        4. Afficher les statistiques
        5. Ajouter un film
        6. Quitter
        """)
}

func clearTerminal() {
    print("\u{001B}[2J")
}

func runApp() {
    var shouldStop = false;
    clearTerminal()
    displayMenu()

    while let input = readLine() {
        switch input {
        case "1":
            clearTerminal()
            movieList.forEach({ displayMovie($0) })
        case "2":
            clearTerminal()
            print("Nom du film:")
            if let title = readLine() {
                if let movie = findMovie(byTitle: title, in: movieList) {
                    displayMovie(movie)
                } else {
                    print("Film non trouvé")
                }
            } else {
                print("Internal Error")
            }
        case "3":
            clearTerminal()
            let genreList = Array(getUniqueGenres(from: movieList))
            print("Genre:")
            genreList.enumerated().forEach { print("\($0 + 1). \($1)") }
            if let genreIndex = readLine() {
                guard let index = Int(genreIndex), index > 0, index <= genreList.count else {
                    print("Invalid input")
                    break
                }
                let genre = genreList[index - 1]

                let movies = filterMovies(movieList, matching: { $0.genre == genre })
                movies.forEach { displayMovie($0) }
            } else {
                print("Internal Error")
            }
        case "4":
            clearTerminal()
            print("Nombre de films: \(movieList.count)")
            print("Note moyenne: \(averageRating(of: movieList))")
            if let movie = bestMovie(in: movieList) {
                print("Film le mieux noté:")
                displayMovie(movie)
            }
        case "5":
            print("Titre:")
            guard let title = readLine() else {
                clearTerminal()
                print("Internal Error")
                break
            }
            print("Année:")
            guard let year = Int(readLine()!) else {
                clearTerminal()
                print("Internal error")
                break
            }
            print("Rating:")
            guard let rating = Double(readLine()!) else {
                clearTerminal()
                print("Internal error")
                break
            }
            print("Genre:")
            guard let genre = readLine() else {
                clearTerminal()
                print("Internal error")
                break
            }
            addMovie(title: title, year: year, rating: rating, genre: genre, to: &movieList)
            print("movie Added")
        case "6":
        shouldStop = true
            break
        default:
            clearTerminal()
            print("unknown command")
        }

        if (shouldStop) {
            break
        }
        displayMenu()
    }
}

runApp()
