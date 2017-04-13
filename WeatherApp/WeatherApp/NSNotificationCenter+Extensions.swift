//
//  NSNotificationCenter+Extensions.swift
//  WeatherApp
//
//  Created by Sorin Lumezeanu on 13/04/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation
import CoreLocation

extension Notification.Name {
    static let locationChanged = Notification.Name("locationChanged")
}

extension NotificationCenter {
    
    static func notifyLocationChanged(_ newLocation: CLLocation) {
        NotificationCenter.default.post(name: .locationChanged, object: nil, userInfo: ["location": newLocation])
    }
    
}
