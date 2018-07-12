//
//  LocationData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct LocationData: Codable {
    var message: String
    var data: Location
}

struct Location: Codable {
    var location: String
    
    enum Codingkeys: String, CodingKey {
        case location = "user_address"
    }
}
