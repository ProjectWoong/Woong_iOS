//
//  ProductVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class ProductVC: UIViewController {
    
    var searchKeyword: String?
    
    var mainId = 0
    var subId = 0
//    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo1MCwiZW1haWwiOiJwa3NlMTIxM0BhLmEiLCJpYXQiOjE1MzE0NTk3NjgsImV4cCI6ODc5MzE0NTk3NjgsImlzcyI6InNlcnZpY2UiLCJzdWIiOiJ1c2VyX3Rva2VuIn0.Uktksh977X0jTKtL-aeK1q7g1b0vVBnHfuZ-pUfg8MI"
    
    let ud = UserDefaults.standard
    
    @IBOutlet weak var rangeView: UIView!
    @IBOutlet weak var rangeSegment: UISegmentedControl!
    
    var productList: [Product] = []
    
    @IBOutlet var productCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupCollectionView()
        rangeView.applyShadow(radius: 10, color: .black, offset: CGSize(width: 0, height: 10), opacity: 0.1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFEB", size: 17)!, NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    private func setupData() {
        guard let token = self.ud.string(forKey: "token") else { return }
        if let keyword = searchKeyword {
            ProductService.shareInstance.getSearchList(keyword: keyword, token: token, completion: { (res) in
                self.productList = res.itemInfo
                self.productCollectionView.reloadData()
            }) { (errCode) in
                self.simpleAlert(title: "네트워크 에러", message: "서버가 응답하지 않습니다.")
            }
        } else {
            ProductService.shareInstance.getProductList(token: token, mainId: mainId, subId: subId, completion: { (res) in
                self.productList = res.itemInfo
                self.productCollectionView.reloadData()
            }) { (errCode) in
                self.simpleAlert(title: "네트워크 에러", message: "서버가 응답하지 않습니다.")
            }
        }
    }
    
    private func setupNavi() {
        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigation-bar-search"), style: .plain, target: self, action: #selector(letSearch))
        let cartBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigation-bar-basket"), style: .done, target: self, action: #selector(goToCart))
        
    }
    
    
    private func setupCollectionView() {
        self.productCollectionView.delegate = self
        self.productCollectionView.dataSource = self
    }
    
    @objc func letSearch() {
        
    }
    
    @objc func goToCart() {
        
    }
}

extension ProductVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return productList.count
//        return productList.productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = productList[indexPath.item]
        
        let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: "LikeProductCell", for: indexPath) as! LikeProductCell
        
        cell.marketNameLabel.text = product.marketName
        cell.productNameLabel.text = product.itemName
        cell.priceLabel.text = product.itemUnit + "당 \(product.itemPrice)원"
        
        if product.quick == 1 && product.delivery == 1 {
            cell.hashTag1Label.text = "#무료배송"
            cell.hashTag2Label.text = "#당일배송"
            
        } else {
            if product.quick == 1 {
                cell.hashTag1Label.text = "#당일배송"
                cell.hashTag2Label.text = ""
            } else {
                cell.hashTag1Label.text = "#무료배송"
                cell.hashTag2Label.text = ""
            }
        }
        cell.titleImageView.imageFromUrl(product.fileKey, defaultImgPath: "")
        cell.marketNameLabel.sizeToFit()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            return CGSize(width: (self.view.frame.width - 25) / 2, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destvc = UIStoryboard(name: "ProductDetail", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        
        self.present(destvc, animated: true, completion: nil)
        
    }
}
