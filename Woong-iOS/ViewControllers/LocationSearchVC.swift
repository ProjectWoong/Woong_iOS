//
//  LocationSearchVC.swift
//  Woong-iOS
//
//  Created by Leeseungsoo on 2018. 7. 4..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class LocationSearchVC: UIViewController {
    
    let cellId = "LocationSearchCell"
    
    @IBOutlet var searchBarView: UIView!
    @IBOutlet var searchBarTxtFd: UITextField!
    
    @IBOutlet var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    private func setupView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchBarView.applyRadius(radius: 15)
    }
    
    
}

extension LocationSearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LocationSearchCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        simpleAlert(title: "배달 받을 주소가 맞나요?", message: "", okCompletion: nil, cancelCompletion: nil)
        let cell = searchTableView.cellForRow(at: indexPath)
        if let check = cell?.isSelected {
            cell?.setSelected(!check, animated: true)
        }
        
        
    }
    
    
}
