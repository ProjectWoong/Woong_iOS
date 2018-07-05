//
//  UIViewController+Extesion.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 4..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func simpleAlert(title: String, message: String, okCompletion: ((UIAlertAction) -> Void)?, cancelCompletion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okCompletion)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: cancelCompletion)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}
