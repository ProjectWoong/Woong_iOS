//
//  SellerMenuCell.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 3..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class SellerMenuCell: UICollectionViewCell {
    
    @IBOutlet var menuLabel: UILabel!
    
    private var selectedColor: UIColor = UIColor.white
    private var deselectedColor: UIColor = UIColor.white
    
    override var isSelected: Bool {
        didSet {
            menuLabel.textColor = isSelected ? selectedColor : deselectedColor
        }
    }
    
    func setSelectedColor(_ color: UIColor) {
        self.selectedColor = color
    }
    func setDeselectedColor(_ color: UIColor) {
        self.deselectedColor = color
    }
}
