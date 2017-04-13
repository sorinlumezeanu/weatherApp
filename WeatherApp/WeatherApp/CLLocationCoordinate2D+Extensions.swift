//
//  CLLocationCoordinate2D+Extensions.swift
//  WeatherApp
//
//  Created by Sorin Lumezeanu on 13/04/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    
    var latitudeMinutes:  Double { return (latitude * 3600).truncatingRemainder(dividingBy: 3600) / 60 }
    var latitudeSeconds:  Double { return (latitude * 3600).truncatingRemainder(dividingBy: 3600).truncatingRemainder(dividingBy: 60) }
    
    var longitudeMinutes: Double { return (longitude * 3600).truncatingRemainder(dividingBy: 3600) / 60 }
    var longitudeSeconds: Double { return (longitude * 3600).truncatingRemainder(dividingBy: 3600).truncatingRemainder(dividingBy: 60) }
    
    var dms:(latitude: String, longitude: String) {
        
        return (String(format:"%d° %d' %.4f\" %@",
                       Int(abs(latitude)),
                       Int(abs(latitudeMinutes)),
                       abs(latitudeSeconds),
                       latitude >= 0 ? "N" : "S"),
                String(format:"%d° %d' %.4f\" %@",
                       Int(abs(longitude)),
                       Int(abs(longitudeMinutes)),
                       abs(longitudeSeconds),
                       longitude >= 0 ? "E" : "W"))
    }
}
