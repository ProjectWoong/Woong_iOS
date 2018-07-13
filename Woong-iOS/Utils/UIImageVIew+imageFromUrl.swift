//
//  UIImageVIew+imageFromUrl.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 14..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    public func imageFromUrl(_ urlString: String?, defaultImgPath : String) {
        let defaultImg = UIImage(named: defaultImgPath)
        if let url = urlString {
            if url.isEmpty {
                self.image = defaultImg
            } else {
                self.kf.setImage(with: URL(string: url), placeholder: defaultImg, options: [.transition(ImageTransition.fade(0.5))])
            }
        } else {
            self.image = defaultImg
        }
    }
}
