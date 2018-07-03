//
//  MyProductCategoryCell.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 2..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class MyProductCategoryCell: UICollectionViewCell {
    
    @IBOutlet var categoryLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            categoryLabel.textColor = isSelected ? UIColor.rgb(red: 35, green: 122, blue: 89) : UIColor.rgb(red: 173, green: 173, blue: 173)
            
        }
    }
}
