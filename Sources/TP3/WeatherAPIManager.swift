// TP3 - Weather Data Aggregator
// Main Manager

import Foundation

final class WeatherAPIManager {
    static let shared = WeatherAPIManager()
    private init() {}

    func run() async {
        print("=== Weather Data Aggregator ===\n")
        let start = Date()

        // TODO 5.1: Créer array de 10 villes (1 pt)
        // Exemples: Paris (48.8566, 2.3522), London (51.5074, -0.1278), etc.
        let cities = [
            City(latitude: 48.8566, longitude: 2.3522, name: "Paris"),
            City(latitude: 51.5074, longitude: -0.1278, name: "London"),
            City(latitude: 35.6762, longitude: 139.6503, name: "Tokyo"),
            City(latitude: 40.7128, longitude: -74.0060, name: "New York"),
            City(latitude: -33.8688, longitude: 151.2093, name: "Sydney"),
            City(latitude: 52.5200, longitude: 13.4050, name: "Berlin"),
            City(latitude: 55.7558, longitude: 37.6173, name: "Moscow"),
            City(latitude: 25.2048, longitude: 55.2708, name: "Dubai"),
            City(latitude: -23.5505, longitude: -46.6333, name: "São Paulo"),
            City(latitude: 19.0760, longitude: 72.8777, name: "Mumbai"),
        ]

        // TODO 5.2: Créer WeatherCache + mesurer temps (1 pt)
        let cache = WeatherCache()

        // TODO 5.3: Appeler fetchMultipleCities et afficher résultats (2 pts)
        // ✓ Paris: 12.3°C, Wind: 15.2 km/h
        // ✗ London: Error - ...
        print("Fetching weather data for 10 cities...\n")
        let results = await fetchMultipleCities(cities, cache)
        var success: [(City, CurrentWeather)] = []
        var failures: [(City, Error)] = []
        for (city, weather) in results {
            do {
                let successWeather = try weather.get()
                success.append((city, successWeather))
            } catch {
                failures.append((city, error))
            }
        }

        for (city, weather) in success {
            print(
                "✓ \(city.name): \(weather.temperature)°C, Wind: \(weather.windspeed) km/h"
            )
        }
        for (city, err) in failures {
            print("X \(city.name): Error \(err.localizedDescription)")
        }

        // TODO 5.4: Calculer et afficher statistiques (3 pts)
        // - Total/Success/Failed
        // - Température avg/min/max
        // - Cache hits/misses/hit rate
        // - Temps d'exécution
        let avgTemp = success.reduce(0.0) { $0 + $1.1.temperature } / Double(success.count)
        print("\n=== Statistics ===")
        print("Total cities: \(cities.count)")
        print("Successful: \(success.count)")
        print("Failed: \(failures.count)")
        print("Average temperature: \(avgTemp)°C")
        if let warmest = success.max(by: { $0.1.temperature < $1.1.temperature }) {
            print("Warmest: \(warmest.0.name) at \(warmest.1.temperature)°C")
        }
        if let coldest = success.max(by: { $0.1.temperature > $1.1.temperature }) {
            print("Coldest: \(coldest.0.name) at \(coldest.1.temperature)°C")
        }

        let (hits, misses, total) = await cache.getStats()
        print("\n=== Cache Statistics ===")
        print("Cache hits: \(hits)")
        print("Cache misses: \(misses)")
        print("Hit rate: \(((Double(hits))/(Double(total))) * 100)%")

        // BONUS: Deuxième fetch pour tester le cache (+2 pts)
        print("\nRefetching for cache test")
        let _ = await fetchMultipleCities(cities, cache)
        let (hits2, misses2, total2) = await cache.getStats()
        print("\n=== Cache Statistics ===")
        print("Cache hits: \(hits2)")
        print("Cache misses: \(misses2)")
        print("Hit rate: \(((Double(hits2))/(Double(total2))) * 100)%")

        let finish = Date()
        print(
            "\nExecution time: \(String(format: "%.2f", DateInterval(start: start, end: finish).duration))s"
        )
    }
}
