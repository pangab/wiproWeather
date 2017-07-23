//
//  WeatherSampleCollectionViewCell.swift
//  WiproForecast
//
//  Created by Gabriel Panagiotidis on 22/07/2017.
//  Copyright © 2017 Gabriel Panagiotidis. All rights reserved.
//

import UIKit
import Kingfisher

class WeatherSampleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var weatherData: WeatherData?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setWeatherData(weatherData: WeatherData) {
        self.weatherData = weatherData
        
        mainLabel.text = weatherData.weatherMain
        
        if (weatherData.temperatureInCelsius() != nil) {
            temperatureLabel.text = "\(weatherData.temperatureInCelsius()!) °C"
        }
        
        hourLabel.text = weatherData.dateString(format: "HH:mm")
        
        let url = URL(string: weatherData.iconString!)
        imageView.kf.setImage(with: url)
    }

}
