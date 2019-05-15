//
//  DarkSkyClient.swift
//  WeatherDetailApp
//
//  Created by Thomas Manos Bajis on 5/14/19.
//  Copyright © 2019 Thomas Manos Bajis. All rights reserved.
//

/// A generic interface for fetching weather data.
protocol DarkSkyClient {
    
    /// A function used to fetch weather for a specific location.
    ///
    /// - Parameters:
    ///   - location: Tuple containing a location’s latitude and longitude.
    ///   - completion: A completion handler for subscribing to weather updates.
    func fetchWeather(at location: (lat: String, lon: String),
                      completion: @escaping (Result<DarkSkyForecast, NetworkError>) -> Void)
}
