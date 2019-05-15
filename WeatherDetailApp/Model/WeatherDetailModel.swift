//
//  WeatherDetailModel.swift
//  WeatherDetailApp
//
//  Created by Thomas Manos Bajis on 5/14/19.
//  Copyright © 2019 Thomas Manos Bajis. All rights reserved.
//

import Foundation

/// The Model for the Weather Detail Screen.
class WeatherDetailModel {
    
    // MARK: - Properties
    
    let location: (lat: String, lon: String)
    let client: DarkSkyClient
    let calendar: Calendar
    
    // MARK: - Initializers
    
    /// An initializer for creating an instance of `WeatherDetailModel`
    ///
    /// - Parameters:
    ///   - location: The location used for the weather forecast.
    ///   - client: The client used to make weather forecast requests.
    ///   - calendar: An instance of `Calendar` used for formatting dates/times.
    init(location: (lat: String, lon: String),
         client: DarkSkyClient,
         calendar: Calendar = Calendar.current) {
        self.location = location
        self.client = client
        self.calendar = calendar
    }
    
    /// A function used to request weather forecast information from a client.
    ///
    /// - Parameter completionHandler: An update to perform when the client returns a network forecast.
    func fetchLocalWeather(_ completionHandler: @escaping (Result<WeatherDetailDataModel, NetworkError>) -> Void) {
        // Ask the client for weather at a location
        client.fetchWeather(at: location) { [weak self] (forecastResult) in
            guard let strongSelf = self else { return }
            
            // Handle the result of the request
            // We "switch" on the forecastResult because our response could contain a
            // "success" or "error" value.
            switch forecastResult {
            case .success(let forecast):
                let time = forecast.currently.time
                let timeOfDay = strongSelf.timeOfDay(from: time)
                let chanceOfRain = Int(forecast.currently.precipProbability)
                let windspeed = Int(forecast.currently.windSpeed)
                let message = forecast.daily.data.first?.summary
                
                // Create our data model and call the completionHandler
                let dataModel = WeatherDetailDataModel(cityName: forecast.timezone,
                                                       icon: forecast.currently.icon,
                                                       message: message,
                                                       temperature: forecast.currentTemperature,
                                                       description: forecast.currently.summary,
                                                       highTemperature: forecast.highTemperature,
                                                       lowTemperature: forecast.lowTemperature,
                                                       rainPercentage: chanceOfRain,
                                                       humidityPercentage: forecast.currently.humidity,
                                                       windspeed: windspeed,
                                                       uvindex: forecast.currently.uvIndex,
                                                       timeOfDay: timeOfDay)
                completionHandler(.success(dataModel))
            case .failure(let forecastError):
                // Pass on the error to the completionHandler
                completionHandler(.failure(forecastError))
            }
        }
    }
    
    /// A function to compute a `TimeOfDay` from an input time.
    ///
    /// - Parameter unixTime: A Unix Time value.
    /// - Returns: An instance of `TimeOfDay`
    private func timeOfDay(from unixTime: Double) -> TimeOfDay {
        let date = Date(timeIntervalSince1970: unixTime)
        let hour = calendar.component(.hour, from: date)

        switch hour {
        case 6..<12:
            return .morning
        case 12:
            return .noon
        case 13..<17:
            return .afternoon
        case 17..<20:
            return .evening
        default:
            return .night
        }
    }
}
