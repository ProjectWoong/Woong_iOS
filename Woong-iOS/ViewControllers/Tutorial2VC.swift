//
//  Tutorial2VC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 1..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class Tutorial2VC: UIViewController {
    
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view4: UIView!

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
        view1.applyRadius(radius: view1.frame.height/2)
        view2.applyRadius(radius: view1.frame.height/2)
        view3.applyRadius(radius: view3.frame.height/2)
        view4.applyRadius(radius: view4.frame.height/2)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(holeSwiped(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(holeSwiped(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func holeSwiped(gesture: UISwipeGestureRecognizer)
    {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                dismiss(animated: true)
            case UISwipeGestureRecognizerDirection.left:
                guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "Tutorial3") as? Tutorial3VC else { return }
                dvc.hero.modalAnimationType = .selectBy(presenting: .fade, dismissing: .fade)
                present(dvc, animated: true)
            default:
                break
            }
        }
    }

    

}
