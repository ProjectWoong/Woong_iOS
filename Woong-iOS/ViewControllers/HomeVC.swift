//
//  HomeVC.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 1..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    
    @IBOutlet var homeSearchBarView: UIView!
    @IBOutlet var homeSearchBar: UIView!
    @IBOutlet var homeSearchBarHeightContraint: NSLayoutConstraint!
    
    @IBOutlet var homeScrollView: UIScrollView!
    
    var myAddress: String = "마포구 서교동"
    var diffMin: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //homeScrollView.addObserver(self, forKeyPath: "contentOffset", options: [.new, .old], context: nil)
        
        setupNaviBar()
        setupView()
        // Do any additional setup after loading the view.
    }

    
    private func setupNaviBar() {
        self.navigationController?.navigationBar.topItem?.title = myAddress
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    private func setupView() {
        homeSearchBar.applyRadius(radius: homeSearchBar.frame.height / 2)
        homeSearchBarView.applyShadow(radius: 4, color: .darkGray, offset: CGSize(width: 0, height: 0), opacity: 0.6)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func NextView(_ sender: Any) {
        let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CategoryVC")
        self.navigationController?.pushViewController(destvc, animated: true)
    }

}



