//
//  MarketAlbumData.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation

struct MarketAlbumListData: Codable {
    let message: String
    let data: [MarketAlbum]
}

struct MarketAlbum: Codable {
    let albumID: Int
    let albumTitle, fileKey, createTime: String
    
    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case albumTitle = "album_title"
        case fileKey = "file_key"
        case createTime = "cr_dt"
    }
}
