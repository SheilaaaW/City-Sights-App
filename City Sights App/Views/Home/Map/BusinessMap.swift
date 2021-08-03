//
//  BusinessMapView.swift
//  City Sights App
//
//  Created by Sheila Wang on 2021-08-03.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    var locations: [MKAnnotation]{
        //create a set of annotations from list of business
        var annotations = [MKAnnotation]()
        for business in model.restaurants + model.sights {
            
            // if the business has a lat/long, create an mk annotation
            
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                let a = MKPointAnnotation()
            a.coordinate = CLLocationCoordinate2D (latitude: lat, longitude: long)
            a.title = business.name ?? ""
                
                annotations.append(a)
        }
        }
        return annotations
    }
    
    func makeUIView (context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        // make the user show up on the map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        // TODO: set the region
        return mapView
    }
    func updateUIView (_ uiView: MKMapView, context: Context) {
        // UI view will change as we chage data, remove all annotations so we don't perpetually add them
        uiView.removeAnnotations(uiView.annotations)
        // add ones based on the business
        uiView.showAnnotations(self.locations, animated: true)
    }
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        
        uiView.removeAnnotations(uiView.annotations)
    }
}
