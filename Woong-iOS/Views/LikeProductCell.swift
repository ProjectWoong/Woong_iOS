//
//  LikeProductCell.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 2..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class LikeProductCell: UICollectionViewCell {
    
    @IBOutlet weak var marketNameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var cartImageView: UIButton!
    @IBOutlet weak var heartImageView: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var hashTag1Label: UILabel!
    @IBOutlet weak var hashTag2Label: UILabel!
    
    override func awakeFromNib() {
        self.layer.masksToBounds = false
        self.applyShadow(radius: 10, color: .black, offset: CGSize(width: 0, height: 10), opacity: 0.1)
    }
}
