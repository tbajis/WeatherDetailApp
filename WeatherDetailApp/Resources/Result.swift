//
//  Result.swift
//  WeatherDetailApp
//
//  Created by Thomas Manos Bajis on 5/3/19.
//  Copyright © 2019 Thomas Manos Bajis. All rights reserved.
//

/// An enumeration representing a basic operation
///
/// - success: Result success value of type `T`
/// - failure: Result failure value of type `Error`
enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
