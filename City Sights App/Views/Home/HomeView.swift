//
//  HomeView.swift
//  City Sights App
//
//  Created by Sheila Wang on 2021-08-02.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    
    var body: some View {
        
        if model.restaurants.count != 0 || model.sights.count != 0 {
          
            NavigationView{
            if !isMapShowing {
                // show list
                VStack (alignment: .leading){
                    HStack{
                        Image(systemName: "location")
                        Text("Location")
                        Spacer()
                        Button(action: {
                            self.isMapShowing = true
                        }, label: {
                            Text("Switch To Map View")
                        })
                    }
                    Divider()
                    
                    BusinessList()
                }.padding([.horizontal, .top])
                .navigationBarHidden(true)
            }
            else{
                BusinessMap()
            }
            }
        }
        else {
            ProgressView()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
