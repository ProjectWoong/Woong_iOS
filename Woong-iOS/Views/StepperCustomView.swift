//
//  StepperCustomView.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 3..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class StepperCustomView: UIView {

    let leftButton = UIButton()
    let rightButton = UIButton()
    let label = UILabel()
    private var value = 0 {
        didSet {
            label.text = "\(value)"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        print("init")
        leftButton.setTitle("-", for: .normal)
        leftButton.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        leftButton.layer.masksToBounds = true
        leftButton.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        leftButton.layer.borderWidth = 0.1
        leftButton.titleLabel?.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        addSubview(leftButton)
        
        rightButton.setTitle("+", for: .normal)
        rightButton.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        rightButton.layer.masksToBounds = true
        rightButton.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        rightButton.layer.borderWidth = 0.1
        rightButton.titleLabel?.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        addSubview(rightButton)
        
        label.text = "0"
        label.textAlignment = .center
        addSubview(label)
        
        leftButton.addTarget(self, action: #selector(leftButtonTouchDown(button:)), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(rightButtonTouchDown(button:)) , for: .touchUpInside)

    }
    
    override func layoutSubviews() {
        let labelWidthWeight: CGFloat = 0.5
        
        let buttonWidth = bounds.size.width * ((1 - labelWidthWeight) / 2)
        let labelWidth = bounds.size.width * labelWidthWeight
        
        leftButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: bounds.size.height)
        
        label.frame = CGRect(x: buttonWidth, y: 0, width: labelWidth, height: bounds.size.height)
        
        rightButton.frame = CGRect(x: labelWidth + buttonWidth, y: 0, width: buttonWidth, height: bounds.size.height)
    }
    
    // MARK: Button Event Actions
    @objc func leftButtonTouchDown(button: UIButton) {
        print("left")
        value -= 1
    }
    
    @objc func rightButtonTouchDown(button: UIButton) {
        print("right")
        value += 1
    }
//
//    func buttonTouchUp(button: UIButton) {
//        slideLabelToOriginalPosition()
//    }

    
}
