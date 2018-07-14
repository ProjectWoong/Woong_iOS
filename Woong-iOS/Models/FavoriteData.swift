//
//  FavoriteData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct FavoriteData: Codable {
    let message: String
    let data: FavoriteList
}

struct FavoriteList: Codable {
    let favoriteInfo: [Favorite]
    enum CodingKeys: String, CodingKey {
        case favoriteInfo = "favorite_info"
    }
}

struct Favorite: Codable {
    let productId, marketId, mainId, subId: Int
    let marketName, productName, productUnit: String
    let productPrice, quick, delivery, userId: Int
    let productImage: String
    let favorite: Int
    
    enum CodingKeys: String, CodingKey {
        case productId = "item_id"
        case marketId = "market_id"
        case mainId = "main_id"
        case subId = "sub_id"
        case marketName = "market_name"
        case productName = "item_name"
        case productUnit = "item_unit"
        case productPrice = "item_price"
        case quick, delivery
        case userId = "user_id"
        case productImage = "file_key"
        case favorite = "favorite_flag"
    }
}
