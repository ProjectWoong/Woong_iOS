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
    static let shareInstance = KakaoAddressService()
    let kakaoURL = "https://dapi.kakao.com/v2/local/search/keyword.json"
    let header: HTTPHeaders = [
        "Authorization" : "KakaoAK 747ac2a1f874a6bd362d69d87635d1f8"
    ]
    typealias NetworkData = AddressData
    
    func searchAddressWithKeyword(query: String, completion: @escaping ([Address]) -> Void, error: @escaping (Int) -> Void) {
        //let url = kakaoURL + "?query=\(query)"
        let body = [
            "query": query
        ]
        Alamofire.request(kakaoURL, method: .get, parameters: body, encoding: JSONEncoding.default, headers: header).responseData { (res) in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let data = try decoder.decode(AddressData.self, from: value)
                        completion(data.documents)
                    } catch {
                        print("decoding err")
                    }
                }
            case .failure(let err):
                print(err)
                
            }
        }
    }
    
}
