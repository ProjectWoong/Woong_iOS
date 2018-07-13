//
//  MarketIntroData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct MarketIntroData: Codable {
    let message: String
    let data: MarketIntro
}

struct MarketIntro: Codable {
    let marketID: Int
    
    let marketName, tagName: String
    let delivery, quick: Int
    let titleImageKey, farmerImageKey, marketInfo: String
    let youandi: String
    
    enum CodingKeys: String, CodingKey {
        case marketID = "market_id"
        case marketName = "market_name"
        case tagName = "tag_name"
        case delivery, quick
        case titleImageKey = "title_image_key"
        case farmerImageKey = "farmer_image_key"
        case marketInfo = "market_info"
        case youandi
    }
}
