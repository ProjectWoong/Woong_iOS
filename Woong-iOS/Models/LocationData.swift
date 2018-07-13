//
//  SampleData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 13..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct LocationData: Codable {
    let message: String
    let data: Location
}

struct Location: Codable {
    let realAddress: String
    
    enum CodingKeys: String, CodingKey {
        case realAddress = "real_address"
    }
}
