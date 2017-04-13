//
//  LocationService.swift
//  WeatherApp
//
//  Created by Sorin Lumezeanu on 13/04/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationService()

    private let locationManager: CLLocationManager
    private(set) var currentLocation: CLLocation?

    private override init() {
        self.locationManager = CLLocationManager()
        
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        self.locationManager.startUpdatingLocation()
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.currentLocation = location
            NotificationCenter.notifyLocationChanged(location)
        }
    }    
}
