// TP3 - Weather Data Aggregator
// Async Fetching Functions

import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

// HELPER: Wrapper cross-platform pour URLSession (fourni)
// Cette fonction fonctionne sur macOS, Linux et Windows
@available(macOS 10.15, *)
func fetchData(from url: URL) async throws -> (Data, URLResponse) {
    #if os(macOS)
        if #available(macOS 12.0, *) {
            return try await URLSession.shared.data(from: url)
        }
    #endif

    return try await withCheckedThrowingContinuation { continuation in
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                continuation.resume(throwing: error)
                return
            }
            guard let data = data, let response = response else {
                continuation.resume(throwing: URLError(.badServerResponse))
                return
            }
            continuation.resume(returning: (data, response))
        }
        task.resume()
    }
}

// 4. FETCH FUNCTIONS (8 pts)

// TODO 4.1: Fonction buildWeatherURL(latitude:longitude:) -> URL? (1 pt)
// URL: https://api.open-meteo.com/v1/forecast?latitude=XX&longitude=YY&current_weather=true
func buildWeatherURL(_ latitude: Double, _ longitude: Double) -> URL? {
    return URL(
        string:
            "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current_weather=true"
    )
}

// TODO 4.2: Fonction async fetchWeather(for city: City) throws -> CurrentWeather (3 pts)
// - Construire l'URL
// - Utiliser fetchData(from: url) pour obtenir (data, response)
// - Vérifier code HTTP 200-299
// - JSONDecoder().decode(WeatherResponse.self, from: data)
// - Retourner currentWeather
func fetchWeather(for city: City) async throws -> CurrentWeather {
    guard let url = buildWeatherURL(city.latitude, city.longitude) else {
        throw WeatherError.invalidURL
    }

    let (data, response) = try await fetchData(from: url)

    guard
        (response as! HTTPURLResponse).statusCode >= 200
            && (response as! HTTPURLResponse).statusCode < 300
    else {
        throw WeatherError.networkError("String")
    }

    let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
    return weatherResponse.current_weather
}

// TODO 4.3: Fonction async fetchMultipleCities(cities, cache) -> [(City, Result<CurrentWeather, Error>)] (4 pts)
// - withTaskGroup
// - Pour chaque ville: group.addTask { ... }
// - Vérifier cache avant fetch
// - Mettre en cache après fetch réussi
// - Collecter tous les résultats avec for await
func fetchMultipleCities(_ cities: [City], _ cache: WeatherCache) async -> [(
    City, Result<CurrentWeather, Error>
)] {
    return await withTaskGroup(of: (City, Result<CurrentWeather, Error>).self) { group in
        for city in cities {
            group.addTask {
                guard let currentWeather = await cache.get(city.name) else {
                    do {
                        let fetchedCurrentWeather = try await fetchWeather(for: city)
                        await cache.set(fetchedCurrentWeather, for: city.name)

                        return (city, Result.success(fetchedCurrentWeather))
                    } catch {
                        return (city, Result.failure(error))
                    }
                }
                return (city, Result.success(currentWeather))
            }
        }

        var results: [(City, Result<CurrentWeather, Error>)] = []
        for await result in group {
            results.append(result)
        }
        return results
    }
}
