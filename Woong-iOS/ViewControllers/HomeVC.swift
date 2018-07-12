//
//  HomeVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 1..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet var homeSearchBarView: UIView!
    @IBOutlet var homeSearchBar: UIView!
    @IBOutlet var homeSearchBarHeightContraint: NSLayoutConstraint!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weekendFarmerImageView: UIImageView!
    @IBOutlet var homeScrollView: UIScrollView!
    
    var myAddress: String = ""
    var diffMin: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myAddress = "용산구 청파동 92-1"
        setupAddress(address: myAddress)
        setupNaviBar()
        setupTextView()
        setupView()
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(weekendFarmerAction))
         self.weekendFarmerImageView.addGestureRecognizer(tapGes)
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(addCartItem), name: NSNotification.Name("SetupAddress") , object: nil)
        
    }
    
     @objc func addCartItem(noti:Notification) {
        let address = noti.object as! String
        self.setupAddress(address: address)
    }
    
    @objc func weekendFarmerAction() {
        let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "WeekendFarmerVC")
       destvc.title = "이 주의 농부"
        self.navigationController?.pushViewController(destvc, animated: true)
    }
    
    private func setupNaviBar() {
        self.navigationController?.navigationBar.topItem?.title = myAddress
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = .white
      
    }
    
    func setupAddress(address: String){
        self.myAddress = address
        print(myAddress)
        let testFrame : CGRect = CGRect(x: 0, y: 0, width: 375, height: 50)
        let buttonView: UIView = UIView(frame: testFrame)
        let locationbutton =  UIButton(type: .system) as UIButton
        locationbutton.frame = CGRect(x: 0, y: 0, width: 375, height: 50)
        let locationimage = UIImage(named: "navigation-bar-location-green")
        
        locationbutton.tintColor = #colorLiteral(red: 0.3215686275, green: 0.6117647059, blue: 0.4666666667, alpha: 1)
        locationbutton.semanticContentAttribute = .forceRightToLeft
        locationbutton.setTitle("\(self.myAddress) ", for: .normal)
        locationbutton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        locationbutton.setImage(locationimage, for: .normal)
        locationbutton.titleLabel?.font = UIFont(name: "NanumSquareOTFEB", size: 17)
        buttonView.addSubview(locationbutton)
        self.navigationItem.titleView = buttonView
        let locationGes = UITapGestureRecognizer(target: self, action: #selector(settingLocation))
        locationbutton.addGestureRecognizer(locationGes)
    }
    
    @objc func settingLocation() {
        let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "LocationSearchVC")
        self.present(destvc, animated: true, completion: nil)
    }
    
    private func setupView() {
        homeSearchBar.applyRadius(radius: homeSearchBar.frame.height / 2)
        homeSearchBarView.applyShadow(radius: 6, color: .black, offset: CGSize(width: 0, height: 3), opacity: 0.15)
       
    }
    
    @IBAction func vegetableView(_ sender: Any) {
        let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        destvc.myAddress = myAddress
        
        destvc.categoryTextArr = destvc.vegetableArr
        destvc.categoryImageArr = destvc.vegetableImageArr
        
        self.navigationController?.pushViewController(destvc, animated: true)
        
    }
   
    @IBAction func fruitView(_ sender: Any) {
        let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        destvc.myAddress = myAddress
        
        destvc.categoryTextArr = destvc.fruitArr
        destvc.categoryImageArr = destvc.fruitImgaeArr
        
        self.navigationController?.pushViewController(destvc, animated: true)
        
    }
    
    @IBAction func cerealView(_ sender: Any) {
        let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        destvc.myAddress = myAddress
        
        destvc.categoryTextArr = destvc.cerealArr
        destvc.categoryImageArr = destvc.cerealImageArr
        
        self.navigationController?.pushViewController(destvc, animated: true)
        
    }
    @IBAction func eggView(_ sender: Any) {
        let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        destvc.myAddress = myAddress
        
        destvc.categoryTextArr = destvc.eggArr
        destvc.categoryImageArr = destvc.eggImageArr
        
        self.navigationController?.pushViewController(destvc, animated: true)
        
    }
    
    @IBAction func deliveryAction(_ sender: UIButton) {
        let destvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
        destvc.collectionselectNum = 1
        self.navigationController?.pushViewController(destvc, animated: true)
    }
    @IBAction func likeProductAction(_ sender: UIButton) {
        let destvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyProductVC") as! MyProductVC
        self.navigationController?.pushViewController(destvc, animated: true)
    }
    
    @IBAction func bookMarkAction(_ sender: UIButton) {
        let destvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MarketVC") as! MarketVC
        destvc.collectionselectNum = 1
        self.navigationController?.pushViewController(destvc, animated: true)
    }
    
    @IBAction func messageAction(_ sender: UIButton) {
        let destvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
        self.navigationController?.pushViewController(destvc, animated: true)
    }
}


extension HomeVC: UITextFieldDelegate {
    private func setupTextView() {
        searchTextField.delegate = self
        
        let tapDidsmiss = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapDidsmiss)
        
    }
    
    @objc func dismissKeyboard() {
        searchTextField.resignFirstResponder()
    }
}


