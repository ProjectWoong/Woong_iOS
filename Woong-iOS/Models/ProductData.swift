//
//  CategoryData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct ProductData: Codable {
    var message: String
    var data: ProductList
}

struct ProductList: Codable {
    var productList: [Product]
    
    enum CodingKeys: String, CodingKey {
        case productList = "item_info"
    }
}

struct Product: Codable {
    var productId: Int
    var marketId: Int
    var mainId: Int
    var subId: Int
    var marketName: String
    var productImage: String
    var productName: String
    var productUnit: String
    var productPrice: Int
    var quick: Bool
    var delivery: Bool
    var favorite: Bool
    
    enum Codingkeys: String, CodingKey {
        case productId = "item_id"
        case marketId = "market_id"
        case mainId = "main_id"
        case subId = "sub_id"
        case marketName = "market_name"
        case productImage = "item_image"
        case productName = "item_name"
        case productUnit = "item_unit"
        case productPrice = "item_price"
        case quick = "quick"
        case delivery = "delivery"
        case favorite = "favorite_flag"
    }
}
