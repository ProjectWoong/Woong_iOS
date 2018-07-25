//
//  ChatService.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 13..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct ChatRoomService: APIService, RequestService {
    static let shareInstance = ChatRoomService()
    let chatURL = url("/chat/room")
    typealias NetworkData = ChatRoomData
    
    func getRoomList(token: String, completion: @escaping ([ChatRoom]) -> Void, error: @escaping (Int) -> Void) {
        let header: HTTPHeaders = [
            "usertoken" : token
        ]
        gettable(chatURL, body: nil, header: header) { res in
            switch res {
            case .success(let chatRoomData):
                let data = chatRoomData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}

struct ChatRoomIdService: APIService, RequestService {
    static let shareInstance = ChatRoomIdService()
    let URL = url("/chat/room")
    typealias NetworkData = ChatRoomIdData
    
    func getRoomId(token: String, marketId: Int, completion: @escaping (ChatRoomId) -> Void, error: @escaping (Int) -> Void) {
        let chatIdURL = URL + "/\(marketId)"
        let header: HTTPHeaders = [
            "usertoken" : token
        ]
        gettable(chatIdURL, body: nil, header: header) { res in
            switch res {
            case .success(let chatRoomIdData):
                let data = chatRoomIdData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}

struct ChatMessageService: APIService, RequestService {
    static let shareInstance = ChatMessageService()
    let chatURL = url("/chat/message")
    typealias NetworkData = ChatData
    
    func getChatList(roomId: Int, token: String, completion: @escaping ([Chat]) -> Void, error: @escaping (Int) -> Void) {
        let url = chatURL + "/\(roomId)"
        let header: HTTPHeaders = [
            "usertoken" : token
        ]
        gettable(url, body: nil, header: header) { (res) in
            switch res {
            case .success(let chatListData):
                let data = chatListData.data.sendData
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
    func postChatList(body: [String:Any], token: String, completion: @escaping () -> Void, error: @escaping (Int) -> Void) {
        let header: HTTPHeaders = [
            "usertoken" : token
        ]
        postable(chatURL, body: body, header: header) { (res) in
            switch res {
            case .success(_):
                completion()
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
        
    }
}
