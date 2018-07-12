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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
        registerationButton.applyRadius(radius: registerationButton.frame.height/2)
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

}
