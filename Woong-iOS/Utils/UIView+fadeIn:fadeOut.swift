
//
//  UIView+fadeIn:fadeOut.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 8..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    enum FadeType: TimeInterval {
        case
        Normal = 0.5,
        Slow = 1.0
    }
    
    func fadeIn(type: FadeType = .Normal, completed: (() -> ())? = nil) {
        fadeIn(duration: type.rawValue, completed: completed)
    }
    
    /** For typical purpose, use "public func fadeIn(type: FadeType = .Normal, completed: (() -> ())? = nil)" instead of this */
    func fadeIn(duration: TimeInterval = FadeType.Slow.rawValue, completed: (() -> ())? = nil) {
        alpha = 0
        isHidden = false
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }) { finished in
            completed?()
        }
    }
    func fadeOut(type: FadeType = .Normal, completed: (() -> ())? = nil) {
        fadeOut(duration: type.rawValue, completed: completed)
    }
    /** For typical purpose, use "public func fadeOut(type: FadeType = .Normal, completed: (() -> ())? = nil)" instead of this */
    func fadeOut(duration: TimeInterval = FadeType.Slow.rawValue, completed: (() -> ())? = nil) {
        UIView.animate(withDuration: duration
            , animations: {
                self.alpha = 0
        }) { [weak self] finished in
            self?.isHidden = true
            self?.alpha = 1
            completed?()
        }
    }
}
