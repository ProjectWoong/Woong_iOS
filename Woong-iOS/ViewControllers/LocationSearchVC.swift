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
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo1MCwiZW1haWwiOiJwa3NlMTIxM0BhLmEiLCJpYXQiOjE1MzE0NTk3NjgsImV4cCI6ODc5MzE0NTk3NjgsImlzcyI6InNlcnZpY2UiLCJzdWIiOiJ1c2VyX3Rva2VuIn0.Uktksh977X0jTKtL-aeK1q7g1b0vVBnHfuZ-pUfg8MI"
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
        
        
        simpleAlertWithCompletion(title: "배달 받을 주소가 맞습니까?", message: "", okCompletion: { (_) in
            let address = cell.addressLabel.text!
 
            // 수정~~~~~~~~~
            
            //        if let token = ud.string(forKey: "token"){
            LocationService.shareInstance.setLocation(body: [
                "latitude": 35.9078,
                "longitude": 127.7669,
                "address": address
                ], token: self.token, completion: {
                    print("성공")
            }) { (errCode) in
                print("nonono")
        }
            self.dismiss(animated: true, completion: nil)
        }, cancelCompletion: nil)
        
       
        
        
//        simpleAlert(title: "배달 받을 주소가 맞나요?", message: "", okCompletion: { (_) in
//           let address = cell.addressLabel.text!
//
//
//            })
//
//        }, cancelCompletion: nil)
    }
    
}
