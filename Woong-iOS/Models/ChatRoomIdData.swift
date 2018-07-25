//
//  ChatRoomIdData.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 19..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct ChatRoomIdData: Codable {
    let message: String
    let data: ChatRoomId
}

struct ChatRoomId: Codable {
    let chattingRoomID: Int
    
    enum CodingKeys: String, CodingKey {
        case chattingRoomID = "chatting_room_id"
    }
}
