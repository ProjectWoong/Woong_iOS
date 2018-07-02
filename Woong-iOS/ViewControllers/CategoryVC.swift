//
//  CategoryVC.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 2..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {
    
    let bigCellId = "BigCategoryCell"
    let smallCellId = "SmallCategoryCell"
    let bigCategory = ["과일", "곡물", "채소", "달걀/유제품"]
    
    let sampleArr = ["감자", "고구마", "버섯", "옥수수", "오이", "호박", "당근", "양파", "대파"]
    
    @IBOutlet var bigCategoryCollectionView: UICollectionView!
    @IBOutlet var bigCategoryView: UIView!
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    @IBOutlet var smallCategoryCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.title = ""
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
        self.smallCategoryCollectionView.delegate = self
        self.smallCategoryCollectionView.dataSource = self
        
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

extension CategoryVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == smallCategoryCollectionView {
            return 1
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bigCategoryCollectionView {
            return bigCategory.count
        }
        else {
            return sampleArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bigCategoryCollectionView {
            let cell = bigCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: bigCellId, for: indexPath) as! BigCategoryCell
            cell.tintColor = UIColor.rgb(red: 173, green: 173, blue: 173)
            cell.bigCategoryLabel.text = bigCategory[indexPath.item]
            return cell
        } else {
            let cell = smallCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: smallCellId, for: indexPath) as! SmallCategoryCell
            cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.rgb(red: 225, green: 225, blue: 225) : UIColor.white
            cell.smallCategoryLabel.text = sampleArr[indexPath.row]
            cell.smallCategoryLabel.sizeToFit()
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == bigCategoryCollectionView {
            horizontalBarLeftAnchorConstraint?.constant = CGFloat(indexPath.item) * (self.view.frame.width / 4)
        }
    }
}
