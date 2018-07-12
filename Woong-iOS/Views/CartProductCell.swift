
//
//  CartProductCell.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 3..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

protocol StepperDelegate{
    func didLeftButtonPressed()
    func didRightButtonPressed()
}

class CartProductCell: UITableViewCell {
    
    var delegate: StepperDelegate? = nil
    
    @IBOutlet var stepperView: StepperCustomView!
    
    private var value = 0 {
        didSet {
            stepperView.label.text = "\(value)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stepperView.leftButton.addTarget(self, action: #selector(leftButtonTouchDown(button:)), for: .touchUpInside)
        stepperView.rightButton.addTarget(self, action: #selector(rightButtonTouchDown(button:)), for: .touchUpInside)
//        stepperView.leftButton.addTarget(self, action: #selector(handleLeftButton), for: .touchUpInside)
//        stepperView.rightButton.addTarget(self, action: #selector(handleRightButton), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func handleLeftButton() {
        if self.delegate != nil {
            self.delegate?.didLeftButtonPressed()
        }
    }
    
    @objc func handleRightButton() {
        if self.delegate != nil {
            self.delegate?.didRightButtonPressed()
        }
    }
    

    @objc func leftButtonTouchDown(button: UIButton) {
        print("left")
        if value == 0 {
            return
        } else {
            value -= 1
        }
    }
    
    @objc func rightButtonTouchDown(button: UIButton) {
        print("right")
        value += 1
    }
}
