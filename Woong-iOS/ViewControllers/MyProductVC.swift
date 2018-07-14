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

    var isEmptyCheck: Bool = false
    
    var favoritList: [Favorite] = []
    var cartList: [Cart] = []
    let likeImage = UIImage(named: "product-like")
    let unlikeImage = UIImage(named: "product-not-like")
    var first = 0
    let checkImage = UIImage(named: "mine-basket-check")
    let uncheckeImage = UIImage(named: "mine-basket-not-check")
    
    var checkCartList: [Int] = []
    
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
        dataInit()
        setupCollectionView()
        setupTableView()
        setupHorizontalBar()
        setupView()
        setupNaviBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dataInit()
        productCollectionView.reloadData()
        cartTableView.reloadData()
    }
    private func dataInit() {
        FavoriteListService.shareInstance.getCartList(token: token, completion: { (res) in
            self.favoritList = res.favoriteInfo
            print("찜 성공")
            
        }) { (errCode) in
            print("찜 실패")
        }
        CartListService.shareInstance.getCartList(token: self.token, completion: { (res) in
            self.cartList = res
        }) { (err) in
            print("카트실패")
        }
        productCollectionView.reloadData()
        cartTableView.reloadData()
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
            return self.favoritList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "MyProductCategoryCell", for: indexPath) as! MyProductCategoryCell
            cell.categoryLabel.text = categoryArr[indexPath.row]
            return cell
        } else {
            let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: "LikeProductCell", for: indexPath) as! LikeProductCell
            let product = favoritList[indexPath.item]
            cell.marketNameLabel.text = product.marketName
            cell.productNameLabel.text = product.productName
            cell.priceLabel.text = product.productUnit + "당 " + "\(product.productPrice)원"
            
            if product.delivery == 1 {
                cell.hashTag1Label.text = "#유료배송"
            }
            if product.quick == 0 {
                cell.hashTag2Label.isHidden = true
            }
            
            cell.heartImageView.tag = product.productId
            
            cell.heartImageView.addTarget(self, action: #selector(deletefavoriteFromButton(button:)), for: .touchUpInside)
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
    
    
    @objc func deletefavoriteFromButton(button: UIButton) {
        
            //            if let token = ud.string(forKey: "token") {
            FavoriteOperateService.shareInstance.deleteFavoriteList(productId: button.tag, token: self.token, completion: {
                print("성공태그\(button.tag)")
                self.simpleAlertWithCompletion(title: "찜한 상품을 해제하시겠습니까?", message: "", okCompletion: { (_) in
                    self.dataInit()
                }, cancelCompletion: { (_) in
                    
                })
            }) { (errCode) in
                self.simpleAlert(title: "서버와 연결할 수 없습니다", message: "")
            }
            //            }
        dataInit()
    }
    
}

// Cart TableView
extension MyProductVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cartList.count == 0 {
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
        if cartList.count == 0{
            return 1
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 2{
            return 1
        } else {
            return cartList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cartList.count == 0 {
            let cell = cartTableView.dequeueReusableCell(withIdentifier: "EmptyCartCell", for: indexPath)
            return cell
        } else {
            if indexPath.section == 0 {
                let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartCheckCell", for: indexPath) as! CartCheckCell
                return cell
            } else if indexPath.section == 1{
                let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartProductCell", for: indexPath) as! CartProductCell
                let product = cartList[indexPath.row]
                cell.marketAndProductLabel.text = product.carttitle
                cell.priceLabel.text = product.packging
                cell.deliveryLabel.text = "\(product.delivery)원"
                cell.chekButton.tag = product.itemID
                cell.chekButton.addTarget(self, action: #selector(changeCart(button:)), for: .touchUpInside)
               
                cell.deleteButton.tag = product.itemID
                cell.deleteButton.addTarget(self, action: #selector(changeCart(button:)), for: .touchUpInside)
                
             
                return cell
            } else {
                let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartSumPriceCell", for: indexPath) as! CartSumPriceCell
                
                var productPrice = 0
                var deliveryPrice = 0
                if checkCartList.count > 0 {
                    for i in 0...(checkCartList.count-1) {
                        for k in 0...cartList.count-1{
                            if cartList[k].itemID == checkCartList[i] {
                                productPrice = productPrice + cartList[k].itemPrice
                                deliveryPrice = deliveryPrice + cartList[k].delivery
                            }
                        }
                    }
                }
                let sumPrice = productPrice + deliveryPrice
                
                cell.productPriceLabel.text = "\(productPrice)원"
                cell.deliveryPriceLabel.text = "\(deliveryPrice)원"
                cell.sumPriceLabel.text = "\(sumPrice)원"
                return cell
            }
        }
    }
    
    @objc func changeCart(button: UIButton){
        if button.currentBackgroundImage == checkImage {
            button.setBackgroundImage(uncheckeImage, for: .normal)
            
            
        } else if button.currentBackgroundImage == uncheckeImage {
            button.setBackgroundImage(checkImage, for: .normal)
          
        }
        cartTableView.reloadData()
        
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

