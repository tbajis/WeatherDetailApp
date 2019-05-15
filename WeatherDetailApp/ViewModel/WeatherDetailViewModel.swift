//
//  WeatherDetailViewModel.swift
//  WeatherDetailApp
//
//  Created by Thomas Manos Bajis on 5/14/19.
//  Copyright © 2019 Thomas Manos Bajis. All rights reserved.
//

import Foundation

/// An alias representing a color in RGB format.
typealias RGBColor = (red: Double, green: Double, blue: Double)

/// The ViewModel used for the weather detail screen.
class WeatherDetailViewModel {

    // MARK: - ViewModel - View Bindings (Storage)

    /// A closure (subscription) used for updating city image on the UI.
    var onCityImageUpdate: ((String) -> Void)?
    
    /// A closure (subscription) used for updating city name on the UI.
    var onCityNameUpdate: ((String) -> Void)?
    
    /// A closure (subscription) used for updating temperature on the UI.
    var onTemperatureUpdate: ((String) -> Void)?
    
    /// A closure (subscription) used for updating a description on the UI.
    var onDescriptionUpdate: ((String) -> Void)?
    
    /// A closure (subscription) used for updating a temperature range on the UI.
    var onTemperatureRangeUpdate: ((String) -> Void)?
    
    /// A closure (subscription) used for updating rain percentage UI.
    var onRainPercentageUpdate: ((String) -> Void)?
    
    /// A closure (subscription) used for updating wind speed on the UI.
    var onWindspeedUpdate: ((String) -> Void)?
    
    /// A closure (subscription) used for updating humidity percentage on the UI.
    var onHumidityPercentageUpdate: ((String) -> Void)?
    
    /// A closure (subscription) used for updating UV index on the UI.
    var onUvindexUpdate: ((String) -> Void)?
    
    /// A closure (subscription) used for updating the message on the UI.
    var onMessageUpdate: ((String) -> Void)?
    
    /// A closure (subscription) used for updating the UI with an error message.
    var onAPIFailure: ((String) -> Void)?
    
    /// A closure (subscription) used for updating the UI while a request is fetching.
    var onAPILoading: ((Bool) -> Void)?
    
    /// A closure (subscription) used for updating the background color on the UI.
    var onBackgroundColorUpdate: ((RGBColor) -> Void)?

    // MARK: - Properties

    private var cityImage: String = "" {
        didSet {
            onCityImageUpdate?(cityImage)
        }
    }
    private var cityName: String = "Default City Name" {
        didSet {
            onCityNameUpdate?(cityName)
        }
    }
    private var temperature: Int = 0 {
        didSet {
            let configured = "\(temperature)°"
            onTemperatureUpdate?(configured)
        }
    }
    private var description: String = "Default Description" {
        didSet {
            onDescriptionUpdate?(description)
        }
    }
    private var temperatureRange: (high: Int, low: Int) = (0, 0) {
        didSet {
            let configured = "\(temperatureRange.high)° / \(temperatureRange.low)°"
            onTemperatureRangeUpdate?(configured)
        }
    }
    private var rainPercentage: Int = 0 {
        didSet {
            let configured = "\(rainPercentage)%"
            onRainPercentageUpdate?(configured)
        }
    }
    private var windspeed: Int = 0 {
        didSet {
            let configured = "\(windspeed) MPH"
            onWindspeedUpdate?(configured)
        }
    }
    private var humidityPercentage: Double = 0 {
        didSet {
            let adjustedPercentage = humidityPercentage * 100
            let configured = "\(Int(adjustedPercentage))%"
            onHumidityPercentageUpdate?(configured)
        }
    }
    private var uvindex: Int = 0 {
        didSet {
            let configured = "\(uvindex)"
            onUvindexUpdate?(configured)
        }
    }
    private var message: String? {
        didSet {
            let defaultMessage = "This is the default message to the user."
            onMessageUpdate?(message ?? defaultMessage)
        }
    }

    private var backgroundColor: (red: Double, green: Double, blue: Double) = (red: 0, green: 113, blue: 188) {
        didSet {
            let color = (backgroundColor.red,
                         backgroundColor.green,
                         backgroundColor.blue)
            onBackgroundColorUpdate?(color)
        }
    }

    /// The model used to fetch data for the weather detail screen.
    var model: WeatherDetailModel? {
        didSet {
            refresh()
        }
    }
    
    /// A function used to ask weather forecast data from the Model.
    func refresh() {
        onAPILoading?(true)
        model?.fetchLocalWeather { [weak self] result in
            guard let strongSelf = self else { return }
            
            // Call our "onAPILoading" subscription to update the View
            // with a loading indicator while a request is inflight.
            strongSelf.onAPILoading?(false)
            switch result {
            case .success(let value):
                // Set all of our properties when a successful request completes
                // NOTE: This will call our View subscriptions
                strongSelf.cityImage = strongSelf.computeCityImage(from: value.icon)
                strongSelf.cityName = value.cityName
                strongSelf.temperature = value.temperature
                strongSelf.description = value.description
                strongSelf.temperatureRange = (value.highTemperature, value.lowTemperature)
                strongSelf.rainPercentage = value.rainPercentage
                strongSelf.windspeed = value.windspeed
                strongSelf.humidityPercentage = value.humidityPercentage
                strongSelf.uvindex = value.uvindex
                strongSelf.message = value.message
                
                let backgroundColor = strongSelf.computeBackgroundColor(from: value.timeOfDay)
                strongSelf.backgroundColor = backgroundColor
            case .failure(let error):
                switch error {
                case .statusCodeError(_):
                    // Alert user that a network error occured
                    // Call "onAPIFailure" subscription with a network message
                    let errorToDisplay = "It looks like a network error occured. Try checking your internet connectivity!"
                    strongSelf.onAPIFailure?(errorToDisplay)
                case .malformedResponse:
                    // Alert the user that a malformed response was recieved
                    // Call "onAPIFailure" subscription with a malformed response message
                    let errorToDisplay = "The API is returning something we're not expecting. Take a look at the response payload!"
                    strongSelf.onAPIFailure?(errorToDisplay)
                }
            }
        }
    }

    /// A function to compute a background color.
    ///
    /// - Parameter timeOfDay: A `TimeOfDay` to compute a background color from.
    /// - Returns: An `RGB` color appropriate for the specific `TimeOfDay`.
    private func computeBackgroundColor(from timeOfDay: TimeOfDay) -> RGBColor {
        switch timeOfDay {
        case .morning, .noon, .afternoon, .evening:
            return (red: 0 / 256, green: 113 / 256, blue: 188 / 256)
        case .night:
            return (red: 9 / 256, green: 28 / 256, blue: 73 / 256)
        }
    }

    /// A function used to determine an image name based on API response icon.
    ///
    /// - Parameter iconString: The icon provided by the data model.
    /// - Returns: An image name from the Asset catalog.
    private func computeCityImage(from iconString: String) -> String {
        switch iconString {
        case "clear-day":
            return "clear-day-large"
        case "clear-night":
            return "clear-night-large"
        case "rain":
            return "rain-large"
        case "snow", "sleet":
            return "snow-large"
        case "wind", "fog":
            return "fog-large"
        case "cloudy":
            return "cloudy-large"
        case "partly-cloudy-day":
            return "partly-cloudy-day-large"
        case "partly-cloudy-night":
            return "partly-cloudy-night-large"
        default:
            return "clear-day-large"
        }
    }
}
