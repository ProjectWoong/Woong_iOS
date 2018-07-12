//
//  ProductDetailVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {

    @IBOutlet weak var productNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func closeAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
