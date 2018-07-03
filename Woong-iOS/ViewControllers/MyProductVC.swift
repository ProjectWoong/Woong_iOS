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
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    var cartProductArr: [String] = ["왕감장","왕감장","왕감장", "고구마"]
    
    @IBOutlet var categoryView: UIView!
    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var productCollectionView: UICollectionView!
    
    // Cart View Outlet
    @IBOutlet var cartView: UIView!
    @IBOutlet var CartTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTableView()
    }
    
    private func setupCollectionView() {
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        self.productCollectionView.delegate = self
        self.productCollectionView.dataSource = self
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        categoryCollectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .init(rawValue: 0))
    }
    private func setupTableView() {
        self.CartTableView.delegate = self
        self.CartTableView.dataSource = self
    }
}

// Category & LikedProduct CollectionView
extension MyProductVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    }
}

// Cart TableView
extension MyProductVC: UITableViewDelegate, UITableViewDataSource {
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
            let cell = CartTableView.dequeueReusableCell(withIdentifier: "EmptyCartCell", for: indexPath)
            return cell
        } else {
            if indexPath.section == 0 {
                let cell = CartTableView.dequeueReusableCell(withIdentifier: "CartCheckCell", for: indexPath) as! CartCheckCell
                return cell
            } else if indexPath.section == 1{
                let cell = CartTableView.dequeueReusableCell(withIdentifier: "CartProductCell", for: indexPath) as! CartProductCell
                return cell
            } else {
                let cell = CartTableView.dequeueReusableCell(withIdentifier: "SumPriceCell", for: indexPath)
                return cell
            }
        }
    }
    
    
}
