//
//  ReadMessageCell.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 10..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class ReadMessageCell: UITableViewCell {
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
