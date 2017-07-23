//
//  WeatherData.swift
//  WiproForecast
//
//  Created by Gabriel Panagiotidis on 22/07/2017.
//  Copyright © 2017 Gabriel Panagiotidis. All rights reserved.
//

import Foundation

class WeatherData {
    var timestamp: Int?
    var temperature: Float?
    var weatherMain: String?
    var iconString: String?
    
    func temperatureInCelsius() -> Float? {
        if (temperature == nil) {
            return nil
        }
        return round(temperature! - 273.15)
    }
    
    func date() -> Date? {
        if (timestamp == nil) {
            return nil
        }
        let ti = TimeInterval(timestamp!)
        return Date(timeIntervalSince1970: ti)
    }
    
    func dateString(format: String) -> String {
        if let date = date() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: date)
        }
        return ""
    }
}
