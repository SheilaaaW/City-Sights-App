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
    // read and write value for the state property in homeview
    @Binding var selectedBusiness: Business?
    
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
        mapView.delegate = context.coordinator // we don;t need to create multiple coordinator objects
        // make the user show up on the map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
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
    
    // Mark - coordinator class
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var map: BusinessMap
        
        init(map: BusinessMap){
            self.map = map
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            // if annotation is the user blue dot, return nil
            if annotation is MKUserLocation {
                return nil
            }
            
            // Check if there is a reusable annotation view first
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationReuseId)
            
            if annotationView == nil {
            
            // create annotation view and return it
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationReuseId)
            
                annotationView!.canShowCallout = true
            // this part enables the i button to apprear
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            else {
                // we got a reusable one
                annotationView!.annotation = annotation
            }
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            // loop through business in the model and find match
            for business in map.model.restaurants + map.model.sights{
                if business.name == view.annotation?.title{
                    // change binding and iinitiate chain of events
                    map.selectedBusiness = business
                    return
                }
            }
        }
    }
}
