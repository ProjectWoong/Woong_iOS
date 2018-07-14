
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
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var marketAndProductLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var chekButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var value = 1 {
        didSet {
            valueLabel.text = "\(value)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        leftButton.addTarget(self, action: #selector(leftButtonTouchDown(button:)), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTouchDown(button:)), for: .touchUpInside)
        rightButton.layer.masksToBounds = true
        rightButton.layer.cornerRadius = 3
        rightButton.layer.borderColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        rightButton.layer.borderWidth = 1
        leftButton.layer.masksToBounds = true
        leftButton.layer.cornerRadius = 3
        leftButton.layer.borderColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        leftButton.layer.borderWidth = 1
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    @objc func leftButtonTouchDown(button: UIButton) {
        print("left")
        if value == 1 {
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
