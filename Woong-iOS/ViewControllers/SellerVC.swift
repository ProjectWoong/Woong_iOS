//
//  SellerVC.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 3..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class SellerVC: UIViewController {
    
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo1MCwiZW1haWwiOiJwa3NlMTIxM0BhLmEiLCJpYXQiOjE1MzE0NTk3NjgsImV4cCI6ODc5MzE0NTk3NjgsImlzcyI6InNlcnZpY2UiLCJzdWIiOiJ1c2VyX3Rva2VuIn0.Uktksh977X0jTKtL-aeK1q7g1b0vVBnHfuZ-pUfg8MI"
    
    let menuCellId = "SellerMenuCell"
    let introCellId = "SellerIntroCell"
    let productCellId = "SellerProductCell"
    let albumCellId = "SellerAlbumCell"
    let reviewCellId = "SellerReviewCell"
    let menu = ["소개", "물품", "앨범", "후기"]
    
    let ud = UserDefaults.standard
    var marketIntro: MarketIntro?
    var marketProductList: [MarketProduct] = []
    var marketAlbumList: [MarketAlbum] = []
    var marketId: Int?
    
    var flag = 0
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    var sellerMenuConstraint: NSLayoutConstraint?
    
    
    @IBOutlet weak var marketNameLabel: UILabel!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet var sellerMenuTopConstraint: NSLayoutConstraint!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var sellerProfileView: UIView!
    @IBOutlet var sellerMenuCollectionView: UICollectionView!
    @IBOutlet var sellerMenuView: UIView!
    @IBOutlet var sellerProfileImage: UIImageView!
    @IBOutlet var sellerInfoCollectionView: UICollectionView!
   
    @IBOutlet weak var hashTag1Label: UILabel!
    @IBOutlet weak var hashTag2Label: UILabel!
    @IBOutlet weak var hashTag1View: UIView!
    @IBOutlet weak var hashTag2View: UIView!
    
    
    
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
        initMarketData()
        setupView()
        setupCollectionView()
        setupHorizontalBar()
        setupNavi()
    }
    @IBAction func bookMarkAction(_ sender: UIButton) {
        
        let likeimage = UIImage(named: "market-intro-not-favorite")
        let unlikeimage = UIImage(named: "market-intro-favorite")
        
        if sender.currentBackgroundImage == likeimage {
            sender.setBackgroundImage(unlikeimage, for: .normal)
            BookmarkOperateService.shareInstance.deleteBookmarkList(productId: self.marketId!, token: self.token, completion: {
            }) { (_) in
            }
            
        } else if sender.currentBackgroundImage == unlikeimage {
            sender.setBackgroundImage(likeimage, for: .normal)
            BookmarkOperateService.shareInstance.setBookmarkList(productId: self.marketId!, token: self.token, completion: { (_) in
                
            }) { (_) in
                
            }
        }
        
    }
    
    private func initMarketData() {
        MarketIntroService.shareInstance.getMarketIntro(index: gino(marketId), token: self.token, completion: { (data) in
            self.marketIntro = data
         
            self.marketNameLabel.text = data.marketName
            self.kmLabel.text = data.youandi + "km"
            if data.quick == 1 && data.delivery == 1 {
            } else {
                self.hashTag2View.isHidden = true
                if data.quick == 1 {
                    self.hashTag1Label.text = "#당일배송"
                }
            }
        }) { (errCode) in
            if errCode == 500 {
                self.simpleAlert(title: "네트워크 오류", message: "서버가 응답하지 않습니다.")
            }
        }
        MarketProductService.shareInstance.getMarketProduct(index: gino(marketId), option: "name", completion: { (data) in
            self.marketProductList = data
        }) { (errCode) in
            
        }
        MarketAlbumService.shareInstance.getMarketAlbum(index: gino(marketId), completion: { (data) in
            self.marketAlbumList = data
        }) { (errCode) in
            
        }
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
        } else if flag == 1 {
            if let flowLayout = sellerInfoCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.minimumLineSpacing = 24
                flowLayout.minimumInteritemSpacing = 9
            }
            sellerInfoCollectionView.contentInset = UIEdgeInsetsMake(8, 8, 8, 8)
            sellerInfoCollectionView.reloadData()
        } else if flag == 2 {
            if let flowLayout = sellerInfoCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.minimumLineSpacing = 0
                flowLayout.minimumInteritemSpacing = 0
            }
            sellerInfoCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            sellerInfoCollectionView.reloadData()
        } else {
            if let flowLayout = sellerInfoCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.minimumLineSpacing = 0
                flowLayout.minimumInteritemSpacing = 0
            }
            sellerInfoCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            sellerInfoCollectionView.reloadData()
        }
    }
    
    func changeMenuColor(_ sender: Any) {
        for i in 0 ..< menu.count {
            let cell = sellerMenuCollectionView.cellForItem(at: IndexPath(item: i, section: 0)) as! SellerMenuCell
            cell.setSelectedColor(UIColor.black)
            sellerMenuCollectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .init(rawValue: 0))
        }
    }
    
    private func setupView() {
        sellerProfileImage.applyRadius(radius: sellerProfileImage.frame.height/2)
        sellerProfileImage.applyBorder(width: 2, color: .rgb(red: 82, green: 156, blue: 119))
    }
    
    private func setupNavi() {
        let closeImage = UIImage(named: "register-location-list-1-close")
        let rightBarBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(dismissAction))
        rightBarBtn.setBackgroundImage(closeImage, for: .normal, barMetrics: .default)
        
        
        self.navigationItem.rightBarButtonItem = rightBarBtn
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.alpha = 1.0
        //self.navigationController?.navigationBar.isTranslucent = true
    }
    @objc func dismissAction(){
        
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
   
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
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
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                self.navigationController?.navigationBar.alpha = 1.0
            
                self.scrollView.bounces = true
            } else if scrollY >= 184 {
                let image = getImageWithColor(color: .rgb(red: 82, green: 156, blue: 119), size: CGSize(width: view.frame.width, height: (self.navigationController?.navigationBar.frame.height)!))
                self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
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
            } else if flag == 2 {
                return CGSize(width: self.view.frame.width, height: 223)
            } else {
                return CGSize(width: self.view.frame.width, height: self.view.frame.width)
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
                return marketProductList.count
            } else if flag == 2{
                return 6
            } else {
                return 1
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
                if let market = marketIntro {
                    let tagArr = market.tagName.components(separatedBy: ",")
                    cell.hashTag1Label.text = "#" + tagArr[1]
                    cell.hashTag2Label.text = "#" +  tagArr[0]
                    cell.helloMessageLabel.text = market.marketInfo
                    
                }
                return cell
            } else if flag == 1 {
                let cell = sellerInfoCollectionView.dequeueReusableCell(withReuseIdentifier: productCellId, for: indexPath) as! SellerProductCell
               
                let product = marketProductList[indexPath.item]
                
                cell.marketNameLabel.text = "[" + product.marketName + "]"
                cell.productNameLabel.text = product.productName
                cell.priceLabel.text = product.packaging
               
               cell.likeImageButton.tag = product.productID
                cell.likeImageButton.addTarget(self, action: #selector(deleteBookMarkFromButton(button:)), for: .touchUpInside)
                
                return cell
            } else if flag == 2 {
                let cell = sellerInfoCollectionView.dequeueReusableCell(withReuseIdentifier: albumCellId, for: indexPath) as! SellerAlbumCell
                return cell
            } else {
                let cell = sellerInfoCollectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath)
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
    
    @objc func deleteBookMarkFromButton(button: UIButton) {
        let likeImage = UIImage(named: "product-like")
        let unlikeImage = UIImage(named: "product-not-like")
        
        if button.currentBackgroundImage == likeImage {
            button.setBackgroundImage(unlikeImage, for: .normal)
            FavoriteOperateService.shareInstance.deleteFavoriteList(productId: button.tag, token: self.token, completion: {
                print("찜삭제 성공!")
            }) { (errCode) in
                print("찜삭제 실패!")
            }
            
        } else if button.currentBackgroundImage == unlikeImage{
            button.setBackgroundImage(likeImage, for: .normal)
            FavoriteOperateService.shareInstance.setFavoriteList(productId: button.tag, token: token, completion: { (_) in
                print("찜하기 성공!")
            }) { (errCode) in
                print("찜하기 성공!")
            }
           
        }
    }
}
