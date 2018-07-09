//
//  SignUpInfo1VC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 8..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class SignUpInfo1VC: UIViewController {

    @IBOutlet var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.masksToBounds = true
        nextButton.layer.cornerRadius = 24
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        let signupVC = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(withIdentifier: "SignUpInfo2VC")
        
        self.present(signupVC, animated: true, completion: nil)
    }

}
