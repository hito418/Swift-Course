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

func exportToCSV(_ movies: [(title: String, year: Int, rating: Double, genre: String)]) -> String {
    var csv = "Title,Year,Rating,Genre"
    for movie in movies {
        csv += "\n\(movie.title),\(movie.year),\(movie.rating),\(movie.genre)"
    }

    return csv
}

@main
struct MovieManagerEx {
    @MainActor
    static func main() {
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
        
        print("1.2 - Display")
        movieList.forEach { displayMovie($0) }

        print("\n1.3 - Add Movie")
        addMovie(title: "The Prestige", year: 2006, rating: 8.5, genre: "Drama", to: &movieList)
        movieList.forEach { displayMovie($0) }

        print("\n2.1 - Find Movie")
        if let movie = findMovie(byTitle: "inception", in: movieList) {
            displayMovie(movie)
        } else {
            print("Film non trouvé")
        }

        print("\n2.2 - Filter Movies")
        print("Sci-Fi Movies:")
        filterMovies(movieList) { $0.genre == "Sci-Fi" }.forEach({ displayMovie($0) })
        print("Recent Movies:")
        filterMovies(movieList) { $0.year >= 2015 }.forEach { displayMovie($0) }
        print("Top Rated Movies:")
        filterMovies(movieList) { $0.rating >= 8.0 }.forEach { displayMovie($0) }

        print("\n2.3 - Unique Genres")
        let uniqueGenres = getUniqueGenres(from: movieList)
        print("Unique Genres: \(uniqueGenres)")

        print("\n3.1 - Average score")
        let average = averageRating(of: movieList)
        print("\(average)\n")

        print("\n3.2 - Best score")
        if let best = bestMovie(in: movieList) {
            displayMovie(best)
        }

        print("\n3.3 - By decades")
        let moviesByDecadesDic = moviesByDecade(movieList)
        print(moviesByDecadesDic)

        print("\n5.1 - Export to CSV")
        let csv = exportToCSV(movieList)
        print(csv)
    }
}
