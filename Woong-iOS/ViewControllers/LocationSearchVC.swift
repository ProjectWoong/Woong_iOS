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
    var addressArr = ["마포구 상수동 22-1", "은평구 대조동 84-21" , "공릉동 91-32","역촌동 12-32"]
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
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension LocationSearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LocationSearchCell
        cell.addressLabel.text = addressArr[indexPath.row]
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteCellFromButton(button:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func deleteCellFromButton(button: UIButton) {
        addressArr.remove(at: button.tag)
        searchTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = searchTableView.cellForRow(at: indexPath) as! LocationSearchCell
        cell.setSelected(!cell.isSelected, animated: true)
        
        simpleAlert(title: "배달 받을 주소가 맞나요?", message: "", okCompletion: { (_) in
           let address = cell.addressLabel.text!
            
            self.dismiss(animated: true, completion: {
                NotificationCenter.default.post(name: Notification.Name("SetupAddress"), object: address)
                
            })
            
        }, cancelCompletion: nil)
        
    }
}
