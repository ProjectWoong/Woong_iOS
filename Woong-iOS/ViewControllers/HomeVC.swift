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
    
    let ud = UserDefaults.standard
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo1MCwiZW1haWwiOiJwa3NlMTIxM0BhLmEiLCJpYXQiOjE1MzE0NTk3NjgsImV4cCI6ODc5MzE0NTk3NjgsImlzcyI6InNlcnZpY2UiLCJzdWIiOiJ1c2VyX3Rva2VuIn0.Uktksh977X0jTKtL-aeK1q7g1b0vVBnHfuZ-pUfg8MI"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
       
        //self.ud.set(token, forKey: "token")
        
        setupNaviBar()
        setupTextView()
        setupView()
        checkAddress()
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(weekendFarmerAction))
        self.weekendFarmerImageView.addGestureRecognizer(tapGes)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .rgb(red: 82, green: 156, blue: 119)
        self.navigationController?.navigationItem.titleView?.tintColor = .black
        self.navigationController?.navigationBar.barTintColor = .white
        checkAddress()
    }
    
    private func checkAddress() {
//        if let token = ud.string(forKey: "token"){
        
            LocationService.shareInstance.getLocation(token: token, completion: { (address) in
                self.myAddress = address.realAddress
                self.setupAddress()
            }) { (errCode) in
                print("errnum\(errCode)")
                if errCode == 500 {
                    let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "LocationSearchVC")
                    self.present(destvc, animated: true, completion: nil)
                }
            }
//        }
        
    }

    private func setupNaviBar() {
        self.navigationController?.navigationBar.topItem?.title = myAddress
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    @objc func weekendFarmerAction() {
        let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "WeekendFarmerVC")
        destvc.title = "이 주의 농부"
        self.navigationController?.pushViewController(destvc, animated: true)
    }
    
    func setupAddress(){
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
        let locationGes = UITapGestureRecognizer(target: self, action: #selector(goSearchView))
        locationbutton.addGestureRecognizer(locationGes)
    }
    
    @objc func goSearchView() {
        let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "LocationSearchVC")
        self.present(destvc, animated: true, completion: nil)
    }
    
    private func setupView() {
        homeSearchBar.applyRadius(radius: homeSearchBar.frame.height / 2)
        homeSearchBarView.applyShadow(radius: 6, color: .black, offset: CGSize(width: 0, height: 3), opacity: 0.15)
       
    }
    
    private func setupSearchToolbar() {
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        toolbar.barTintColor = UIColor.white
        let doneButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(doneSearch));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancel));
        doneButton.tintColor = .rgb(red: 82, green: 156, blue: 119)
        cancelButton.tintColor = .rgb(red: 212, green: 84, blue: 133)
        doneButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFEB", size: 15)!], for: .normal)
        cancelButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFEB", size: 15)!], for: .normal)
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        searchTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneSearch() {
        guard let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ProductVC") as? ProductVC else { return }
        
    }
    @objc func cancel() {
        
    }
    
    @IBAction func vegetableView(_ sender: Any) {
        let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        destvc.myAddress = myAddress
        destvc.bigCategoryIndex = 2
        destvc.categoryTextArr = destvc.vegetableArr
        destvc.categoryImageArr = destvc.vegetableImageArr
        
        self.navigationController?.pushViewController(destvc, animated: true)
        
    }
   
    @IBAction func fruitView(_ sender: Any) {
        let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        destvc.myAddress = myAddress
        destvc.bigCategoryIndex = 0
        destvc.categoryTextArr = destvc.fruitArr
        destvc.categoryImageArr = destvc.fruitImgaeArr
        
        self.navigationController?.pushViewController(destvc, animated: true)
        
    }
    
    @IBAction func cerealView(_ sender: Any) {
        let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        destvc.myAddress = myAddress
        destvc.bigCategoryIndex = 1
        destvc.categoryTextArr = destvc.cerealArr
        destvc.categoryImageArr = destvc.cerealImageArr
        
        self.navigationController?.pushViewController(destvc, animated: true)
        
    }
    @IBAction func eggView(_ sender: Any) {
        let destvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        destvc.myAddress = myAddress
        destvc.bigCategoryIndex = 3
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
        self.tabBarController?.selectedIndex = 2
//        let destvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyProductVC") as! MyProductVC
//        self.navigationController?.pushViewController(destvc, animated: true)
    }
    
    @IBAction func bookMarkAction(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 1
//        let destvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MarketVC") as! MarketVC
//        destvc.collectionselectNum = 1
//        self.navigationController?.pushViewController(destvc, animated: true)
    }
    
    @IBAction func messageAction(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 3
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


