//
//  ChatRoomData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 13..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct ChatRoomData: Codable {
    let message: String
    let data: [ChatRoom]
}

struct ChatRoom: Codable {
    let farmerImage, marketName: String
    let chattingRoomID, marketID, unreadCount: Int
    let recentMessage, intervalTime: String
    
    enum CodingKeys: String, CodingKey {
        case farmerImage = "farmer_image"
        case marketName = "market_name"
        case chattingRoomID = "chatting_room_id"
        case marketID = "market_id"
        case unreadCount = "unread_count"
        case recentMessage = "recent_message"
        case intervalTime = "interval_time"
    }
}
