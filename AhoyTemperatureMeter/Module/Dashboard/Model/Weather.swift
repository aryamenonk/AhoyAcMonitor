//
//  Weather.swift
//  AhoyTemperatureMeter
//
//  Created by sajeev Raj on 19/09/2020.
//  Copyright © 2020 NewsApp. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let message, cnt: Int
    let info: [WeatherInformation]
    let city: City
    
    enum CodingKeys: String, CodingKey {
        case message, cnt, city
        case info = "list"
    }
}

struct WeatherInformation: Codable {
    let main: MainDetails
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case date = "dt_txt"
    }
}

// MainClass
struct MainDetails: Codable {
    let temp: Double
    let feelsLike: Double

    let humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case temp, humidity
        case feelsLike = "feels_like"
    }
}
