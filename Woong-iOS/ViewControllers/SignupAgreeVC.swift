//
//  SignupAgreeVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 7..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class SignupAgreeVC: UIViewController {

    @IBOutlet var agreeButton: UIButton!
    
    @IBOutlet var logoImg: UIImageView!
    @IBOutlet var logoLabel: UILabel!
    @IBOutlet var logoStack: UIStackView!
    
    
    
    @IBOutlet var agree1View: UIView!
    @IBOutlet var agree2View: UIView!
    @IBOutlet var agree3View: UIView!
    @IBOutlet var agree4View: UIView!
    
    @IBOutlet weak var textview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoStack.hero.id = "stack"
        agreeButton.hero.id = "next"
        
        self.hero.modalAnimationType = .pageIn(direction: .left)
        agreeButton.applyRadius(radius: agreeButton.frame.height/2)
        
        agree1View.layer.borderWidth = 1
        agree1View.layer.borderColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
        agree2View.layer.borderWidth = 1
        agree2View.layer.borderColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
        agree3View.layer.borderWidth = 1
        agree3View.layer.borderColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
        agree4View.layer.borderWidth = 1
        agree4View.layer.borderColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
        
        textview.flashScrollIndicators()
        
    }
    
    @IBAction func agreeAction(_ sender: UIButton) {
        let signupVC = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(withIdentifier: "SignUpInfo1VC")
        
        self.present(signupVC, animated: true, completion: nil)
    }
}
