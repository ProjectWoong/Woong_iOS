//
//  ProductVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 12..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class ProductVC: UIViewController {

    @IBOutlet weak var rangeView: UIView!
    @IBOutlet weak var rangeSegment: UISegmentedControl!
    var marketNameArr = ["현듀마켓", "세은마켓", "수정마켓", "혜란마켓", "세은마켓", "수정마켓", "세은마켓", "수정마켓"]
    var cartProductArr: [String] = ["왕감장","왕감장","왕감장", "고구마"]
    
    
        @IBOutlet var productCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()

       rangeView.applyShadow(radius: 10, color: .black, offset: CGSize(width: 0, height: 10), opacity: 0.1)
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
       
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFEB", size: 17)!]
    }
    
    private func setupCollectionView() {
        self.productCollectionView.delegate = self
        self.productCollectionView.dataSource = self
    }
    
    

}
extension ProductVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marketNameArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: "LikeProductCell", for: indexPath) as! LikeProductCell
        
        cell.marketNameLabel.text = marketNameArr[indexPath.row]
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
