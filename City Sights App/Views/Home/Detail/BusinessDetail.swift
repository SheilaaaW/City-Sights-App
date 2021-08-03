//
//  BusinessDetail.swift
//  City Sights App
//
//  Created by Sheila Wang on 2021-08-03.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business: Business
    
    var body: some View {
        
        VStack (alignment: .leading){
            
            VStack (alignment: .leading, spacing: 0){
            GeometryReader() { geometry in
                let uiImage = UIImage (data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .scaledToFill()
            }
            .ignoresSafeArea()
            
            ZStack (alignment: .leading){
                Rectangle()
                    .foregroundColor(business.isClosed! ?.gray : .green)
                    .frame(height: 36)
                Text(business.isClosed! ? "Closed" : "Open")
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }
            .ignoresSafeArea()
        }
            Group {
            Text(business.name!)
            .font(.title)
                .padding(.top)
        
            // loop through display address
            if business.location?.displayAddress != nil {
                ForEach(business.location!.displayAddress!, id: \.self){ displayLine in
                    Text(displayLine)
                }
            }
            Image ("regular_\(business.rating ?? 0)")
                .padding(.bottom)
            }
            .padding(.horizontal)
            
        
        Divider()
            Group {
                
                HStack {
                    Text("Phone:")
                        .bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }
                Divider()
                
                HStack {
                    Text("Review:")
                        .bold()
                    Text("\(business.reviewCount ?? 0)")
                    Spacer()
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                }
                Divider()
                
                HStack {
                    Text("Website:")
                        .bold()
                    Text("\(business.url ?? "")")
                        .lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                }
                
                
           
        }
            .padding(.horizontal)
            .padding(.vertical, 5)
            
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                ZStack{
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(height: 48)
                    .cornerRadius(10)
                Text("Get Directions")
                    .foregroundColor(.white)
                }
                .padding()
        })
    }
}
}
