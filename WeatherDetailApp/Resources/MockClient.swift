//
//  MockClient.swift
//  WeatherDetailApp
//
//  Created by Thomas Manos Bajis on 5/14/19.
//  Copyright © 2019 Thomas Manos Bajis. All rights reserved.
//

import Foundation

/// A Mock Client used to supply data for the weather detail screen.
struct MockClient: DarkSkyClient {
    
    // MARK: - Properties
    
    let responseType: ResponseType

    /// An enumeration describing the different results a `MockClient` can return.
    ///
    /// - success: A Result containing successful response.
    /// - networkError: A Result containing a network error.
    /// - malformedResponse: A Result containing a malformed response.
    enum ResponseType {
        case success
        case networkError
        case malformedResponse
    }

    func fetchWeather(at location: (lat: String, lon: String), completion: @escaping (Result<DarkSkyForecast, NetworkError>) -> Void) {
        guard let file = Bundle.main.path(forResource: "mockResponse", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: file), options: []),
            let forecast = try? JSONDecoder().decode(DarkSkyForecast.self, from: data) else { return }

        let result: Result<DarkSkyForecast, NetworkError>
        switch responseType {
        case .success:
            result = .success(forecast)
        case .networkError:
            result = .failure(.statusCodeError(500))
        case .malformedResponse:
            result = .failure(.malformedResponse)
        }
        
        // NOTE: "DispatchQueue.main.asyncAfter" is used to simulate a network request delay.
        // This allows the UI to show a loading indicator for a couple seconds.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(result)
        }
    }
}
