//
//  CurrentWeather.swift
//  Alamofire-Weather
//
//  Created by Gideon Benz on 18/03/19.
//  Copyright © 2019 Duc Tran. All rights reserved.
//

import Foundation

class CurrentWeather {
    let temperature: Int?
    let humidity: Int?
    let precipProbability: Int?
    let summary : String?
    let icon : String?
    
    struct WeatherKeys {
        static let temperature = "temperature"
        static let humidity = "humidity"
        static let precipProbability = "precipProbability"
        static let summary = "summary"
        static let icon = "icon"
    }
    
    init(weatherDictionary: [String : Any]) {
        if let temperatureDouble = weatherDictionary[WeatherKeys.temperature] as? Double {
            temperature = Int(temperatureDouble)
        } else {temperature = nil}
        
        if let humidityDouble = weatherDictionary[WeatherKeys.humidity] as? Double {
            humidity = Int(humidityDouble * 100)
        } else {humidity = nil}
        
        if let precipProbabilityDouble = weatherDictionary[WeatherKeys.precipProbability] as? Double {
            precipProbability = Int (precipProbabilityDouble * 100)
        } else {precipProbability = nil}
        
        
        summary = weatherDictionary[WeatherKeys.summary] as? String
        icon = weatherDictionary[WeatherKeys.icon] as? String
    }
}
