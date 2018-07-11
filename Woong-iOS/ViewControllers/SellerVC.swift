//
//  SellerVC.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 3..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class SellerVC: UIViewController {
    
    let menuCellId = "SellerMenuCell"
    let introCellId = "SellerIntroCell"
    let productCellId = "SellerProductCell"
    let albumCellId = "SellerAlbumCell"
    let menu = ["소개", "물품", "앨범", "후기"]
    
    var flag = 0
    
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    var sellerMenuConstraint: NSLayoutConstraint?
    
    @IBOutlet var sellerMenuTopConstraint: NSLayoutConstraint!
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var sellerProfileView: UIView!
    @IBOutlet var sellerMenuCollectionView: UICollectionView!
    @IBOutlet var sellerMenuView: UIView!
    
    @IBOutlet var sellerProfileImage: UIImageView!
    
    
    @IBOutlet var sellerInfoCollectionView: UICollectionView!
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    let horizontalBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setupView()
        setupCollectionView()
        setupHorizontalBar()
        setupNavi()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func changeMenu(_ flag: Int) {
        self.flag = flag
        if flag == 0 {
            if let flowLayout = sellerInfoCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.minimumLineSpacing = 0
                flowLayout.minimumInteritemSpacing = 0
            }
            sellerInfoCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            sellerInfoCollectionView.reloadData()
            sellerInfoCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        } else if flag == 1 {
            if let flowLayout = sellerInfoCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.minimumLineSpacing = 24
                flowLayout.minimumInteritemSpacing = 9
            }
            sellerInfoCollectionView.contentInset = UIEdgeInsetsMake(8, 8, 8, 8)
            sellerInfoCollectionView.reloadData()
            sellerInfoCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        } else {
            if let flowLayout = sellerInfoCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.minimumLineSpacing = 0
                flowLayout.minimumInteritemSpacing = 0
            }
            sellerInfoCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            sellerInfoCollectionView.reloadData()
            sellerInfoCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
    }
    
    func testAction(_ sender: Any) {
        for i in 0 ..< menu.count {
            let cell = sellerMenuCollectionView.cellForItem(at: IndexPath(item: i, section: 0)) as! SellerMenuCell
            cell.setSelectedColor(UIColor.black)
            sellerMenuCollectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .init(rawValue: 0))
        }
    }
    
    private func setupView() {
        sellerProfileImage.applyRadius(radius: sellerProfileImage.frame.height/2)
        //sellerProfileImage.applyBorder(width: 4, color: .rgb(red: 82, green: 156, blue: 119))
    }
    
    private func setupNavi() {
        let rightBarBtn = UIBarButtonItem(title: "back", style: .plain, target: self, action: nil)
        let leftBarBtn = UIBarButtonItem(title: "mail", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = rightBarBtn
        self.navigationItem.leftBarButtonItem = leftBarBtn
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    
    private func setupCollectionView() {
        sellerMenuView.applyShadow(radius: 5, color: UIColor.darkGray, offset: CGSize(width: 0, height: 0), opacity: 0.7)
        sellerMenuCollectionView.delegate = self
        sellerMenuCollectionView.dataSource = self
        sellerMenuCollectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .init(rawValue: 0))
        
        sellerInfoCollectionView.delegate = self
        sellerInfoCollectionView.dataSource = self
        
    }
    
    private func setupHorizontalBar() {
        sellerMenuView.addSubview(horizontalBarView)
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: sellerMenuView.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: sellerMenuView.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: sellerMenuView.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
   

}

extension SellerVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let scrollY = scrollView.contentOffset.y
            let collectionY = sellerInfoCollectionView.contentOffset.y
            
            if scrollY == 0 {
                if collectionY != 0 {
                    sellerInfoCollectionView.isScrollEnabled = true
                } else {

                }
            } else if scrollY < 184 {
                sellerMenuTopConstraint.constant = 248
                sellerInfoCollectionView.isScrollEnabled = false
                self.scrollView.bounces = true
            } else if scrollY >= 184 {
                sellerMenuTopConstraint.constant = scrollY + 64
                sellerInfoCollectionView.isScrollEnabled = true
                self.scrollView.bounces = false
            }
        }
        else {
            let y = sellerInfoCollectionView.contentOffset.y
            
            if y > 1 {
                sellerInfoCollectionView.bounces = true
            } else {
                sellerInfoCollectionView.bounces = false
            }
        }
    }

    
}

extension SellerVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sellerMenuCollectionView {
            return CGSize(width: sellerMenuView.frame.width / 4, height: sellerMenuView.frame.height)
        } else {
            if flag == 0 {
                return CGSize(width: self.view.frame.width, height: self.view.frame.width)
            } else if flag == 1 {
                return CGSize(width: (self.view.frame.width - 25) / 2, height: 224)
            } else {
                return CGSize(width: self.view.frame.width, height: 223)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sellerMenuCollectionView {
            return menu.count
        } else {
            if flag == 0 {
                return 1
            } else if flag == 1 {
                return 10
            } else {
                return 6
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sellerMenuCollectionView {
            let cell = sellerMenuCollectionView.dequeueReusableCell(withReuseIdentifier: menuCellId, for: indexPath) as! SellerMenuCell
            cell.tintColor = UIColor.rgb(red: 173, green: 173, blue: 173)
            cell.menuLabel.text = menu[indexPath.item]
            return cell
        } else {
            if flag == 0 {
                let cell = sellerInfoCollectionView.dequeueReusableCell(withReuseIdentifier: introCellId, for: indexPath) as! SellerIntroCell
                return cell
            } else if flag == 1 {
                let cell = sellerInfoCollectionView.dequeueReusableCell(withReuseIdentifier: productCellId, for: indexPath) as! SellerProductCell
                return cell
            } else {
                let cell = sellerInfoCollectionView.dequeueReusableCell(withReuseIdentifier: albumCellId, for: indexPath) as! SellerAlbumCell
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sellerMenuCollectionView {
            self.selectedIndexPath = indexPath
            horizontalBarLeftAnchorConstraint?.constant = CGFloat(indexPath.item) * (self.view.frame.width / 4)
            changeMenu(indexPath.item)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        <#code#>
//    }
    
    
    
    
}
