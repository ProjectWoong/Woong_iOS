//
//  MarketVC.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 1..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class MarketVC: UIViewController {
    
    
    let categoryArr = ["내 주변 마켓", "즐겨찾기"]
    
    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var nearMarketTableView: UITableView!
    @IBOutlet var bookMarkTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupTableView()
    }
    
    private func setupCollectionView() {
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        categoryCollectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .init(rawValue: 0))
    }
    private func setupTableView() {
        bookMarkTableView.isHidden = true
        
        nearMarketTableView.delegate = self
        nearMarketTableView.dataSource = self
        
        bookMarkTableView.delegate = self
        bookMarkTableView.dataSource = self
    }
}

extension MarketVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "MyProductCategoryCell", for: indexPath) as! MyProductCategoryCell
        cell.categoryLabel.text = categoryArr[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            nearMarketTableView.isHidden = false
            bookMarkTableView.isHidden = true
            
        } else {
            nearMarketTableView.isHidden = true
            bookMarkTableView.isHidden = false
        }
    }
}

extension MarketVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == nearMarketTableView {
            let cell = nearMarketTableView.dequeueReusableCell(withIdentifier: "NearMarketCell") as! NearMarketCell
            return cell
        } else {
            let cell = bookMarkTableView.dequeueReusableCell(withIdentifier: "BookMarkCell") as! BookMarkCell
            return cell
        }
    }
}








