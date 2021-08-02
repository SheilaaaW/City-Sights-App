//
//  BusinessSearch.swift
//  City Sights App
//
//  Created by Sheila Wang on 2021-08-02.
//

import Foundation

struct BusinessSearch: Decodable {
    
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    var center = Coordinate()
}

