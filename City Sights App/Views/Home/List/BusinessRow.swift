//
//  BusinessRow.swift
//  City Sights App
//
//  Created by Sheila Wang on 2021-08-03.
//

import SwiftUI

struct BusinessRow: View {
    //pick up the change from teh updated image url
    @ObservedObject var business: Business
    var body: some View {
        
        VStack{
            
            HStack{
                //Image
                let uiImage = UIImage (data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: 58, height: 58)
                    .cornerRadius(5)
                    .scaledToFit()
                // Name & distance
                VStack (alignment: .leading){
                    Text (business.name ?? "")
                        .bold()
                    
                    Text(String(format: "%.1f km away", (business.distance ?? 0)/1000 ))
                            .font(.caption)
                }
                
                Spacer ()
                
                // Star rating & review
                VStack (alignment: .leading){
                    Image ("regular_\(business.rating ?? 0)")
                    Text("\(business.reviewCount ?? 0) Review")
                        .font(.caption)
                }
            }
            Divider ()
        }
    }
}
