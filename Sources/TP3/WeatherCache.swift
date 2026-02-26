// TP3 - Weather Data Aggregator
// Thread-Safe Cache with Actor

import Foundation

// 3. ACTOR CACHE (4 pts)
// TODO 3.1: Implémenter actor WeatherCache

actor WeatherCache {
    // TODO 3.2: Dictionary cache [String: CurrentWeather]
    private var cityCache: [String: CurrentWeather] = [:]
    // TODO 3.3: Compteurs hits et misses
    private var hits: Int = 0
    private var misses: Int = 0

    // TODO 3.4: func get(_ cityName: String) -> CurrentWeather?
    // Incrémenter hits ou misses selon le cas
    func get(_ cityName: String) -> CurrentWeather? {
        guard let cached = cityCache[cityName] else {
            self.misses += 1
            return nil
        }

        self.hits += 1
        return cached
    }

    // TODO 3.5: func set(_ weather: CurrentWeather, for cityName: String)
    func set(_ weather: CurrentWeather, for cityName: String) {
        cityCache[cityName] = weather
    }

    // TODO 3.6: func getStats() -> (hits: Int, misses: Int, total: Int)
    func getStats() -> (hits: Int, misses: Int, total: Int) {
        return (self.hits, self.misses, self.hits + self.misses)
    }
}
