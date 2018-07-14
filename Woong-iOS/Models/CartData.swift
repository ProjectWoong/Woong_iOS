//
//  CartData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct CartData: Codable {
    let message: String
    let data: [Cart]
}

struct Cart: Codable {
    let marketID, itemID: Int
    let carttitle, fileKey, packging: String
    let itemPrice: Int
    let itemUnit: String
    let delivery: Int
    
    enum CodingKeys: String, CodingKey {
        case marketID = "market_id"
        case itemID = "item_id"
        case carttitle
        case fileKey = "file_key"
        case packging
        case itemPrice = "item_price"
        case itemUnit = "item_unit"
        case delivery
    }
}
