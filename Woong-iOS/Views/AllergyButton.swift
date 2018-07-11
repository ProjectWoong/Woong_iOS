//
//  AllergyButton.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 11..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class AllergyButton: UIButton {
    var selectCheck: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.layer.opacity = self.selectCheck ? 0.5 : 1
                self.transform = self.selectCheck ? CGAffineTransform(scaleX: 1.1, y: 1.1) : CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
    
}
