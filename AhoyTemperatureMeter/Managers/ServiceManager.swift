//
//  ServiceManager.swift
//  WeatherApp
//
//  Created by sajeev Raj on 21/08/2020.
//  Copyright © 2020 WeatherApp. All rights reserved.
//

import Foundation

protocol ViewModalResponseModel {}

enum ServiceResponse<T: Codable> {
    case success(data: T)
    case failure(error: Error)
    case finally
}

typealias ServiceResponseBlock<T: Codable> = (ServiceResponse<T>) -> ()

class ServiceManager {
    
    static let shared = ServiceManager()
            
    var dataTask: URLSessionDataTask?

    private init() {}
    
    func request<T>(request: URLRequest, completion: ServiceResponseBlock<T>?) where T: Codable {
    
        URLSession.shared.dataTask(with: request) { (data, response, error) in

            if let error = error {
                completion?(.failure(error: error))
                completion?(.finally)
                return
            }
            guard let _ = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                completion?(.failure(error: error))
                completion?(.finally)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(T.self, from: data)
                completion?(.success(data: responseData))
                completion?(.finally)
                
            } catch let error {
                print("Error", error)
                completion?(.failure(error: error))
                completion?(.finally)

            }
        }.resume()
    }
    
    func requestData<T>(fileName: String, completion: ServiceResponseBlock<T>?) where T: Codable {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(T.self, from: data)
            completion?(.success(data: response))
            completion?(.finally)
        }
        catch (let error){
            completion?(.failure(error: error))
            completion?(.finally)
        }
        
    }
}

extension ServiceManager {
    struct API {
        static var baseUrl: URL? {
            return URL(string: Configuration.current.baseUrl)
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
