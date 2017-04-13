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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let datasource = datasource {
            let title = "\(datasource.locationCoordinate)"
            self.title = title
            
            let locationCoordinate = datasource.locationCoordinate!
            let weatherService = WeatherService()
            weatherService.fetchWeather(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude, completion: { (result) in
                print("here")
            })
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
