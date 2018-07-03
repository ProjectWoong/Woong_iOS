//
//  NoticeVC.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 1..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class NoticeVC: UIViewController {

    let categoryArr = ["메세지", "배송/상세후기"]
    var readMessageArr = ["","","","","",""]
    var unreadMessageArr = ["",""]
    
    @IBOutlet var categoryView: UIView!
    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var messageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollectionView()
    }
    
    private func setupTableView() {
        self.messageTableView.delegate = self
        self.messageTableView.dataSource = self
    }
    
    private func setupCollectionView() {
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        categoryCollectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .init(rawValue: 0))
    }
}

extension NoticeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "MyProductCategoryCell", for: indexPath) as! MyProductCategoryCell
        cell.categoryLabel.text = categoryArr[indexPath.row]
        
        return cell
    }
}

extension NoticeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if readMessageArr.count == 0 && unreadMessageArr.count == 0 {
            return 1
        } else if readMessageArr.count == 0 || unreadMessageArr.count == 0  {
            return 1
        } else {
            return 2
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if readMessageArr.count == 0 && unreadMessageArr.count == 0 {
            return 1
        } else if readMessageArr.count == 0 || unreadMessageArr.count == 0  {
            if readMessageArr.count == 0 {
                return unreadMessageArr.count
            } else {
                return readMessageArr.count
            }
            
        } else {
            if section == 0 {
                return unreadMessageArr.count
            } else {
                return readMessageArr.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = messageTableView.dequeueReusableCell(withIdentifier: "UnreadMessageCell", for: indexPath)
            return cell
        } else {
            let cell = messageTableView.dequeueReusableCell(withIdentifier: "ReadMessageCell", for: indexPath)
            return cell
        }
    }
    
    
}
