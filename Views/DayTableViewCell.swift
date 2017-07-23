//
//  DayTableViewCell.swift
//  WiproForecast
//
//  Created by Gabriel Panagiotidis on 22/07/2017.
//  Copyright © 2017 Gabriel Panagiotidis. All rights reserved.
//

import UIKit

class DayTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var weatherSamples: [WeatherData] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        let nibName = UINib(nibName: "WeatherSampleCollectionViewCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "WeatherSampleCollectionViewCell")
    }
    
    func setWeatherSamples(weatherSamples: [WeatherData]) {
        self.weatherSamples = weatherSamples
        collectionView.reloadData()
        
        if (weatherSamples.count > 0) {
            label.text = weatherSamples[0].dateString(format: "dd MMMM YYYY")
        }
    }
    
    
    /**
     UICollectionView
     */
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherSampleCollectionViewCell", for: indexPath) as! WeatherSampleCollectionViewCell
        
        let weatherData = weatherSamples[indexPath.row]
        cell.setWeatherData(weatherData: weatherData)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherSamples.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.bounds.height)
    }
}
