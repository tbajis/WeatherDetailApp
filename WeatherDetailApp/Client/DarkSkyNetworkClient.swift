//
//  DarkSkyNetworkClient.swift
//  WeatherDetailApp
//
//  Created by Thomas Manos Bajis on 5/14/19.
//  Copyright © 2019 Thomas Manos Bajis. All rights reserved.
//

import Foundation

struct DarkSkyNetworkClient: DarkSkyClient {
    
    // MARK: - Properties
    
    /// The API Key used to to request data from the DarkSky API
    let apiKey: String
    
    /// An instance of `URLSession` used for making network requests
    let session: URLSession = URLSession.shared
    
    // MARK: - DarkSkyClient conformance

    func fetchWeather(at location: (lat: String, lon: String),
                      completion: @escaping (Result<DarkSkyForecast, NetworkError>) -> Void) {
        let url = constructUrl(key: apiKey,
                               scheme: DarkSkyNetworkConstants.Scheme,
                               method: DarkSkyNetworkConstants.Method,
                               endPoint: DarkSkyNetworkConstants.EndPoint,
                               location: location)

        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { (data, response, error) in
            // NOTE: We’re putting our network request completion code in a DispatchQueue.main.async block.
            // This ensures that our completion handler is called on the main thread.
            // Calling completion handlers on the main thread is useful when updates to UI are intended.
            DispatchQueue.main.async {
                guard let response  = response as? HTTPURLResponse else { return }

                guard response.statusCode == 200 else {
                    completion(.failure(.statusCodeError(response.statusCode)))
                    return
                }

                guard let data = data,
                    let forecast = try? JSONDecoder().decode(DarkSkyForecast.self, from: data) else {
                        completion(.failure(.malformedResponse))
                        return
                }

                completion(.success(forecast))
            }
        }
        task.resume()
    }
    
    // MARK: - Helper methods
    
    /// Constructs a url from components.
    ///
    /// - Parameters:
    ///   - key: The API key used for DarkSky API requests.
    ///   - scheme: The scheme used for the network request (Typically `https`).
    ///   - method: The method for the API call.
    ///   - endPoint: The targeted API endpoint.
    ///   - location: A tuple containing a location’s latitude and longitude.
    /// - Returns: A fully-formed URL for making network requests.
    private func constructUrl(key: String,
                              scheme: String,
                              method: String,
                              endPoint: String,
                              location: (lat: String, lon: String)) -> URL {
        let locationString = location.lat + "," + location.lon
        let fullUrlString = scheme + "://" + method + "/" + endPoint + "/" + apiKey + "/" + locationString

        return URL(string: fullUrlString)!
    }
}
