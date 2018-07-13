//
//  ChatData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 13..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct ChatData: Codable {
    let message: String
    let data: ChatList
}

struct ChatList: Codable {
    let sendData: [Chat]
    
    enum CodingKeys: String, CodingKey {
        case sendData = "send_data"
    }
}

struct Chat: Codable {
    let sendUserID: Int
    let content, date: String
    
    enum CodingKeys: String, CodingKey {
        case sendUserID = "send_user_id"
        case content, date
    }
}
