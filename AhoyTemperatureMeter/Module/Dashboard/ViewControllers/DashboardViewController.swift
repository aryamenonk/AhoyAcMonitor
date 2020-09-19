//
//  ViewController.swift
//  DashboardViewController
//
//  Created by sajeev Raj on 19/09/2020.
//  Copyright © 2020 NewsApp. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var outdoorTemperatureLabel: UILabel!
    @IBOutlet weak var indoorTemperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scanForBeacon()
        fetchWeatherInfo()
    }
    
    func scanForBeacon() {
        iBeaconManager.shared.scanForBeacons { (beacons, error) in
            if error != nil {
                AlertController.show(error: error)
                print(error?.localizedDescription ?? "")
            } else if let beacons = beacons{
                print(beacons)
            }
        }
    }
    
    func fetchWeatherInfo() {
        WeatherService.getDetails(place: "London") { [weak self] (response) in
            switch response {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    self?.outdoorTemperatureLabel.text = "\(data.info.first?.main.temp.description ?? "") C"
                }
            case .failure(let error):
                AlertController.show(error: error)
            case .finally: break
            }
        }
    }
}
