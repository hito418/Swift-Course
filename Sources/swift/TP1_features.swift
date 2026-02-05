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
