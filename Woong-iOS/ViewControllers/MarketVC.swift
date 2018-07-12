//
//  MarketVC.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 1..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class MarketVC: UIViewController {
    var collectionselectNum = 0
    let categoryArr = ["내 주변 마켓", "즐겨찾기"]
    let likeImage = UIImage(named: "market-favorite-favorite")
    let unlikeImage = UIImage(named: "market-favorite-delete")
    
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
        setupCollectionView(num: collectionselectNum)
        setupTableView()
        setupHorizontalBar()
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
    
    private func setupCollectionView(num: Int) {
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        
        let selectedIndexPath = NSIndexPath(item: num, section: 0)
        categoryCollectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .init(rawValue: 0))
    }
    
    private func setupTableView() {
        if collectionselectNum == 0 {
            bookMarkTableView.isHidden = true
        } else if collectionselectNum == 1 {
            nearMarketTableView.isHidden = true
        }
        
        nearMarketTableView.delegate = self
        nearMarketTableView.dataSource = self
        nearMarketTableView.tableFooterView = UIView(frame: .zero)
        nearMarketTableView.separatorStyle = .none
        
        bookMarkTableView.delegate = self
        bookMarkTableView.dataSource = self
        bookMarkTableView.tableFooterView = UIView(frame: .zero)
        bookMarkTableView.separatorStyle = .none
        
        
    }
    
    private func setupHorizontalBar() {
        categoryView.addSubview(horizontalBarView)
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: categoryView.leftAnchor)
        horizontalBarLeftAnchorConstraint?.constant = CGFloat(collectionselectNum) * (self.view.frame.width / 2)
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
        return CGSize(width: self.view.frame.width / 2, height: 44)
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
            return 90
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
            
            cell.starButton.tag = indexPath.row
            cell.starButton.addTarget(self, action: #selector(deleteBookMarkFromButton(button:)), for: .touchUpInside)
            return cell
        }
    }
    
    @objc func deleteBookMarkFromButton(button: UIButton) {
        button.setBackgroundImage(unlikeImage, for: .normal) 
//        bookMarkTableView.reloadData()
    }

}








