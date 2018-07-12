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

struct SignInOutService: APIService, RequestService {
    
    static let shareInstance = SignInOutService()
    let accountUrl = url("/account")
    typealias NetworkData = AccountData
    
    func signIn(body: [String:String],completion: @escaping (Token) -> Void, error: @escaping (Int) -> Void) {
        let url = accountUrl + "/signin/app"
        
        postable(url, body: body, header: nil) { res in
            print("post")
            switch res {
            case .success(let accountData):
                print("successWithData")
                if let data = accountData.data {
                    completion(data)
                }
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
    func signOut(header: HTTPHeaders, completion: @escaping (ResponseData?) -> Void, error: @escaping (Int) -> Void) {
        let url = accountUrl + "/singout"
        Alamofire.request(url, method: .put, parameters: nil, encoding: JSONEncoding.default, headers: header).response { (res) in
            guard let code = res.response?.statusCode else { return }
            if code == 200 {
                completion(nil)
            } else {
                error(code)
            }
        }
    }
}

struct SignUpService: APIService, RequestService {
    static let shareInstance = SignUpService()
    let accountUrl = url("/account")
    typealias NetworkData = ResponseData
    
    func signUp(body: [String:Any], completion: @escaping (String) -> Void, error: @escaping (Int) -> Void) {
        let url = accountUrl + "/singup"
        
        postable(url, body: body, header: nil) { res in
            switch res {
            case .success(let responseData):
                let message = responseData.message
                completion(message)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
    
    
    
}
