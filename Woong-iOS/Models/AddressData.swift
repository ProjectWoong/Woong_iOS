//
//  AddressData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 13..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct AddressData: Codable {
    let documents: [Address]
}

struct Address: Codable {
    let placeName, addressName, roadAddressName, x: String
    let y: String
    
    enum CodingKeys: String, CodingKey {
        case placeName = "place_name"
        case addressName = "address_name"
        case roadAddressName = "road_address_name"
        case x, y
    }
}
