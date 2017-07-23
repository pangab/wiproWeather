//
//  HttpHandler.swift
//  WiproForecast
//
//  Created by Gabriel Panagiotidis on 22/07/2017.
//  Copyright © 2017 Gabriel Panagiotidis. All rights reserved.
//

import Alamofire

class HttpHandler {
    
    static var sharedAlamofireManager: Alamofire.SessionManager?
    
    class func alamofireManager() -> Alamofire.SessionManager {
        if (sharedAlamofireManager != nil) {
            return sharedAlamofireManager!
        }
        
        sharedAlamofireManager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default
        )
        
        return sharedAlamofireManager!
    }
    
    
    /**
     * Simple Async GET request; expects JSON to be returned
     */
    class func sendGetRequest(url: String, completionHandler: @escaping (Any?, Error?) -> Void) {
        HttpHandler.alamofireManager().request(url, method: .get, parameters: nil, headers: nil).response { (response) in
            
            // If there is a response, let's try to parse it as JSON
            if (response.data != nil) {
                do {
                    let data = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    completionHandler(data, nil)
                } catch {
                    completionHandler(nil, error)
                }
                
            } else {
                let code = response.response?.statusCode == nil ? -1 : response.response!.statusCode
                let error = NSError(domain: "world", code: code, userInfo: [NSLocalizedDescriptionKey : "\(code)"])
                completionHandler(nil, error)
            }
        }
    }
    
}
