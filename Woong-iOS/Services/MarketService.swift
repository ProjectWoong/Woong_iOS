//
//  MarketService.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct NearMarketService: APIService, RequestService {
    static let shareInstance = NearMarketService()
    let marketURL = url("/market")
    typealias NetworkData = NearMarketData
    
    func getNearMarket(token: String, completion: @escaping ([NearMarket]) -> Void, error: @escaping (Int) -> Void) {
        let url = marketURL + "/distance"
        let header: HTTPHeaders = [
            "usertoken" : token
        ]
        gettable(url, body: nil, header: header) { res in
            switch res {
            case .success(let nearMarketData):
                let data = nearMarketData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}

struct MarketIntroService: APIService, RequestService {
    static let shareInstance = MarketIntroService()
    let marketURL = url("/market")
    typealias NetworkData = MarketIntroData
    
    func getMarketIntro(index: Int, token: String, completion: @escaping (MarketIntro) -> Void, error: @escaping (Int) -> Void) {
        let url = marketURL + "/info/\(index)"
        let header: HTTPHeaders = [
            "usertoken" : token
        ]
        gettable(url, body: nil, header: header) { res in
            switch res {
            case .success(let introData):
                let data = introData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}

struct MarketProductService: APIService, RequestService {
    static let shareInstance = MarketProductService()
    let marketURL = url("/market")
    typealias NetworkData = MarketProductListData
    
    func getMarketProduct(index: Int, option: String, completion: @escaping ([MarketProduct]) -> Void, error: @escaping (Int) -> Void) {
        let url = marketURL + "/\(index)?option=\(option)"
        gettable(url, body: nil, header: nil) { res in
            switch res {
            case .success(let productListData):
                let data = productListData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}

struct MarketAlbumService: APIService, RequestService {
    static let shareInstance = MarketAlbumService()
    let marketURL = url("/market")
    typealias NetworkData = MarketAlbumListData
    
    func getMarketAlbum(index: Int, completion: @escaping ([MarketAlbum]) -> Void, error: @escaping (Int) -> Void) {
        let url = marketURL + "/\(index)/album"
        gettable(url, body: nil, header: nil) { res in
            switch res {
            case .success(let albumListData):
                let data = albumListData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}

struct MarketReviewService: APIService, RequestService {
    static let shareInstance = MarketReviewService()
    let marketURL = url("/market")
    typealias NetworkData = MarketReviewData
    
    func getMarketReview(index: Int, completion: @escaping (MarketReview) -> Void, error: @escaping (Int) -> Void) {
        let url = marketURL + "/\(index)/review"
        gettable(url, body: nil, header: nil) { res in
            switch res {
            case .success(let reviewData):
                let data = reviewData.rate
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}

