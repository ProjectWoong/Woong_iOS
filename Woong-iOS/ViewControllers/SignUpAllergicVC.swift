//
//  SignUpAllergicVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 8..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class SignUpAllergicVC: UIViewController {
    
    @IBOutlet var buckWheatBtn: AllergyButton!
    @IBOutlet var wheatBtn: AllergyButton!
    @IBOutlet var peachBtn: AllergyButton!
    @IBOutlet var soyBtn: AllergyButton!
    @IBOutlet var nutsBtn: AllergyButton!
    @IBOutlet var tomatoBtn: AllergyButton!
    @IBOutlet var eggBtn: AllergyButton!
    @IBOutlet var milkBtn: AllergyButton!
    @IBOutlet var onionBtn: AllergyButton!
    @IBOutlet var registerationButton: UIButton!
    
    var user_name = ""
    var birth = ""
    var email = ""
    var password = ""
    var phone_number = ""
    var allergicBtnArr:[AllergyButton] = []
    var allergic: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
        registerationButton.applyRadius(radius: registerationButton.frame.height/2)
        
        allergicBtnArr.append(contentsOf: [buckWheatBtn, wheatBtn, peachBtn, soyBtn, nutsBtn, tomatoBtn, eggBtn, milkBtn, onionBtn])
    }
    
    private func setupAddTarget() {
        buckWheatBtn.addTarget(self, action: #selector(changeSelectedState(_:)), for: .touchUpInside)
        wheatBtn.addTarget(self, action: #selector(changeSelectedState(_:)), for: .touchUpInside)
        peachBtn.addTarget(self, action: #selector(changeSelectedState(_:)), for: .touchUpInside)
        soyBtn.addTarget(self, action: #selector(changeSelectedState(_:)), for: .touchUpInside)
        nutsBtn.addTarget(self, action: #selector(changeSelectedState(_:)), for: .touchUpInside)
        tomatoBtn.addTarget(self, action: #selector(changeSelectedState(_:)), for: .touchUpInside)
        eggBtn.addTarget(self, action: #selector(changeSelectedState(_:)), for: .touchUpInside)
        milkBtn.addTarget(self, action: #selector(changeSelectedState(_:)), for: .touchUpInside)
        onionBtn.addTarget(self, action: #selector(changeSelectedState(_:)), for: .touchUpInside)
    }
    
    @objc func changeSelectedState(_ sender: AllergyButton) {
        sender.selectCheck = sender.selectCheck ? false : true
    }
    
    @IBAction func completionAction(_ sender: UIButton) {
     
        for i in 0...allergicBtnArr.count-1 {
            if allergicBtnArr[i].selectCheck == true {
                allergic.append(i+1)
            }
        }
        
        let body: [String: Any] = [
            "email": email,
            "password": password,
            "user_name": user_name,
            "birth": birth,
            "phone_number": phone_number,
            "login_type": 0,
            "use_type": 0,
            "allergy": allergic
        ]
        SignUpService.shareInstance.signUp(body: body, completion: { (res) in
            let alert = UIAlertController(title: "회원가입이 완료되었습니다.", message: "", preferredStyle: .alert)
            
            let doneButton = UIAlertAction(title: "확인", style: .default, handler: self.toSignIn(_:))
            alert.addAction(doneButton)
            self.present(alert, animated: true, completion: nil)
            
        }) { (errCode) in
            if errCode == 409 {
                self.simpleAlert(title: "중복 이메일 입니다", message: "")
            } else {
                self.simpleAlert(title: "서버와 연결할 수 없습니다", message: "")
            }
        }
    }
    
    func toSignIn(_ sender: UIAlertAction) -> Void {
        performSegue(withIdentifier: "unwindToSignIn", sender: self)
        
    }
}
