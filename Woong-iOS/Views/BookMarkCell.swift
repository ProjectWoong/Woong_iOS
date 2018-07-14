
//
//  BookMarkCell.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 6..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class BookMarkCell: UITableViewCell {

    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var marketNameLabel: UILabel!
    @IBOutlet weak var marketAddressLabel: UILabel!
    @IBOutlet weak var marketImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
