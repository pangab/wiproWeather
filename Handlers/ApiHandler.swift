//
//  ApiHandler.swift
//  WiproForecast
//
//  Created by Gabriel Panagiotidis on 22/07/2017.
//  Copyright © 2017 Gabriel Panagiotidis. All rights reserved.
//

import Foundation

class ApiHandler {
    
    /**
     Download weather forecast data
     */
    
    class func getForecast(_ completionHandler: @escaping (Int, Error?) -> Void) {
        
        let url = "http://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=8b20d689f1a2f61cf07b01fda738581f"
        
        HttpHandler.sendGetRequest(url: url) { (json, error) -> Void in
            
            if (error == nil && json != nil) {
                
                // The parsed data looks good; let's save it in the
                // session variable now
                let weatherSamples = ApiHandler.parseWeatherData(json: json!)
                
                State.sharedInstance.weatherSamples = weatherSamples
                
                completionHandler(200, nil)
                
            } else {
                completionHandler(-1, error)
            }
        }
        
    }
    
    class func parseWeatherData(json: Any) -> [WeatherData] {
        var weatherDataPoints: [WeatherData] = []
        
        if let dict = json as? NSDictionary {
            
            if let list = dict["list"] as? [[String:AnyObject]] {
                
                for a in list {
                    let weather = WeatherData()
                    
                    let main = a["main"] as? [String:AnyObject]
                    let weatherInfo = a["weather"] as? [[String:AnyObject]]
                    
                    weather.timestamp = a["dt"] as? Int
                    weather.temperature = main?["temp"] as? Float
                    
                    if (weatherInfo != nil && weatherInfo!.count > 0) {
                        weather.weatherMain = weatherInfo?[0]["description"] as? String
                        //weather.weatherMain = weatherInfo?[0]["main"] as? String
                        let baseString = "http://openweathermap.org/img/w/"
                        let absoluteString = weatherInfo?[0]["icon"] as? String
                        
                        weather.iconString = baseString + absoluteString! + ".png"
                    }
                    
                    weatherDataPoints.append(weather)
                }
            }
            
        }
        
        return weatherDataPoints
    }
    
}
