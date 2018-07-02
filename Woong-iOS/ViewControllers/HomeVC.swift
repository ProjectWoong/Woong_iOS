//
//  HomeVC.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 1..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviBar()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupNaviBar() {
        self.navigationController?.navigationBar.topItem?.title = "Your Title"
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func NextView(_ sender: Any) {
        let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CategoryVC")
        self.navigationController?.pushViewController(destvc, animated: true)
    }
    
    

}
