//
//  MarketVC.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 1..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class MarketVC: UIViewController {
    @IBOutlet var categoryView: UIView!
    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var nearMarketTableView: UITableView!
    @IBOutlet var bookMarkTableView: UITableView!
    
    let likeImage = UIImage(named: "market-favorite-favorite")
    let unlikeImage = UIImage(named: "market-favorite-delete")
    
    let ud = UserDefaults.standard
    var nearMarketArr: [NearMarket] = []
    var bookMarkArr: [Bookmark] = []
    var collectionselectNum = 0
    let categoryArr = ["내 주변 마켓", "즐겨찾기"]
    
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    let horizontalBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 82, green: 156, blue: 119)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupView()
        setupCollectionView(num: collectionselectNum)
        
        setupTableView()
        setupHorizontalBar()
        setupNaviBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
        nearMarketTableView.reloadData()
        bookMarkTableView.reloadData()
        changeMenu(selectedIndexPath.item)
    }
    
    private func setupData() {
        if let token = ud.string(forKey: "token"){
            // 주변 마켓 데이터
            NearMarketService.shareInstance.getNearMarket(token: token, completion: { (nearMarket) in
                self.nearMarketArr = nearMarket
                print("내주변마켓 성공")
                self.nearMarketTableView.reloadData()
                
                
            }) { (errCode) in
                print("주변마켓 Xx")
                self.simpleAlert(title: "내주변마켓 x", message: "")
            }
            
            // 즐겨찾기 데이터
            
            BookmarkListService.shareInstance.getCartList(token: token, completion: { (bookMark) in
                self.bookMarkArr = bookMark
                print("즐겨찾기 성공")
                
                self.bookMarkTableView.reloadData()
            }) { (errCode) in
                self.bookMarkArr = []
            }
        }
        
    }
    
    private func setupNaviBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFEB", size: 17)!, NSAttributedStringKey.foregroundColor: UIColor.white]
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.barTintColor = .rgb(red: 82, green: 156, blue: 119)
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
    
    func changeMenu(_ flag: Int) {
        horizontalBarLeftAnchorConstraint?.constant = CGFloat(flag) * (self.view.frame.width / 2)
        if flag == 0 {
            nearMarketTableView.isHidden = false
            bookMarkTableView.isHidden = true
            setupData()
            nearMarketTableView.reloadData()
        } else  if flag == 1 {
            nearMarketTableView.isHidden = true
            bookMarkTableView.isHidden = false
            setupData()
            bookMarkTableView.reloadData()
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
        changeMenu(indexPath.item)
        
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
            return nearMarketArr.count
        } else {
            return bookMarkArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == nearMarketTableView {
            let cell = nearMarketTableView.dequeueReusableCell(withIdentifier: "NearMarketCell") as! NearMarketCell
            let market = nearMarketArr[indexPath.row]
            
            let tagArr = market.tagName.components(separatedBy: ",")
            cell.marketImageView.imageFromUrl(market.titleImageKey, defaultImgPath: "alarm-message-no-message")
            cell.marketNameLabel.text = market.marketName
            cell.hashTagLabel1.text = "#" + tagArr[1]
            cell.hashTagLabel2.text = "#" +  tagArr[0]
            
            return cell
        } else {
            let cell = bookMarkTableView.dequeueReusableCell(withIdentifier: "BookMarkCell") as! BookMarkCell
            let market = bookMarkArr[indexPath.row]
            cell.starButton.tag = market.marketId
            
            cell.starButton.addTarget(self, action: #selector(deleteBookMarkFromButton(button:)), for: .touchUpInside)
            cell.marketImageView.imageFromUrl(market.titleImageKey, defaultImgPath: "alarm-message-no-message")
            cell.marketNameLabel.text = market.marketName
            cell.marketAddressLabel.text = "[" + market.marketAddress + "]"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == nearMarketTableView {
            
            let marketId = nearMarketArr[indexPath.row].marketID
            let destvc = UIStoryboard(name: "Market", bundle: nil).instantiateViewController(withIdentifier: "SellerVC") as! SellerVC
            guard let token = self.ud.string(forKey: "token") else { return }
            MarketIntroService.shareInstance.getMarketIntro(index: marketId, token: token, completion: { (res) in
                destvc.marketIntro = res
                destvc.marketId = res.marketID
               self.navigationController?.pushViewController(destvc, animated: true)
                print("marketintro 성공")
            }) { (errCode) in
                print("marketintro 실패")
            }
        } else if tableView == bookMarkTableView {
            
            
            let marketId = bookMarkArr[indexPath.row].marketId
            let destvc = UIStoryboard(name: "Market", bundle: nil).instantiateViewController(withIdentifier: "SellerVC") as! SellerVC
            if let token = ud.string(forKey: "token") {
                MarketIntroService.shareInstance.getMarketIntro(index: marketId, token: token, completion: { (res) in
                    
                    destvc.marketIntro = res
                    destvc.marketId = res.marketID
                    self.navigationController?.pushViewController(destvc, animated: true)
                    print("marketintro 성공")
                }) { (errCode) in
                    print("marketintro 실패")
                }
            }
        }
    }
    
    @objc func deleteBookMarkFromButton(button: UIButton) {
        
        if button.currentBackgroundImage == likeImage {
            button.setBackgroundImage(unlikeImage, for: .normal)
            if let token = ud.string(forKey: "token") {
                BookmarkOperateService.shareInstance.deleteBookmarkList(productId: button.tag, token: token, completion: {
                    print("성공태그\(button.tag)")
                    self.simpleAlert(title: "즐겨찾기 등록이 해제되었습니다", message: "")
                }) { (errCode) in
                    self.simpleAlert(title: "서버와 연결할 수 없습니다", message: "")
                }
            }
            
        } else if button.currentBackgroundImage == unlikeImage{
            button.setBackgroundImage(likeImage, for: .normal)
            if let token = ud.string(forKey: "token") {
                BookmarkOperateService.shareInstance.setBookmarkList(productId: button.tag, token: token, completion: { (res) in
                    
                }) { (errCode) in
                    self.simpleAlert(title: "서버와 연결할 수 없습니다", message: "")
                }
            }
        }
        
    }
    
}
