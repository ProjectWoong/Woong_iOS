//
//  MarketCategoryCell.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 2..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class BigCategoryCell: UICollectionViewCell {
    
    @IBOutlet var bigCategoryLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            bigCategoryLabel.textColor = isSelected ? UIColor.rgb(red: 35, green: 122, blue: 89) : UIColor.rgb(red: 173, green: 173, blue: 173)
        }
    }
}
