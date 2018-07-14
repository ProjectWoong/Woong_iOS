//
//  FavoriteService.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct FavoriteListService: APIService, RequestService {
    
    static let shareInstance = FavoriteListService()
    let favoriteURL = url("/favorite")
    typealias NetworkData = FavoriteData
    
    func getCartList(token: String, completion: @escaping (FavoriteList) -> Void, error: @escaping (Int) -> Void) {
        let header: HTTPHeaders = [
            "usertoken" : token
        ]
        gettable(favoriteURL, body: nil, header: header) { res in
            switch res {
            case .success(let favoriteList):
                let data = favoriteList.data
                completion(data)
            case .successWithNil(_):
                //데이터가 없음
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}

struct FavoriteOperateService: APIService, RequestService {
    static let shareInstance = FavoriteOperateService()
    let favoriteURL = url("/favorite")
    typealias NetworkData = ResponseData
    
    func setFavoriteList(productId: Int, token: String, completion: @escaping (String) -> Void, error: @escaping (Int) -> Void) {
        let url = favoriteURL + "/\(productId)"
        let header: HTTPHeaders = [
            "usertoken" : token
        ]
        postable(url, body: nil, header: header) { res in
            switch res {
            case .success(let data):
                let message = data.message
                completion(message)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
    func deleteFavoriteList(productId: Int, token: String, completion: @escaping () -> Void, error: @escaping (Int) -> Void) {
        let url = favoriteURL + "/\(productId)"
        let header: HTTPHeaders = [
            "usertoken" : token
        ]
        Alamofire.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: header).response { res in
            guard let code = res.response?.statusCode else { return }
            if code == 200 {
                completion()
            } else {
                error(code)
            }
        }
        
    }
}
