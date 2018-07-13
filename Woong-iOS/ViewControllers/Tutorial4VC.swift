//
//  Tutorial4VC.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 13..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit
import Hero

class Tutorial4VC: UIViewController {

    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view4: UIView!
    @IBOutlet var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupView() {
        view1.hero.id = "view1"
        view2.hero.id = "view2"
        view3.hero.id = "view3"
        view4.hero.id = "view4"
        view1.applyRadius(radius: view1.frame.height/2)
        view2.applyRadius(radius: view2.frame.height/2)
        view3.applyRadius(radius: view3.frame.height/2)
        view4.applyRadius(radius: view3.frame.height/2)
        startBtn.hero.modifiers = [.scale(0.2), .fade]
        startBtn.applyRadius(radius: 22/667 * self.view.frame.height)
        startBtn.addTarget(self, action: #selector(goToStart), for: .touchUpInside)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(holeSwiped(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(holeSwiped(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func holeSwiped(gesture: UISwipeGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                dismiss(animated: true)
            case UISwipeGestureRecognizerDirection.left:
                break
            default:
                break
            }
        }
    }
    
    @objc func goToStart() {
        guard let dvc = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(withIdentifier: "ChooseLoginVC") as? ChooseLoginVC else { return }
        self.present(dvc, animated: true)
    }
    

}
