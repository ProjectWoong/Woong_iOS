//
//  MyProductVC.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 1..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class MyProductVC: UIViewController {
    let categoryArr = ["찜한 상품", "장바구니"]
    var marketNameArr = ["현듀마켓", "세은마켓", "수정마켓", "혜란마켓"]
    var cartProductArr: [String] = ["왕감장","왕감장","왕감장", "고구마"]
    var isEmptyCheck: Bool = false
    
    @IBOutlet var categoryView: UIView!
    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var productCollectionView: UICollectionView!
    
    // Cart View Outlet
    @IBOutlet var cartView: UIView!
    @IBOutlet var cartTableView: UITableView!
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    let horizontalBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 82, green: 156, blue: 119)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo1MCwiZW1haWwiOiJwa3NlMTIxM0BhLmEiLCJpYXQiOjE1MzE0NTk3NjgsImV4cCI6ODc5MzE0NTk3NjgsImlzcyI6InNlcnZpY2UiLCJzdWIiOiJ1c2VyX3Rva2VuIn0.Uktksh977X0jTKtL-aeK1q7g1b0vVBnHfuZ-pUfg8MI"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupTableView()
        setupHorizontalBar()
        setupView()
        setupNaviBar()
    }
    
    private func setupNaviBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFEB", size: 17)!]
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    private func setupView() {
        categoryView.applyShadow(radius: 6, color: .black, offset: CGSize(width: 0, height: 3), opacity: 0.15)
    }
    
    private func setupCollectionView() {
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        self.productCollectionView.delegate = self
        self.productCollectionView.dataSource = self
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        categoryCollectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .init(rawValue: 0))
        cartView.isHidden = true
    }
    
    private func setupTableView() {
        self.cartTableView.delegate = self
        self.cartTableView.dataSource = self
        self.cartTableView.tableFooterView = UIView(frame: .zero)
        self.cartTableView.separatorStyle = .none
    }
    
    private func setupHorizontalBar() {
        categoryView.addSubview(horizontalBarView)
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: categoryView.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: categoryView.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: categoryView.widthAnchor, multiplier: 1/2).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    @IBAction func orderAction(_ sender: UIButton) {
        
        let PaymentVC = UIStoryboard(name: "MyProduct", bundle: nil).instantiateViewController(withIdentifier: "PaymentVC")
        
        
        self.tabBarController?.tabBar.isHidden = true
        self.hidesBottomBarWhenPushed = true
         self.navigationController?.pushViewController(PaymentVC, animated: true)
      
    }
    
}

// Category & LikedProduct CollectionView
extension MyProductVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView{
            return CGSize(width: self.view.frame.width / 2, height: 44)
        } else {
            return CGSize(width: (self.view.frame.width - 25) / 2, height: 240)
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == categoryCollectionView {
            return 1
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return categoryArr.count
        } else {
            return marketNameArr.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "MyProductCategoryCell", for: indexPath) as! MyProductCategoryCell
            cell.categoryLabel.text = categoryArr[indexPath.row]
            
            return cell
            
        } else {
            let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: "LikeProductCell", for: indexPath) as! LikeProductCell
          
            cell.marketNameLabel.text = marketNameArr[indexPath.row]
            cell.marketNameLabel.sizeToFit()
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            horizontalBarLeftAnchorConstraint?.constant = CGFloat(indexPath.item) * (self.view.frame.width / 2)
        }
        
        if collectionView == categoryCollectionView {
            if indexPath.row == 0{
                cartView.isHidden = true
                productCollectionView.isHidden = false
                
            } else {
                cartView.isHidden = false
                productCollectionView.isHidden = true
            }
        } else if collectionView == productCollectionView {
            let destvc = UIStoryboard(name: "ProductDetail", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
           let cell = productCollectionView.cellForItem(at: indexPath) as! LikeProductCell
            destvc.navigationItem.title = cell.marketNameLabel.text
            destvc.productNameLabel.text = cell.productNameLabel.text
            self.present(destvc, animated: true, completion: nil)
            
            
        }
    }
}

// Cart TableView
extension MyProductVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cartProductArr.count == 0 {
            return 510
        } else {
            if indexPath.section == 0 {
                return 53
            } else if indexPath.section == 1 {
                return 200
            } else {
                return 105
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if cartProductArr.count == 0{
            return 1
        } else {
            return 3
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 2{
            return 1
        } else {
            return cartProductArr.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cartProductArr.count == 0 {
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "EmptyCartCell", for: indexPath)
            return cell
        } else {
            if indexPath.section == 0 {
                let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartCheckCell", for: indexPath) as! CartCheckCell
                return cell
            } else if indexPath.section == 1{
                let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartProductCell", for: indexPath) as! CartProductCell
                cell.delegate = self
                return cell
            } else {
                let cell = cartTableView.dequeueReusableCell(withIdentifier: "SumPriceCell", for: indexPath)
                return cell
            }
        }
    }
}

extension MyProductVC: StepperDelegate {
    func didRightButtonPressed() {
        print("right")
    }
    func didLeftButtonPressed() {
        print("left")
    }
}
