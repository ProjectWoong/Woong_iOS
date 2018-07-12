//
//  MarketReviewData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct MarketReviewData: Codable {
    let message: String
    let rate: MarketReview
}

struct MarketReview: Codable {
    let rateSpeed, rateTaste, rateFresh, rateKindness: Int
    let images: [Image]
    let reviews: [Review]
    
    enum CodingKeys: String, CodingKey {
        case rateSpeed = "rate_speed"
        case rateTaste = "rate_taste"
        case rateFresh = "rate_fresh"
        case rateKindness = "rate_kindness"
        case images, reviews
    }
}

struct Image: Codable {
    let fileKey: String
    
    enum CodingKeys: String, CodingKey {
        case fileKey = "file_key"
    }
}

struct Review: Codable {
    let userName, content: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case content
    }
}
