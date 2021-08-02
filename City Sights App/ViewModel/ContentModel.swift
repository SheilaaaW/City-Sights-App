//
//  File.swift
//  City Sights App
//
//  Created by Sheila Wang on 2021-07-30.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
    
    override init() {
        // Init method of NSObject
        super.init()
        // Set content model as the delegate of the location manager
        locationManager.delegate = self
        
        // Request permission from user
        locationManager.requestWhenInUseAuthorization()
        
    }
    // location manager delegate methods
    
    func locationManagerDidChangeAuthorization (_ manager: CLLocationManager ){
        
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            // we have permission
            locationManager.startUpdatingLocation()
        }
        else if locationManager.authorizationStatus == .denied{
            // no permission
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // give us location of the user
        let userLocation = locations.first
        
        
        //TODO: if we have the coordinate, send to YELP API
        if userLocation != nil {
            
            // We have a location
            // Stop requestion the location after we get it once
            locationManager.stopUpdatingLocation()
            
            getBusinesses(category: "restaurants", location: userLocation!)
        }
    }
    
    func getBusinesses(category: String, location: CLLocation){
        
        // create url
        /* let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(locations.coordinate.latitude)&longitude=\(location.coordinate.longitude)&catigories=\(category)&limit=6"
         let url = URL(string: urlString
         */
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
            
        ]
        let url = urlComponents?.url
        
        // if not nil
        if let url = url {
            
            // create url request ( time out = how long to wait for the data)
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer qAnWzeyimteMs59BYiQE92adsAboNWsYa0U3gf-cbD2Y7RFEvYp1AjNqOX7gX67mFmc2yhpombzzWLjO-YKilW1juKAhpbFDm5Yu_0WcCYenDZzzXgZoE6wxeIAEYXYx", forHTTPHeaderField: "Authorization")
            // create data task
            let session = URLSession.shared
            
            // start data task
            let dataTask = session.dataTask(with: request) {(data, response, error) in
                
                // check no error
                
                if error == nil{
                    print(response)
                }
            }
            // start data task
            dataTask.resume()
        }
        
    }
}
