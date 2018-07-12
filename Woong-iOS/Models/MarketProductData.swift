//
//  MarketProductData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct MarketProductListData: Codable {
    let message: String
    let data: [MarketProduct]
}

struct MarketProduct: Codable {
    let marketID, productID: Int
    let marketName, productName, fileKey, packaging: String
    let quick, delivery: Int
    
    enum CodingKeys: String, CodingKey {
        case marketID = "market_id"
        case productID = "item_id"
        case marketName = "market_name"
        case productName = "item_name"
        case fileKey = "file_key"
        case packaging, quick, delivery
    }
}
