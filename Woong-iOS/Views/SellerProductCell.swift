//
//  SellerProductCell.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 6..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class SellerProductCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        self.applyShadow(radius: 4, color: UIColor.darkGray, offset: CGSize(width: 0, height: 4), opacity: 0.5)
        self.clipsToBounds = false
    }
}
