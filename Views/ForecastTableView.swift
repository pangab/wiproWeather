//
//  ForecastTableView.swift
//  WiproForecast
//
//  Created by Gabriel Panagiotidis on 22/07/2017.
//  Copyright © 2017 Gabriel Panagiotidis. All rights reserved.
//

import UIKit

class ForecastTableView : UIView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl?
    
    var collection: [[WeatherData]] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        tableView.rowHeight = 256
        let nibName = UINib(nibName: "DayTableViewCell", bundle:nil)
        tableView.register(nibName, forCellReuseIdentifier: "DayTableViewCell")
        
        reloadData()
    }
    
    func reloadData() {
        refreshControl?.endRefreshing()
        collection = State.sharedInstance.groupedWeatherSamples()
        tableView.reloadData()
    }
    
    func initRefreshControl(viewController: ViewController) {
        if (refreshControl == nil) {
            refreshControl = UIRefreshControl()
            refreshControl?.addTarget(viewController, action: #selector(ViewController.tableViewRefreshRequested), for: UIControlEvents.valueChanged)
            tableView.addSubview(refreshControl!)
        }
    }
    /**
     UITableView
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.collection.count < 5 {
            return self.collection.count
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayTableViewCell", for: indexPath) as! DayTableViewCell
        
        let weatherSamples = collection[indexPath.row]
        cell.setWeatherSamples(weatherSamples: weatherSamples)
        
        return cell
    }
}
