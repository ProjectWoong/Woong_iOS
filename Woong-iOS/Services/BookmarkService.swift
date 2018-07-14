//
//  BookMarkService.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct BookmarkListService: APIService, RequestService {
    
    static let shareInstance = BookmarkListService()
    let bookmarkURL = url("/bookmark")
    typealias NetworkData = BookmarkData
    
    func getCartList(token: String, completion: @escaping ([Bookmark]) -> Void, error: @escaping (Int) -> Void) {
        let header: HTTPHeaders = [
            "usertoken" : token
        ]
        gettable(bookmarkURL, body: nil, header: header) { res in
            switch res {
            case .success(let bookmarkList):
                let data = bookmarkList.data
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

struct BookmarkOperateService: APIService, RequestService {
    static let shareInstance = BookmarkOperateService()
    let bookmarkURL = url("/bookmark")
    typealias NetworkData = ResponseData
    
    func setBookmarkList(productId: Int, token: String, completion: @escaping (String) -> Void, error: @escaping (Int) -> Void) {
        let url = bookmarkURL + "/\(productId)"
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
    
    func deleteBookmarkList(productId: Int, token: String, completion: @escaping () -> Void, error: @escaping (Int) -> Void) {
        let url = bookmarkURL + "/\(productId)"
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
