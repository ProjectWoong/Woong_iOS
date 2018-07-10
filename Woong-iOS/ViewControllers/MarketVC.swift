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
    
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    
    @IBOutlet var categoryView: UIView!
    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var nearMarketTableView: UITableView!
    @IBOutlet var bookMarkTableView: UITableView!
    
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    let horizontalBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 82, green: 156, blue: 119)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        setupTableView()
        setupHorizontalBar()
    }
    
    private func setupView() {
        categoryView.applyShadow(radius: 6, color: .black, offset: CGSize(width: 0, height: 3), opacity: 0.15)
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
    
    private func setupHorizontalBar() {
        categoryView.addSubview(horizontalBarView)
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: categoryView.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: categoryView.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: categoryView.widthAnchor, multiplier: 1/2).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    private func changeMenu(_ flag: Int) {
        if flag == 0 {
            nearMarketTableView.isHidden = false
            bookMarkTableView.isHidden = true
        } else  if flag == 1 {
            nearMarketTableView.isHidden = true
            bookMarkTableView.isHidden = false
        }
    }
}

extension MarketVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "MyProductCategoryCell", for: indexPath) as! MyProductCategoryCell
        cell.categoryLabel.text = categoryArr[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        horizontalBarLeftAnchorConstraint?.constant = CGFloat(indexPath.item) * (self.view.frame.width / 2)
        changeMenu(indexPath.row)
    }
}

extension MarketVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == nearMarketTableView {
            return 121
        } else {
            return 61
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == nearMarketTableView {
            return 5
        } else {
            return 5
        }
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








