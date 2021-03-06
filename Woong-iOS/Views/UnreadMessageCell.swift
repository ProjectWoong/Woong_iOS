//
//  UnreadMessageCell.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 10..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class UnreadMessageCell: UITableViewCell {

    var chattingRoomId: Int = 0
    @IBOutlet weak var marketNameLabel: UILabel!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var messageCountLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.messageImageView.layer.masksToBounds = true
        self.messageImageView.layer.cornerRadius = 45/2
        self.messageCountLabel.layer.masksToBounds = true
        self.messageCountLabel.layer.cornerRadius = 12.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
