//
//  SampleVC.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 3..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class SampleVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func NextAction(_ sender: Any) {
        guard let destvc = storyboard?.instantiateViewController(withIdentifier: "SellerNavi") else { return }
        present(destvc, animated: true)
    }
    

}
