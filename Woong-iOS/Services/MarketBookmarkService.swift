//
//  MarketBookmarkService.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 20..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MarketBookmarkService: APIService, RequestService {
    static let shareInstance = MarketBookmarkService()
    let URL = url("")
    typealias NetworkData = MarketBookMarkData
    
    func getBookmarkFlag(marketId: Int, token: String, completion: @escaping (Int) -> Void, error: @escaping (Int) -> Void) {
        let bookmarkURL = URL + "/market/\(marketId)/bookmarkflag"
        let header: HTTPHeaders = [
            "usertoken" : token
        ]
        gettable(bookmarkURL, body: nil, header: header) { res in
            switch res {
            case .success(let chatRoomData):
                let data = chatRoomData.message
                completion(Int(data)!)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}
