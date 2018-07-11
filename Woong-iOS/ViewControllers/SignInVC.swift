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
        
        idView.applyRadius(radius: 24/667 * self.view.frame.height)
        idView.appltBorder(width: 1, color: #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1))
        
        passwordView.applyRadius(radius: 24/667 * self.view.frame.height)
        passwordView.appltBorder(width: 1, color: #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1))
        
        loginButton.applyRadius(radius: 24/667 * self.view.frame.height)
        initGestureRecognizer()
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
    
    @IBAction func unwindToSignIn(_ sender: UIStoryboardSegue) {
        
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

extension SignInVC: UIGestureRecognizerDelegate {
    func initGestureRecognizer() {
        let mainTap = UITapGestureRecognizer(target: self, action: #selector(handleTabMainView(_:)))
        mainTap.delegate = self
        view.addGestureRecognizer(mainTap)
    }
    
    @objc func handleTabMainView(_ sender: UITapGestureRecognizer){
        self.idTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: idTextField))! || (touch.view?.isDescendant(of: passwordTextField))! {
            return false
        }
        return true
    }
}
