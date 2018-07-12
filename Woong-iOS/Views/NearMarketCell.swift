//
//  NearMarketCell.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 6..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class NearMarketCell: UITableViewCell {
    
    
    @IBOutlet var hashTagLabel1: UILabel!
    @IBOutlet var hashTagLabel2: UILabel!
    
    @IBOutlet var hashTagView1: UIView!
    @IBOutlet var hashTagView2: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hashTagLabel1.text = "#자고싶어요"
        hashTagLabel1.sizeToFit()
        hashTagLabel2.text = "#앱잼의늪"
        hashTagLabel2.sizeToFit()
        hashTagView1.applyRadius(radius: hashTagView1.frame.height/2)
        hashTagView2.applyRadius(radius: hashTagView2.frame.height/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
