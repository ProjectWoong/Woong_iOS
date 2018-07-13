//
//  AccountData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct AccountData: Codable {
    var message: String
    var data: Token
}

struct Token: Codable {
    var token: String
    
    enum Codingkeys: String, CodingKey {
        case token = "token"
    }
}
