//
//  AccountService.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct AccountService: APIService, RequestService {
    
    static let shareInstance = AccountService()
    let accountUrl = url("/account")
    typealias NetworkData = TokenData
    
    func signIn(body: [String:String],completion: @escaping (Token) -> Void, error: @escaping (Int) -> Void) {
        let url = accountUrl + "/signin/app"
        
        postable(url, body: body, header: nil) { res in
            print("post")
            switch res {
            case .successWithData(let tokenData):
                print("successWithData")
                let token = tokenData.data
                completion(token)
            case .success(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}
