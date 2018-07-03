//
//  SellerVC.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 3..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class SellerVC: UIViewController {
    
    let sellerCellId = "SellerMenuCell"
    let menu = ["소개", "물품", "앨범", "후기"]
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    
    var sellerMenuConstraint: NSLayoutConstraint?
    
    @IBOutlet var sellerMenuTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var sellerProfileView: UIView!
    @IBOutlet var sellerMenuCollectionView: UICollectionView!
    @IBOutlet var sellerMenuView: UIView!
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
        setupMenu()
        setupHorizontalBar()
        setupNavi()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testAction(_ sender: Any) {
        for i in 0 ..< 4 {
            let cell = sellerMenuCollectionView.cellForItem(at: IndexPath(item: i, section: 0)) as! SellerMenuCell
            cell.setSelectedColor(UIColor.black)
            sellerMenuCollectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .init(rawValue: 0))
        }
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
    
    private func setupMenu() {
        sellerMenuView.applyShadow(radius: 5, color: UIColor.darkGray, offset: CGSize(width: 0, height: 0), opacity: 0.7)
        sellerMenuCollectionView.delegate = self
        sellerMenuCollectionView.dataSource = self
        sellerMenuCollectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .init(rawValue: 0))
        
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
        let y = scrollView.contentOffset.y
        print(y)
        if y >= 184 {
            sellerMenuTopConstraint.constant = y + 64
        } else if y < 184 {
            sellerMenuTopConstraint.constant = 248
        }
    }
}

extension SellerVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: sellerMenuView.frame.width / 4, height: sellerMenuView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sellerMenuCollectionView.dequeueReusableCell(withReuseIdentifier: sellerCellId, for: indexPath) as! SellerMenuCell
        cell.tintColor = UIColor.rgb(red: 173, green: 173, blue: 173)
        cell.menuLabel.text = menu[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sellerMenuCollectionView {
            self.selectedIndexPath = indexPath
            horizontalBarLeftAnchorConstraint?.constant = CGFloat(indexPath.item) * (self.view.frame.width / 4)
        }
    }
    
    
    
    
}
