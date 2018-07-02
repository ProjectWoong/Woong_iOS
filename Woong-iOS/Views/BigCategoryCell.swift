//
//  MarketCategoryCell.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 2..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class BigCategoryCell: UICollectionViewCell {
    
    @IBOutlet var categoryLabel: UILabel!
    
    override var isHighlighted: Bool {
        didSet {
            categoryLabel.textColor = isHighlighted ? UIColor.rgb(red: 35, green: 122, blue: 89) : UIColor.rgb(red: 173, green: 173, blue: 173)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            categoryLabel.textColor = isSelected ? UIColor.rgb(red: 35, green: 122, blue: 89) : UIColor.rgb(red: 173, green: 173, blue: 173)
        }
    }
}
