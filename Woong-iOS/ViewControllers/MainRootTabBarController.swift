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
        self.hero.tabBarAnimationType = .fade
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindMain(_ sender: UIStoryboardSegue) {
        
    }
    
    private func setupTabBar() {
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .white
        self.tabBar.applyShadow(radius: 5, color: .black, offset: CGSize(width: 0, height: -2), opacity: 0.15)
    }

}
