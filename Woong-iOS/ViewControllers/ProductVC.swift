//
//  ProductVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class ProductVC: UIViewController {
    var mainId = 0
    var subId = 0
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo1MCwiZW1haWwiOiJwa3NlMTIxM0BhLmEiLCJpYXQiOjE1MzE0NTk3NjgsImV4cCI6ODc5MzE0NTk3NjgsImlzcyI6InNlcnZpY2UiLCJzdWIiOiJ1c2VyX3Rva2VuIn0.Uktksh977X0jTKtL-aeK1q7g1b0vVBnHfuZ-pUfg8MI"
    let likeImage = UIImage(named: "product-like")
    let unlikeImage = UIImage(named: "product-not-like")
    
    @IBOutlet weak var rangeView: UIView!
    @IBOutlet weak var rangeSegment: UISegmentedControl!
    
    var productList: [Product] = []
    
        @IBOutlet var productCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupCollectionView()
        rangeView.applyShadow(radius: 10, color: .black, offset: CGSize(width: 0, height: 10), opacity: 0.1)
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFEB", size: 17)!]
    }
    
    private func setupData() {
        ProductService.shareInstance.getProductList(token: token, mainId: mainId, subId: subId, completion: { (res) in
            self.productList = res.itemInfo
            self.productCollectionView.reloadData()
            
            
            print("product리스트 성공")
        }) { (errCode) in
            print("product리스트 오류")
            
        }
    }
    
    
    private func setupCollectionView() {
        self.productCollectionView.delegate = self
        self.productCollectionView.dataSource = self
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
        
        cell.heartImageView.tag = product.itemID
        
        cell.heartImageView.addTarget(self, action: #selector(deleteBookMarkFromButton(button:)), for: .touchUpInside)
        
        
        
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
    
    @objc func deleteBookMarkFromButton(button: UIButton) {
        
        if button.currentBackgroundImage == likeImage {
            button.setBackgroundImage(unlikeImage, for: .normal)
            //            if let token = ud.string(forKey: "token") {
            FavoriteOperateService.shareInstance.deleteFavoriteList(productId: button.tag, token: self.token, completion: {
                print("성공태그\(button.tag)")
            })
            { (errCode) in
                self.simpleAlert(title: "서버와 연결할 수 없습니다", message: "")
            }
            //            }
            
        } else if button.currentBackgroundImage == unlikeImage{
            button.setBackgroundImage(likeImage, for: .normal)
            //            if let token = ud.string(forKey: "token") {
            
            FavoriteOperateService.shareInstance.setFavoriteList(productId: button.tag, token: self.token, completion: { (res) in
                
            }) { (errCode) in
                self.simpleAlert(title: "서버와 연결할 수 없습니다", message: "")
            }
            //            }
        }
        
    }

}
