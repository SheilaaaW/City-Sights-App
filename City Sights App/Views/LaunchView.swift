//
//  ContentView.swift
//  City Sights App
//
//  Created by Sheila Wang on 2021-07-30.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        // detect authorization
        if model.authorizationState == .notDetermined{
            
        }
        // if undetermined, show onboarding
        else if model.authorizationState == .authorizedAlways || model.authorizationState == .authorizedWhenInUse {
            HomeView()
        }
        // if approved, show home view
        else {
            DeniedView()
        }
        // if denied, show denied view
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
