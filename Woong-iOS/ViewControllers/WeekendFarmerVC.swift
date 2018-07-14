//
//  WeekendFarmerVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 11..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class WeekendFarmerVC: UIViewController {

    @IBOutlet weak var marketButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        marketButton.layer.masksToBounds = true
        marketButton.layer.cornerRadius = 24
        setupNavi()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavi() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .rgb(red: 82, green: 156, blue: 119)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFEB", size: 17)!, NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    

}
