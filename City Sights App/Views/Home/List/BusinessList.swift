//
//  BusinessList.swift
//  City Sights App
//
//  Created by Sheila Wang on 2021-08-02.
//

import SwiftUI

struct BusinessList: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        ScrollView (showsIndicators: false){
            LazyVStack (alignment: .leading, pinnedViews: [.sectionHeaders]){
                // if the data does not comply to identifiable we would need an id -- change business model to identifiable
                BusinessSection(title: "Restaurants", businesses: model.restaurants)
                
                    Divider ()
                
                BusinessSection(title: "Sights", businesses: model.sights)
                
                }
            
                }
                
            
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
    }
}
