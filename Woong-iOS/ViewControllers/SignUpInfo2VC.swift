//
//  SignUpInfo2VC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 8..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class SignUpInfo2VC: UIViewController {
    
    @IBOutlet var emailTxtFd: UITextField!
    @IBOutlet var passwordTxtFd: UITextField!
    @IBOutlet var phoneTxtFd: UITextField!
    @IBOutlet var nextButton: UIButton!
    
    var user_name = ""
    var birth = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        initGestureRecognizer()
        nextButton.applyRadius(radius: nextButton.frame.height/2)
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        
        if emailTxtFd.text == "" || passwordTxtFd.text == "" || phoneTxtFd.text == "" {
               simpleAlert(title: "모든 항목을 입력해주세요!", message: "")
        } else {
            let signupVC = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(withIdentifier: "SignUpAllergicVC") as! SignUpAllergicVC
            
            signupVC.user_name = user_name
            signupVC.birth = birth
            signupVC.email = emailTxtFd.text!
            signupVC.password = passwordTxtFd.text!
            signupVC.phone_number = phoneTxtFd.text!
            
            self.present(signupVC, animated: true, completion: nil)
        }
        
    }
}

extension SignUpInfo2VC: UIGestureRecognizerDelegate {
    func initGestureRecognizer() {
        let mainTap = UITapGestureRecognizer(target: self, action: #selector(handleTabMainView(_:)))
        mainTap.delegate = self
        view.addGestureRecognizer(mainTap)
    }
    
    @objc func handleTabMainView(_ sender: UITapGestureRecognizer){
        self.emailTxtFd.resignFirstResponder()
        self.passwordTxtFd.resignFirstResponder()
        self.phoneTxtFd.resignFirstResponder()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: emailTxtFd))! || (touch.view?.isDescendant(of: passwordTxtFd))! || (touch.view?.isDescendant(of: phoneTxtFd))! {
            return false
        }
        return true
    }
    
}
