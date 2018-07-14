//
//  SignInVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 7..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet var logoImage: UIImageView!
    
    @IBOutlet var idView: UIView!
    @IBOutlet var passwordView: UIView!
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTextField()
        initGestureRecognizer()
    }
    
    private func setupView() {
        self.hero.modalAnimationType = .fade
        logoImage.hero.id = "logo"
        loginButton.isEnabled = false
        idTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(isValid), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        idView.applyRadius(radius: 24/667 * self.view.frame.height)
        idView.applyBorder(width: 1, color: #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1))
        passwordView.applyRadius(radius: 24/667 * self.view.frame.height)
        passwordView.applyBorder(width: 1, color: #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1))
        loginButton.applyRadius(radius: 24/667 * self.view.frame.height)
    }
    
    private func setupTextField() {
        idTextField.delegate = self
        passwordTextField.delegate = self
        let tapDidsmiss = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapDidsmiss)
    }
    
    @objc func isValid() {
        if !((idTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!) {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
    
    @objc func signIn() {
        let body = [
            "email" : gsno(idTextField.text),
            "password" : gsno(passwordTextField.text)
        ]

        SignInOutService.shareInstance.signIn(body: body, completion: { (token) in
            self.ud.set(token.token, forKey: "token")
            // self.simpleAlert(title: "로그인성공", message: "")
            
            let destvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainRootTabBarController") as! MainRootTabBarController
            //destvc.hero.tabBarAnimationType = .zoom
            self.present(destvc, animated: false, completion: nil)

        }) { (errCode) in
            if errCode == 403 || errCode == 401 {
                self.simpleAlert(title: "로그인 오류", message: "아이디나 비밀번호가 일치하지 않습니다.")
            } else {
                self.simpleAlert(title: "네트워크 오류", message: "서버가 응답하지 않습니다.")
            }
        }
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
