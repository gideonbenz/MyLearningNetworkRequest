//
//  ForcecastService.swift
//  Alamofire-Weather
//
//  Created by Gideon Benz on 18/03/19.
//  Copyright © 2019 Duc Tran. All rights reserved.
//

import Foundation
import Alamofire
import Moya

class ForecastService {
    // Sample url https://api.darksky.net/forecast/4054fdbd759f1f98339a975ea66cf407/37.8267,-122.4233
    
    let forecastAPIKey: String
    let forecastBaseUrl: URL?
    let coordinate : (lat: Double, long: Double) = (37.8267,-122.4233)
    
    init() {
        forecastAPIKey = "068630c69a624897c61dd081e2180525"
        forecastBaseUrl = URL(string: "https://api.darksky.net/forecast/\(forecastAPIKey)")
    }
    
    typealias dictionary = [String : Any]
    
    //With Alamofire [DONE]
    func getCurrentWeather(completion: @escaping (CurrentWeather?) -> Void) {
        if let forecastURL = URL(string: "\(forecastBaseUrl!)/\(self.coordinate.lat),\(self.coordinate.long)") {
            Alamofire.request(forecastURL).responseJSON { (response) in
                if let jsonDictionary = response.result.value as? dictionary {
                    if let currentWeatherDictionary = jsonDictionary["currently"] as? [String : Any] {
                        let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
                        completion(currentWeather)
                    } else {completion(nil)}
                }
            }
        }
    }
    
    //With Normal Request [DONE]
    func getForecastService(completion: @escaping (CurrentWeather?) -> Void) {
        if let forecastURL = URL(string: "\(forecastBaseUrl!)/\(self.coordinate.lat),\(self.coordinate.long)") {
            
            let networkProcessor = NetworkProcessor(url: forecastURL)
            networkProcessor.downloadJSONFromURL { (jsonDictionary) in
                if let currentWeatherDictionary = jsonDictionary?["currently"] as? dictionary {
                    let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
                    completion(currentWeather)
                } else {completion(nil)}
            }
        }
    }
    
    //With Moya Request [DONE]
    func getMoyaForecastService(completion: @escaping (CurrentWeather?) -> Void) {
        if let forecastURL = URL(string: "\(forecastBaseUrl!)/\(self.coordinate.lat),\(self.coordinate.long)") {
            
            let networkProcessor = NetworkProcessor(url: forecastURL)
            networkProcessor.downloadJSONWithMoya { (jsonDictionary) in
                if let currentWeatherDictionary = jsonDictionary?["currently"] as? dictionary {
                    let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
                    completion(currentWeather)
                } else {completion(nil)}
            }
        }
    }
}

let id = "068630c69a624897c61dd081e2180525"
let latitude = 37.8267
let longitude = -122.4233

enum UserService {
    case readWeather()
}

extension UserService : TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.darksky.net/forecast")!
    }
    
    var path: String {
        switch self {
        case .readWeather() :
            return "/\(id)/\(latitude),\(longitude)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .readWeather():
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .readWeather():
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .readWeather():
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
    
}
