//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Sorin Lumezeanu on 13/04/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

class WeatherService {
    
    fileprivate struct Constants {
        static let OpenWeatherMapBaseUrl = "http://api.openweathermap.org/data/2.5/weather"
        static let OpenWeatherMapApiKey = "ab7fa5db4ade8b20ec475c7dbe5f0d08"
    }
    
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping ((_ result: Weather?) -> ())) {
        guard let requestUrl = self.prepareRequestUrl(latitude: latitude, longitude: longitude) else {
            completion(nil)
            return
        }
        
        let requestTask = URLSession.shared.dataTask(with: requestUrl) {(data, response, error) in
            if let error = error {
                print("WeatherService.fetchWeather: error: \(error)")
                completion(nil)
                return
            }
            
            if let data = data {
                print(data)
            }
        }        
        requestTask.resume()
    }
    
    private func prepareRequestUrl(latitude: Double, longitude: Double) -> URL? {
        let urlString = "\(Constants.OpenWeatherMapBaseUrl)?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.OpenWeatherMapApiKey)"
        return URL(string: urlString)
    }
}
