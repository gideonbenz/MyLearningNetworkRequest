//
//  ForcecastService.swift
//  Alamofire-Weather
//
//  Created by Gideon Benz on 18/03/19.
//  Copyright © 2019 Duc Tran. All rights reserved.
//

import Foundation
import Alamofire

class ForecastService {
    // Sample url https://api.darksky.net/forecast/4054fdbd759f1f98339a975ea66cf407/37.8267,-122.4233
    
    let forecastAPIKey: String
    let forecastBaseUrl: URL?
    
    init(APIKey: String) {
        self.forecastAPIKey = APIKey
        forecastBaseUrl = URL(string: "https://api.darksky.net/forecast/\(APIKey)")
    }
    
    func getCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (CurrentWeather?) -> Void) {
        if let forecastURL = URL(string: "\(forecastBaseUrl!)/\(latitude),\(longitude)") {
            Alamofire.request(forecastURL).responseJSON { (response) in
                print(response)
                print("***")
                print(response.result)
                if let jsonDictionary = response.result.value as? [String : Any] {
                    if let currentWeatherDictionary = jsonDictionary["currently"] as? [String : Any] {
                        let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
                        completion(currentWeather)
                    } else {completion(nil)}
                }
            }
        }
    }
    
    func getForecastService(latitude: Double, longitude: Double, completion: @escaping (CurrentWeather?) -> Void) {
        if let forecastURL = URL(string: "\(forecastBaseUrl!)/\(latitude),\(longitude)") {
            
            let networkProcessor = NetworkProcessor(url: forecastURL)
            networkProcessor.downloadJSONFromURL { (jsonDictionary) in
                if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String : Any] {
                    let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
                    completion(currentWeather)
                } else {completion(nil)}
            }
        }
    }
    
    
    
}
