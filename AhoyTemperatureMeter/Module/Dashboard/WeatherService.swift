//
//  WeatherService.swift
//  AhoyTemperatureMeter
//
//  Created by sajeev Raj on 19/09/2020.
//  Copyright © 2020 NewsApp. All rights reserved.
//

import Foundation


class WeatherService {
    
    // get weather information
    static func getDetails(place: String, completion: ((ServiceResponse<Weather>) -> Void)?) {
        Router.forecast(place: place).request { (response: ServiceResponse<Weather>) in
            completion?(response)
        }
    }
    
    enum Router: Requestable {
        case forecast(place: String)
        
        var path: String {
            switch self {
            case .forecast:
                return "forecast"
            }
        }
        
        var queryParameters: [String : String] {
            switch self {
            case .forecast(let place):
                return ["units": "metric", "q": place]
            }
        }
        
        var method: HTTPMethod {
            .get
        }
    }
}
