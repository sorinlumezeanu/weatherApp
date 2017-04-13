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
                let weather = self.parse(jsonWeatherData: data)
                completion(weather)
            }
        }        
        requestTask.resume()
    }
    
    private func parse(jsonWeatherData: Data) -> Weather? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonWeatherData) as? [String: Any] else { return nil }
        guard let json = jsonObject else { return nil }
        
        guard let jsonCoordinates = json["coord"] as? [String: Any] else { return nil }
        guard let latitude = jsonCoordinates["lat"] as? Double else { return nil }
        guard let longitude = jsonCoordinates["lon"] as? Double else { return nil }
        
        guard let jsonWeather = json["weather"] as? [Any] else { return nil }
        guard let id = (jsonWeather.first as? [String: Any])?["id"] as? Int else { return nil }
        guard let main = (jsonWeather.first as? [String: Any])?["main"] as? String else { return nil }
        guard let description = (jsonWeather.first as? [String: Any])?["description"] as? String else { return nil }
        guard let icon = (jsonWeather.first as? [String: Any])?["icon"] as? String else { return nil }
        
        return Weather(latitude: latitude,
                       longitude: longitude,
                       id: id,
                       main: main,
                       description: description,
                       icon: icon)
    }
    
    private func prepareRequestUrl(latitude: Double, longitude: Double) -> URL? {
        let urlString = "\(Constants.OpenWeatherMapBaseUrl)?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.OpenWeatherMapApiKey)"
        return URL(string: urlString)
    }
}
