//
//  State.swift
//  WiproForecast
//
//  Created by Gabriel Panagiotidis on 22/07/2017.
//  Copyright © 2017 Gabriel Panagiotidis. All rights reserved.
//

import Foundation

class State {
    
    static let sharedInstance = State()
    
    var weatherSamples: [WeatherData]?
    
    // This function is to group the samples by their date
    func groupedWeatherSamples() -> [[WeatherData]] {
        
        if (weatherSamples == nil || weatherSamples!.count < 1) {
            return [[]]
        }
        
        // Helper variable to map the samples by their date
        var dict: [String:[WeatherData]] = [:]
        
        for ws in weatherSamples! {
            let dateKey = ws.dateString(format: "YYYYMMdd")
            if (dict[dateKey] == nil || dict[dateKey]!.count < 1) {
                dict[dateKey] = []
            }
            dict[dateKey]?.append(ws)
        }
        
        var retval: [[WeatherData]] = []
        
        let sortedKeys = Array(dict.keys).sorted()
        for key in sortedKeys {
            retval.append(dict[key]!)
        }
        
        return retval
    }
    
}
