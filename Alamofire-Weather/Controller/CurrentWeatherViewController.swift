//
//  CurrentWeatherViewController.swift
//  Alamofire-Weather
//
//  Created by Gideon Benz on 21/03/19.
//  Copyright © 2019 Duc Tran. All rights reserved.
//

import UIKit

class CurrentWeatherViewController: UIViewController {
    @IBOutlet weak var cityTextLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureScaleLabel: UILabel!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    let forecastAPIKey = "068630c69a624897c61dd081e2180525"
    let coordinate : (lat: Double, long: Double) = (37.8267,-122.4233)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        
//     Request with normal Network Request
//        forecastService.getForecastService(latitude: coordinate.lat, longitude: coordinate.long) { (currentWeather) in
//                if let currentWeather = currentWeather {
//                    DispatchQueue.main.async {
//                        if let temperature = currentWeather.temperature {
//                            self.temperatureLabel.text = "\(Int(temperature))°"
//                             print("your temperature is \(temperature)")
//                        } else{self.temperatureLabel.text = "--"}
//                        if let humidity = currentWeather.humidity {
//                            print("your humidity \(humidity)")
//                        } else {print("your humidity nil")}
//                }
//            }
//        }
        
        forecastService.getCurrentWeather(latitude: coordinate.lat, longitude: coordinate.long) { (currentWeather) in
            if let currentWeather = currentWeather {
                DispatchQueue.main.async {
                    if let temperature = currentWeather.temperature {
                        self.temperatureLabel.text = "\(Int(temperature))°"
                    } else {self.temperatureLabel.text = "--" }
                }
            }
        }
    }

}
