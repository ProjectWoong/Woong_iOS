//
//  NearMarketData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct NearMarketData: Codable {
    let message: String
    let data: [NearMarket]
}

struct NearMarket: Codable {
    let marketID: Int
    let marketName, marketAddress, titleImageKey, tagName: String
    let youandi: String
    
    enum CodingKeys: String, CodingKey {
        case marketID = "market_id"
        case marketName = "market_name"
        case marketAddress = "market_address"
        case titleImageKey = "title_image_key"
        case tagName = "tag_name"
        case youandi
    }
}
