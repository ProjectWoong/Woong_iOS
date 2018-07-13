//
//  SellerIntroCell.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 6..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class SellerIntroCell: UICollectionViewCell {
    @IBOutlet weak var sellerimageView: UIImageView!
    @IBOutlet weak var hashTag1Label: UILabel!
    @IBOutlet weak var hashTag2Label: UILabel!
    @IBOutlet weak var helloMessageLabel: UILabel!
    @IBOutlet weak var hash1View: UIView!
    @IBOutlet weak var hash2View: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hash1View.layer.masksToBounds = true
        hash1View.layer.cornerRadius = 12
        hash2View.layer.masksToBounds = true
        hash2View.layer.cornerRadius = 12
    }
    
}
