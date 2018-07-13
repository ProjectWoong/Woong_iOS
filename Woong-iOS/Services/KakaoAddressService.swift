//
//  KakaoAddressService.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 13..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct KakaoAddressService: APIService, RequestService {
    static let shareInstance = MarketProductService()
    let kakaoURL = "https://dapi.kakao.com/v2/local/search/keyword.json"
    let header: HTTPHeaders = [
        "Authorization" : "KakaoAK 747ac2a1f874a6bd362d69d87635d1f8"
    ]
    typealias NetworkData = AddressData
    
    func searchAddressWithKeyword(query: String, completion: @escaping ([Address]) -> Void, error: @escaping (Int) -> Void) {
        let url = kakaoURL + "?query=\(query)"
        gettable(url, body: nil, header: header) { res in
            switch res {
            case .success(let addressData):
                let data = addressData.documents
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
