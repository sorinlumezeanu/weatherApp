//
//  Weather.swift
//  WeatherApp
//
//  Created by Sorin Lumezeanu on 13/04/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation
import CoreLocation

struct Weather {
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        }
    }
    
    let id: Int
    let main: String
    let description: String
    
    let icon: String
}
