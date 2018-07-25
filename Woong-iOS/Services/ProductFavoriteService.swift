//
//  ProductFavoriteService.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 20..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct ProductFavoriteService: APIService, RequestService {
    static let shareInstance = ProductFavoriteService()
    let URL = url("")
    typealias NetworkData = FavoriteData
    
    func getFavoriteFlag(productId: Int, token: String, completion: @escaping (Int) -> Void, error: @escaping (Int) -> Void) {
        let bookmarkURL = URL + "/market/\(productId)/favoriteflag"
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
