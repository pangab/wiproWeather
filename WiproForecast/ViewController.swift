//
//  ViewController.swift
//  WiproForecast
//
//  Created by Gabriel Panagiotidis on 22/07/2017.
//  Copyright © 2017 Gabriel Panagiotidis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var forecastTableView: ForecastTableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setup the container
        forecastTableView = Bundle.main.loadNibNamed("ForecastTableView", owner: nil, options: nil)?[0] as? ForecastTableView
        self.view.addSubview(forecastTableView!)
        forecastTableView!.frame = self.view.bounds
        
        // To initialise the pull-down-to-refresh from here
        forecastTableView!.initRefreshControl(viewController: self)
        
        downloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func downloadData() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // Download the data from OpenWeatherMap
        ApiHandler.getForecast { (status, error) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if (error == nil) {
                self.forecastTableView?.reloadData()
                
            } else {
                
                // If there's an error, let's display the message here
                let alert = UIAlertController()
                alert.title = "Check your API Key & Network!"
                alert.message = error?.localizedDescription
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                    alert.dismiss(animated: true, completion: nil)
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    func tableViewRefreshRequested() {
        downloadData()
    }
}

