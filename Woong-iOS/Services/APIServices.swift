//
//  APIServices.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 1..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

protocol APIService {
}

extension APIService {
    static func url(_ path: String) -> String {
        return "http://13.125.190.134:3000" + path
    }
}
