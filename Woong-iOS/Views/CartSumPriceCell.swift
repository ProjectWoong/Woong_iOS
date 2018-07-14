//
//  CartSumPriceCell.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 14..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class CartSumPriceCell: UITableViewCell {

    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var deliveryPriceLabel: UILabel!
    @IBOutlet weak var sumPriceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
