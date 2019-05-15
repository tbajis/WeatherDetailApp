//
//  WeatherDetailDataModel.swift
//  WeatherDetailApp
//
//  Created by Thomas Manos Bajis on 5/14/19.
//  Copyright © 2019 Thomas Manos Bajis. All rights reserved.
//

/// A data model used to format a request by our `WeatherDetailModel`
struct WeatherDetailDataModel {
    let cityName: String
    let icon: String
    let message: String?
    let temperature: Int
    let description: String
    let highTemperature: Int
    let lowTemperature: Int
    let rainPercentage: Int
    let humidityPercentage: Double
    let windspeed: Int
    let uvindex: Int
    let timeOfDay: TimeOfDay
}

/// An enumeration representing the different times of day.
enum TimeOfDay {
    case morning
    case noon
    case afternoon
    case evening
    case night
}
