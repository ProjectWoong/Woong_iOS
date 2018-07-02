//
//  MarketVC.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 1..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class MarketVC: UIViewController {
    
    let bigCellId = "BigCategoryCell"
    let smallCellId = "SmallCategoryCell"
    let bigCategory = ["과일", "곡물", "채소", "달걀/유제품"]
    
   
    
    @IBOutlet var bigCategoryCollectionView: UICollectionView!
    @IBOutlet var bigCategoryView: UIView!
    @IBOutlet var bigCategoryBar: UIView!
    
    
     var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    @IBOutlet var smallCategoryCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupHorizontalBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupCollectionView() {
        self.bigCategoryCollectionView.delegate = self
        self.bigCategoryCollectionView.dataSource = self
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        bigCategoryCollectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .init(rawValue: 0))
    }
    
    private func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor.rgb(red: 35, green: 122, blue: 89)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        bigCategoryView.addSubview(horizontalBarView)
        
        //horizontalBarLeftAnchorConstraint = bigCategoryBar.leftAnchor.
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: bigCategoryView.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: bigCategoryView.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: bigCategoryView.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    

}

extension MarketVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bigCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "BigCategoryCell", for: indexPath) as! BigCategoryCell
        cell.tintColor = UIColor.rgb(red: 173, green: 173, blue: 173)
        cell.categoryLabel.text = bigCategory[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        horizontalBarLeftAnchorConstraint?.constant = CGFloat(indexPath.item) * (self.view.frame.width / 4)
    }
    
    
    
    
    
}
