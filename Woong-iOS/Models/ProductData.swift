//
//  CategoryData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct ProductData: Codable {
    let message: String
    let data: ProductList
}

struct ProductList: Codable {
    let itemInfo: [Product]
    
    enum CodingKeys: String, CodingKey {
        case itemInfo = "item_info"
    }
}

struct Product: Codable {
    let itemID, marketID, mainID, subID: Int
    let itemName, marketName, itemUnit: String
    let itemPrice, quick, delivery: Int
    let userID: JSONNull?
    let fileKey: String
    let favoriteFlag: Int
    
    enum CodingKeys: String, CodingKey {
        case itemID = "item_id"
        case marketID = "market_id"
        case mainID = "main_id"
        case subID = "sub_id"
        case itemName = "item_name"
        case marketName = "market_name"
        case itemUnit = "item_unit"
        case itemPrice = "item_price"
        case quick, delivery
        case userID = "user_id"
        case fileKey = "file_key"
        case favoriteFlag = "favorite_flag"
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
