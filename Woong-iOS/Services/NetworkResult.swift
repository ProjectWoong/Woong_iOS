//
//  NetworkResult.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

enum NetworkResult<T> {
    case successWithData(T)
    case success(Int)
    case error(Int)
}
