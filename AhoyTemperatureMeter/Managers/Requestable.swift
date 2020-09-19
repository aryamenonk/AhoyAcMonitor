//
//  Requestable.swift
//  WeatherApp
//
//  Created by sajeev Raj on 21/08/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import Foundation

// protocol for parameters and path
protocol Requestable {
    
    var path: String { get }
    var queryParameters: [String: String] { get }
    var method: HTTPMethod { get }
    func request<T: Codable>(completion: ServiceResponseBlock<T>?)
}

extension Requestable {
    
    var defaultParameters: [String: String] {
        return ["APPID": Configuration.current.apiKey]
    }
    
    func request<T: Codable>(completion: ServiceResponseBlock<T>?) {
        
        guard var components = URLComponents(string: ServiceManager.API.baseUrl?.appendingPathComponent(path).absoluteString ?? "") else { return }
        
        let totalQueryParameters = queryParameters.merge(dictionary: defaultParameters)
        let urlQueryItems = totalQueryParameters.map{ return URLQueryItem(name: $0.0, value: $0.1) }
        components.queryItems = urlQueryItems
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        ServiceManager.shared.request(request: request, completion: completion)
    }
}

extension Dictionary {
    func merge(dictionary: Dictionary<Key,Value>) -> Dictionary<Key,Value> {
        var copy = self
        for (key, value) in dictionary {
            copy[key] = value
        }
        return copy
    }
}

