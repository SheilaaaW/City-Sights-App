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
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
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
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
        }
    }
    
    func getBusinesses(category: String, location: CLLocation){
        
        // create url
        /* let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(locations.coordinate.latitude)&longitude=\(location.coordinate.longitude)&catigories=\(category)&limit=6"
         let url = URL(string: urlString
         */
        var urlComponents = URLComponents(string: Constants.apiUrl)
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
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            // create data task
            let session = URLSession.shared
            
            // start data task
            let dataTask = session.dataTask(with: request) {(data, response, error) in
                
                // check no error
                
                if error == nil{
                    
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        // assign results to appropriate property
                        // dispatchQueue is used to move something away from background 
                        DispatchQueue.main.async {
                            
                            switch category {
                            case Constants.sightsKey:
                                self.sights = result.businesses
                            case Constants.restaurantsKey:
                                self.restaurants = result.businesses
                            default:
                                break // exit switch statement
                            }
                            /* what happened above is the same as
                             if category == Constants.sightsKey {
                                 self.sights = result.businesses
                             }
                             else if category == Constants.restaurantsKey {
                                 self.restaurants = result.businesses
                             }
                             */
                        }
                    }
                    catch {
                        print(error)
                    }
                }
            }
            // start data task
            dataTask.resume()
        }
        
    }
}
