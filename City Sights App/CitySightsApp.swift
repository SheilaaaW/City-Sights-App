//
//  City_Sights_AppApp.swift
//  City Sights App
//
//  Created by Sheila Wang on 2021-07-30.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                    .environmentObject(ContentModel())
        }
    }
}
