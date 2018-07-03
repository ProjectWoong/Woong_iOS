//
//  UIView+applyDesign.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 3..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

extension UIView {
    func applyShadow(radius: CGFloat, color: UIColor, offset: CGSize, opacity: Float) {
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
    }
    
    func applyRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
