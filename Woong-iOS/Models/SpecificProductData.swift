//
//  SpecificProductData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct SpecificProductData: Codable {
    let message: String
    let data: SpecificProduct
}

struct SpecificProduct: Codable {
    let marketName, fileKey, productName, productInfo: String
    let productCook, productMaintain: String
    let packaging: String
    let productManufacture, productExpiration, productRelated, productProducer: String
    
    enum CodingKeys: String, CodingKey {
        case marketName = "market_name"
        case fileKey = "file_key"
        case productName = "item_name"
        case productInfo = "item_info"
        case productCook = "item_cook"
        case productMaintain = "item_maintain"
        case packaging
        case productManufacture = "item_manufacture"
        case productExpiration = "item_expiration"
        case productRelated = "item_related"
        case productProducer = "item_producer"
    }
}
