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
    
    static let shareInstance = AccountService()
    let accountUrl = url("/account")
    typealias NetworkData = LocationData
    
    func getLocation(token: String, completion: @escaping (Location) -> Void, error: @escaping (Int) -> Void) {
        let url = accountUrl + "/location"
        let header: HTTPHeaders = [
            "usertoken" : token
        ]
        gettable(url, body: nil, header: header) { res in
            switch res {
            case .successWithData(let locationData):
                let location = locationData.data
                completion(location)
            case .success(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
    
}
