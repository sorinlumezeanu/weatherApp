//
//  MapVC.swift
//  WeatherApp
//
//  Created by Sorin Lumezeanu on 12/04/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import MapKit
import CoreLocation

import UIKit

class MapVC: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate, WeatherVCDataSource {
    
    fileprivate struct Constants {
        static let ShowWeatherDetailsSegueId = "ShowWeatherDetails"
    }

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var doubleTapGestureRecognizer: UITapGestureRecognizer!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let userLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            let region = MKCoordinateRegionMake(userLocation, span)
            self.mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
        }
    }
    
    // MARK: WeatherVCDataSource
    
    var locationCoordinate: CLLocationCoordinate2D?
    
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Constants.ShowWeatherDetailsSegueId:
            if let weatherVC = segue.destination as? WeatherVC {
                weatherVC.datasource = self
            }
            
        default:
            break
        }
    }
    
    
    // MARK: Tap Gesture Recognizer
    
    @IBAction func doubleTapped(sender: UITapGestureRecognizer?) {
        guard let sender = sender else { return }
        guard sender === self.doubleTapGestureRecognizer else { return }
        
        let touchLocation = sender.location(in: self.mapView)
        let touchLocationCoordinate = self.mapView.convert(touchLocation, toCoordinateFrom: self.mapView)
        self.locationCoordinate = touchLocationCoordinate
        
        self.performSegue(withIdentifier: Constants.ShowWeatherDetailsSegueId, sender: self)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
