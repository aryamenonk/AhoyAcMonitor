//
//  Configuration.swift
//  WeatherApp
//
//  Created by sajeev Raj on 21/08/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import Foundation

class Configuration {
    
    // the current singleton configuration
    static let current = Configuration()
    
    // all configurations
    private var all = [String: Any]()
    
    private init() {
        
        // load all configurations
        all = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? [String: Any] ?? [:]
    }
        
    var baseUrl: String {
        return all["baseUrl"] as? String ?? ""
    }
    
    var apiKey: String {
        return all["apiKey"] as? String ?? ""
    }
}
