//
//  LocationData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct LocationData: Codable {
    let message: String
    let data: Location
}

struct Location: Codable {
    let location: String
    
    enum Codingkeys: String, CodingKey {
        case location = "real_address"
    }
}
