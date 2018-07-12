//
//  ProductService.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct ProductService: APIService, RequestService {
    let URL = url("")
    static let shareInstance = ProductService()
    typealias NetworkData = ProductData
    
    // token -> 유저 토큰 / mainId -> 대 카테고리 id / subId -> 소 카테고리 id
    func getProductList(token: String, mainId: Int, subId: Int, completion: @escaping (ProductList) -> Void, error: @escaping (Int) -> Void) {
        let productURL = URL + "/category/main/\(mainId)/sub/\(subId)"
        let header: HTTPHeaders = [
            "usertoken" : token
        ]
        gettable(productURL, body: nil, header: header) { res in
            switch res {
            case .success(let productData):
                let data = productData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }

    func getSearchList(keyword: String, token: String, completion: @escaping (ProductList) -> Void, error: @escaping (Int) -> Void) {
        let searchURL = URL + "/item/search?keyword=\(keyword)"
        let header: HTTPHeaders = [
            "usertoken" : token
        ]
        gettable(searchURL, body: nil, header: header) { res in
            switch res {
            case .success(let productData):
                let data = productData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
