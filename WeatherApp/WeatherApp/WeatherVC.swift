//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Sorin Lumezeanu on 12/04/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherVCDataSource: class {
    var locationCoordinate: CLLocationCoordinate2D? { get }
}

class WeatherVC: UITableViewController {

    weak var datasource: WeatherVCDataSource?
    
    @IBOutlet weak var weatherMainLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherCoordinateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let datasource = datasource {
            if let locationCoordinate = datasource.locationCoordinate {
                let weatherService = WeatherService()
                weatherService.fetchWeather(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude) { (weather) in
                    DispatchQueue.main.async {
                        self.updateWeatherDetails(weather)
                    }
                }
            }
        }
    }
    
    private func updateWeatherDetails(_ weather: Weather?) {
        if let weather = weather {
            self.weatherMainLabel.text = weather.main
            self.weatherDescriptionLabel.text = weather.description
            self.weatherCoordinateLabel.text = "\(weather.coordinate.dms.latitude), \(weather.coordinate.dms.longitude)"
        } else {
            self.weatherMainLabel.text = "n/a"
            self.weatherDescriptionLabel.text = ""
            self.weatherCoordinateLabel.text = ""
        }
    }
    
    // MARK: UITableVIewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

}
