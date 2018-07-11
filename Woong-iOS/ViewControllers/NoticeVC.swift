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
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    @IBOutlet var categoryView: UIView!
    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var messageTableView: UITableView!
    @IBOutlet weak var deliveryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupCollectionView()
        setupHorizontalBar()
    }
    private func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor.rgb(red: 35, green: 122, blue: 89)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        categoryView.addSubview(horizontalBarView)
        
        //horizontalBarLeftAnchorConstraint = bigCategoryBar.leftAnchor.
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: categoryView.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: categoryView.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: categoryView.widthAnchor, multiplier: 1/2).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    private func setupTableView() {
        deliveryTableView.isHidden = true
        
        self.messageTableView.delegate = self
        self.messageTableView.dataSource = self
        self.messageTableView.tableFooterView = UIView(frame: .zero)
        self.messageTableView.separatorStyle = .none
        
        self.deliveryTableView.delegate = self
        self.deliveryTableView.dataSource = self
        self.deliveryTableView.tableFooterView = UIView(frame: .zero)
        self.deliveryTableView.separatorStyle = .none
    }
    
    private func setupCollectionView() {
        self.categoryView.applyShadow(radius: 5, color: UIColor.darkGray, offset: CGSize(width: 0, height: 0), opacity: 0.5)
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        categoryCollectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .init(rawValue: 0))
    }
}

extension NoticeVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
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
        horizontalBarLeftAnchorConstraint?.constant = CGFloat(indexPath.item) * (self.view.frame.width / 2)
        if indexPath.row == 0 {
            
            messageTableView.isHidden = false
            deliveryTableView.isHidden = true
        } else {
            messageTableView.isHidden = true
            deliveryTableView.isHidden = false
        }
    }
}

extension NoticeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView == messageTableView {
            if readMessageArr.count == 0 && unreadMessageArr.count == 0 {
                return 1
            } else if readMessageArr.count == 0 || unreadMessageArr.count == 0  {
                return 1
            } else {
                return 2
            }
        } else {                    //  배송
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == messageTableView {
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
        } else {
            
            if section == 0 {
                return 1
            } else if section == 1 {
                return 2
            } else if section == 2 {
                return 1
            } else {
                return 2
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == messageTableView {
            if indexPath.section == 0 {
                let cell = messageTableView.dequeueReusableCell(withIdentifier: "UnreadMessageCell", for: indexPath)
                return cell
            } else {
                let cell = messageTableView.dequeueReusableCell(withIdentifier: "ReadMessageCell", for: indexPath)
                return cell
            }
        } else {
            
            if indexPath.section == 0{
                let cell = deliveryTableView.dequeueReusableCell(withIdentifier: "DeliveringHeader", for: indexPath)
                 return cell
            } else if indexPath.section == 1{
                let cell = deliveryTableView.dequeueReusableCell(withIdentifier: "DeliveringCell", for: indexPath) as! DeliveringCell
                
                return cell
            }
            else if indexPath.section == 2 {
                let cell = deliveryTableView.dequeueReusableCell(withIdentifier: "DeliveredHeader", for: indexPath)
                return cell
            } else {
                let cell = deliveryTableView.dequeueReusableCell(withIdentifier: "DeliveredCell", for: indexPath) as! DeliveredCell
                cell.reviewButton.addTarget(self, action: #selector(reviewRegisterationAction(button:)), for: .touchUpInside)
                return cell
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == messageTableView {
            let MessageVC = UIStoryboard(name: "Notice", bundle: nil).instantiateViewController(withIdentifier: "MessageVC")
            self.tabBarController?.tabBar.isHidden = true
         self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(MessageVC, animated: true)
            
            
        }
    }
    
    @objc func reviewRegisterationAction(button: UIButton){
        let reviewRegisterationVC = UIStoryboard(name: "Notice", bundle: nil).instantiateViewController(withIdentifier: "ReviewRegisterationVC")
        
        self.present(reviewRegisterationVC, animated: true, completion: nil)
    }
    
}
