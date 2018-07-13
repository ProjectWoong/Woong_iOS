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
    let addressName, y, x: String
    
    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case y, x
    }
}
