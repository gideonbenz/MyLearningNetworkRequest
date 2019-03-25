//
//  NetworkProcessor.swift
//  Alamofire-Weather
//
//  Created by Gideon Benz on 23/03/19.
//  Copyright © 2019 Duc Tran. All rights reserved.
//

import Foundation
import Moya

class NetworkProcessor {
    lazy var configuration : URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session : URLSession = URLSession(configuration: self.configuration)
    
    let url : URL
    
    init(url : URL) {
        self.url = url
    }
    
    let userProvider = MoyaProvider<UserService>()
    
    typealias JSONDictionary = (([String : Any]?) -> Void)
    
    func downloadJSONFromURL(_ completion: @escaping JSONDictionary) {
        let request = URLRequest(url: self.url)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200: if let data = data {
                            do {
                                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                
                                completion(jsonDictionary as? [String : Any])
                                
                            } catch let error as NSError {
                                print("Error processing json data: \(error.localizedDescription)")
                            }
                        }
                    default: print("HTTP Response Code: \(httpResponse.statusCode)")
                    }
                }
            } else { print("error: \(error?.localizedDescription)")}
        }
        dataTask.resume()
    }
    
    func downloadJSONWithMoya(_ completion: @escaping JSONDictionary) {
        
        userProvider.request(.readWeather()) { (currentWeather) in
            switch currentWeather {
            case.success(let currentWeather):
                do {
                    let jsonDictionary = try JSONSerialization.jsonObject(with: currentWeather.data, options: .mutableContainers)
//                    print(json)
                    completion(jsonDictionary as? [String : Any])
                } catch let error as NSError {
                    print("Failed Json Serialization \(error.localizedDescription)")
                }
                
            case.failure(let error):
                print("Error requesting Moya: \(error.localizedDescription)")
            }
        }
    }
}
