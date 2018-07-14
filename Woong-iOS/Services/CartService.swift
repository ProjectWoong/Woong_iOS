//
//  CartService.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CartListService: APIService, RequestService {
    
    static let shareInstance = CartListService()
    let cartURL = url("/cart")
    typealias NetworkData = CartData
    
    func getCartList(token: String, completion: @escaping ([Cart]) -> Void, error: @escaping (Int) -> Void) {
        let header: HTTPHeaders = [
            "usertoken" : token
        ]
        gettable(cartURL, body: nil, header: header) { res in
            switch res {
            case .success(let cartList):
                let data = cartList.data
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

struct CartOperateService: APIService, RequestService {
    static let shareInstance = CartOperateService()
    let cartURL = url("/cart")
    typealias NetworkData = ResponseData
    
    func setCartList(productId: Int, token: String, completion: @escaping (String) -> Void, error: @escaping (Int) -> Void) {
        let url = cartURL + "/\(productId)"
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
    
    func deleteCartList(productId: Int, token: String, completion: @escaping () -> Void, error: @escaping (Int) -> Void) {
        let url = cartURL + "/\(productId)"
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
