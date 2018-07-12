//
//  LocationService.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct LocationService: APIService, RequestService {
    
    static let shareInstance = LocationService()
    let locationURL = url("/account/location")
    typealias NetworkData = LocationData
    
    func getLocation(token: String, completion: @escaping (Location) -> Void, error: @escaping (Int) -> Void) {
        let header: HTTPHeaders = [
            "usertoken" : token
        ]
        gettable(locationURL, body: nil, header: header) { res in
            switch res {
            case .success(let locationData):
                let data = locationData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
    func setLocation(body: [String:Any], token: String, completion: @escaping () -> Void, error: @escaping (Int) -> Void) {
        let header: HTTPHeaders = [
            "usertoken" : token
        ]
        Alamofire.request(locationURL, method: .put, parameters: body, encoding: JSONEncoding.default, headers: header).response { (res) in
            guard let code = res.response?.statusCode else { return }
            if code == 200 {
                completion()
            } else {
                error(code)
            }
        }
    }
    
    
}
