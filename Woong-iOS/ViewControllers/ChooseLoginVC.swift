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

    @IBOutlet var logoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.modalAnimationType = .zoom
        logoImage.hero.id = "logo"
        sellerLoginButton.layer.masksToBounds = true
        sellerLoginButton.layer.cornerRadius = 24/667 * self.view.frame.height
        customerLoginButton.layer.masksToBounds = true
        customerLoginButton.layer.cornerRadius = 24/667 * self.view.frame.height
    
    }
    @IBAction func chooseLoginAction(_ sender: UIButton) {
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "SignInVC") as? SignInVC else { return }
        
        self.present(loginVC, animated: true, completion: nil)
        
    }
    
    

}
