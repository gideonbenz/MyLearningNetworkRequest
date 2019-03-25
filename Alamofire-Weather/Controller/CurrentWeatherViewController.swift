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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let forecastService = ForecastService()
        
//     Request with normal Network Request
//        forecastService.getForecastService() { (currentWeather) in
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
        
//      Request with Alamofire Request
//        forecastService.getCurrentWeather() { (currentWeather) in
//            if let currentWeather = currentWeather {
//                DispatchQueue.main.async {
//                    if let temperature = currentWeather.temperature {
//                        self.temperatureLabel.text = "\(Int(temperature))°"
//                    } else {self.temperatureLabel.text = "--"}
//                }
//            }
//        }
        
//      Request with Moya -> Alamofire Request
        forecastService.getMoyaForecastService { (currentWeather) in
            if let currentWeather = currentWeather {
                DispatchQueue.main.async {
                    if let temperature = currentWeather.temperature {
                        self.temperatureLabel.text = "\(Int(temperature))°"
                    } else {self.temperatureLabel.text = "--"}
                }
            }
        }
    }
}
