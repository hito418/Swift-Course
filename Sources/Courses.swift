@main
struct CoursesTP {
    @MainActor
    static func main() {
        CardGameManager.shared.run()
    }
}
