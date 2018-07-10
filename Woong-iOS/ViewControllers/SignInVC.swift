//
//  SignInVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 7..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet var idView: UIView!
    @IBOutlet var passwordView: UIView!
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idView.layer.masksToBounds = true
        idView.layer.cornerRadius = 24/667 * self.view.frame.height
        idView.layer.borderWidth = 1
        idView.layer.borderColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
        
        passwordView.layer.masksToBounds = true
        passwordView.layer.cornerRadius = 24/667 * self.view.frame.height
        passwordView.layer.borderWidth = 1
        passwordView.layer.borderColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
        
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 24/667 * self.view.frame.height
        
        setupTextField()
        
    }
    
    private func setupTextField() {
        idTextField.delegate = self
        passwordTextField.delegate = self
        let tapDidsmiss = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapDidsmiss)
    }
    
    
    @IBAction func singInAction(_ sender: UIButton) {
        let signupVC = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(withIdentifier: "SignupAgreeVC")
        
        self.present(signupVC, animated: true, completion: nil)
        
    }
    
    
    
}


extension SignInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @objc func dismissKeyboard() {
        idTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}
