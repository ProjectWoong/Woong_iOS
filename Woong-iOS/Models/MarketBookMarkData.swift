//
//  MarketBookMarkData.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 20..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct MarketBookMarkData: Codable {
    let message: String
    let data: DataClass1
}

struct DataClass1: Codable {
}
