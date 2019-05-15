//
//  DarkSkyForecast.swift
//  WeatherDetailApp
//
//  Created by Thomas Manos Bajis on 5/3/19.
//  Copyright © 2019 Thomas Manos Bajis. All rights reserved.
//

/// An object representing a weather forecast from the DarkSky API.
struct DarkSkyForecast: Decodable {
    
    /// The timezone of the forecast location.
    let timezone: String
    
    /// The `currently` data for the forecast response.
    let currently: DarkSkyCurrentForecast
    
    /// The `daily` data for the forecast response.
    let daily: DarkSkyDailyForecast
}

// MARK: - An extension for providing convenient forecast data

extension DarkSkyForecast {
    var currentTemperature: Int {
        return Int(currently.apparentTemperature)
    }
    var highTemperature: Int {
        guard let high = daily.data.first?.temperatureHigh else {
            return currentTemperature
        }
        return Int(high)
    }
    var lowTemperature: Int {
        guard let low = daily.data.first?.temperatureLow else {
            return currentTemperature
        }
        return Int(low)
    }
}

/// A data structure used to model the `currently` block of the DarkSky API forecast.
struct DarkSkyCurrentForecast: Decodable {
    let summary: String
    let icon: String
    let time: Double
    let apparentTemperature: Double
    let precipProbability: Double
    let windSpeed: Double
    let humidity: Double
    let uvIndex: Int
}

/// A data structure used to model the `daily` block of the DarkSky API forecast.
struct DarkSkyDailyForecast: Decodable {
    let data: [DarkSkyDailyForecastData]
}

/// A data structure used to model the `data` block of the DarkSky API forecast.
struct DarkSkyDailyForecastData: Decodable {
    let summary: String
    let temperatureHigh: Double
    let temperatureLow: Double
}
