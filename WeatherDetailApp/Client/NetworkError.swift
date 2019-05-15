//
//  NetworkError.swift
//  WeatherDetailApp
//
//  Created by Thomas Manos Bajis on 5/14/19.
//  Copyright © Thomas Manos Bajis. All rights reserved.
//

/// An enumeration capturing different types of network errors.
///
/// - statusCodeError: The network requests failed with a non `200` response code.
/// - malformedResponse: The network request returned data in a manner we aren’t expecting.
enum NetworkError: Error {
    case statusCodeError(Int)
    case malformedResponse
}
