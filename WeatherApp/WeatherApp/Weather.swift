//
//  Weather.swift
//  WeatherApp
//
//  Created by Sorin Lumezeanu on 13/04/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

struct Weather {
    let latitude: Double
    let longitude: Double
    
    let code: Int
    let main: String
    let description: String
    
    let icon: String
}
