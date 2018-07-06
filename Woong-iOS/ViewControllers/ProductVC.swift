//
//  ProductVC.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 6..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class ProductVC: UIViewController {

    @IBOutlet var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //segmentControl.applyRadius(radius: 4)
        segmentControl.applyShadow(radius: 10, color: UIColor.darkGray, offset: CGSize(width: 0, height: 0), opacity: 0.5)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}
