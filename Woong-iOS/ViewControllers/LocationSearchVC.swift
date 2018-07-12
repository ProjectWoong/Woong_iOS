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
    var arr = ["a", "b" , "c","d"]
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
        searchBarView.applyRadius(radius: 17.5)
        searchTableView.tableFooterView = UIView(frame: .zero)
        searchTableView.separatorStyle = .none
    }
}

extension LocationSearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LocationSearchCell
        
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteCellFromButton(button:)), for: .touchUpInside)
        
        return cell
    }
    @objc func deleteCellFromButton(button: UIButton) {
        arr.remove(at: button.tag)
        searchTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        simpleAlertWithCompletion(title: "배달 받을 주소가 맞나요?", message: "", okCompletion: nil, cancelCompletion: nil)
        let cell = searchTableView.cellForRow(at: indexPath)
        if let check = cell?.isSelected {
            cell?.setSelected(!check, animated: true)
        }
    }
    
    
}
