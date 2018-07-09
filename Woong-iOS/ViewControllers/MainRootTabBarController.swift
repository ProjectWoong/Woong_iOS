//
//  MainRootTabBarController.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 9..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class MainRootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func setupTabBar() {
        self.tabBar.barTintColor = .white
        self.tabBar.applyShadow(radius: 4, color: .darkGray, offset: CGSize(width: 0, height: 0), opacity: 0.6)
    }

}
