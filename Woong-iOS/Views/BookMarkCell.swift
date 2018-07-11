
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
    
    var like = true
    
    let likeImage = UIImage(named: "market-favorite-favorite")
    let unlikeImage = UIImage(named: "market-favorite-delete")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
