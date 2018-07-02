//
//  PaymentVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 2..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class PaymentVC: UIViewController {

    @IBOutlet weak var shadowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shadowView.isHidden = true
    }

    
    @IBAction func payAction(_ sender: UIButton) {
        shadowView.isHidden = false
    }
    
    @IBAction func okAction(_ sender: UIButton) {
        shadowView.isHidden = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
