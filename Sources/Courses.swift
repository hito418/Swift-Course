@main
struct CoursesTP {
    // TP1
    // @MainActor
    // static func main() {
    //     var movieList: [(title: String, year: Int, rating: Double, genre: String)] = [
    //         (title: "Inception", year: 2010, rating: 8.8, genre: "Sci-Fi"),
    //         (title: "The Dark Knight", year: 2008, rating: 9.0, genre: "Action"),
    //         (title: "Pulp Fiction", year: 1994, rating: 8.9, genre: "Crime"),
    //         (title: "The Shawshank Redemption", year: 1994, rating: 9.3, genre: "Drama"),
    //         (title: "Interstellar", year: 2014, rating: 8.6, genre: "Sci-Fi"),
    //         (title: "The Matrix", year: 1999, rating: 8.7, genre: "Sci-Fi"),
    //         (title: "Forrest Gump", year: 1994, rating: 8.8, genre: "Drama"),
    //         (title: "Fight Club", year: 1999, rating: 8.8, genre: "Drama"),
    //         (title: "The Godfather", year: 1972, rating: 9.2, genre: "Crime"),
    //         (title: "Gladiator", year: 2000, rating: 8.5, genre: "Action"),
    //     ]

    //     runApp(movies: &movieList)
    // }

    // TP2
    @MainActor
    static func main() {
        CardGameManager.shared.run()
    }
}
