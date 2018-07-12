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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
