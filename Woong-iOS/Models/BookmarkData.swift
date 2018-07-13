//
//  BookmarkData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct BookmarkData: Codable {
    var message: String
    var data: [Bookmark]
}

struct Bookmark: Codable {
    var marketId: Int
    var marketName: String
    var marketAddress: String
    var titleImageKey: String
    
    enum Codingkeys: String, CodingKey {
        case marketId = "market_id"
        case marketName = "market_name"
        case marketAddress = "market_address"
        case titleImageKey = "title_image_key"
    }
}
