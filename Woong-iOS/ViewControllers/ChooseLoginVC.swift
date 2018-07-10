//
//  ChooseLoginVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 7..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class ChooseLoginVC: UIViewController {

    @IBOutlet var sellerLoginButton: UIButton!
    @IBOutlet var customerLoginButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        sellerLoginButton.layer.masksToBounds = true
        sellerLoginButton.layer.cornerRadius = 24/667 * self.view.frame.height
        customerLoginButton.layer.masksToBounds = true
        customerLoginButton.layer.cornerRadius = 24/667 * self.view.frame.height
    
    }
    @IBAction func chooseLoginAction(_ sender: UIButton) {
        let loginVC = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(withIdentifier: "SignInVC")
        
        self.present(loginVC, animated: true, completion: nil)
        
    }
    
    

}
