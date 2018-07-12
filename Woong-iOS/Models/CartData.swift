//
//  CartData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct CartData: Codable {
    var message: String
    var data: CartList
}

struct CartList: Codable {
    var cart: Cart
    
    enum CodingKeys: String, CodingKey {
        case cart = "cart_item"
    }
}
struct Cart: Codable {
    var productImage: String
    var marketName: String
    var productName: String
    var productPrice: Int
    var productUnit: String
    var delivery: Int
    
    enum Codingkeys: String, CodingKey {
        case productImage = "item_image"
        case marketName = "market_name"
        case productName = "item_name"
        case productPrice = "item_price"
        case productUnit = "item_unit"
        case delivery = "delivery_free"
    }
}
