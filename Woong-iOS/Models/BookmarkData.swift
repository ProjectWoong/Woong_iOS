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
    var bookmarkId: Int
    var marketId: Int
    var marketImage: String
    var marketName: String
    
    enum Codingkeys: String, CodingKey {
        case bookmarkId = "bookmark_id"
        case marketId = "market_id"
        case marketImage = "market_image"
        case marketName = "market_name"
    }
}
