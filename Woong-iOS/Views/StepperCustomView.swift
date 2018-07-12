//
//  StepperCustomView.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 3..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class StepperCustomView: UIView {

    let leftButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("-", for: .normal)
        //btn.backgroundColor = UIColor.rgb(red: 82, green: 156, blue: 119)
        btn.layer.masksToBounds = true
        btn.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btn.layer.borderWidth = 0.1
        btn.setTitleColor(#colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1), for: .normal)
        return btn
    }()
    let rightButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("+", for: .normal)
       // btn.backgroundColor = UIColor.rgb(red: 82, green: 156, blue: 119)
        btn.layer.masksToBounds = true
        btn.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btn.layer.borderWidth = 0.1
        btn.setTitleColor(#colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1), for: .normal)
        return btn
    }()
    let label : UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "NanumSquareOTF", size: 15)
        return lbl
    }()
    
//    private var value = 0 {
//        didSet {
//            label.text = "\(value)"
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(label)
        
//        leftButton.addTarget(self, action: #selector(leftButtonTouchDown(button:)), for: .touchUpInside)
//        leftButton.addTarget(self, action: #selector(rightButtonTouchDown(button:)) , for: .touchUpInside)

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
//    @objc func leftButtonTouchDown(button: UIButton) {
//        print("left")
//        value -= 1
//    }
//
//    @objc func rightButtonTouchDown(button: UIButton) {
//        print("right")
//        value += 1
//    }
//
//    func buttonTouchUp(button: UIButton) {
//        slideLabelToOriginalPosition()
//    }

    
}
