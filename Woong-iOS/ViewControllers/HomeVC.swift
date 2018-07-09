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
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        guard (object as? UIScrollView) != nil else { return }
//        let changeValue = change! as [NSKeyValueChangeKey:AnyObject]
//        if let new = changeValue[.newKey]?.cgPointValue, let old = changeValue[.oldKey]?.cgPointValue {
//            let diff = new.y - old.y
//            if diff > 0 {
//
//                if self.homeSearchBarHeightContraint.constant <= 0 {
//                    self.homeSearchBarHeightContraint.constant = 0
//                } else {
//                    self.homeSearchBarHeightContraint.constant -= diff
//                }
//            } else if diff < 0{
//                diffMin = diffMin - diff
//                if diffMin >= 10 {
//                    UIView.animate(withDuration: 0.6) {
//                        self.homeSearchBarHeightContraint.constant = 44
//                    }
//                    diffMin = 0
//                }
//
//            }
//        }
//    }
    
    
    
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
    
//    @IBAction func NextView(_ sender: Any) {
//        let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CategoryVC")
//        self.navigationController?.pushViewController(destvc, animated: true)
//    }

}



