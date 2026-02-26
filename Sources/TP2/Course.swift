@main
struct CoursesTP2 {
    @MainActor
    static func main() {
        CardGameManager.shared.run()
    }
}
