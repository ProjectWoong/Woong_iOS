//
//  ResponseModel.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct ResponseData: Codable { //단순한 성공 메세지만 받을 경우의 모델
    var message: String
}
