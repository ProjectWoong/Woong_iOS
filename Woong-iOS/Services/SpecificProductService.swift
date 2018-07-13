//
//  SpecificProductService.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct SpecificProductService: APIService, RequestService {
    static let shareInstance = SpecificProductService()
    let productURL = url("/market")
    typealias NetworkData = SpecificProductData
    
    func getMarketProduct(marketId: Int, productId: Int, option: String, completion: @escaping (SpecificProduct) -> Void, error: @escaping (Int) -> Void) {
        let url = productURL + "/\(marketId)/item/\(productId))"
        gettable(url, body: nil, header: nil) { res in
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
