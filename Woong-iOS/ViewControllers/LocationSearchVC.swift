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
    var addressArr = ["서울시 마포구 상수동 22-1", "서울시 은평구 대조동 84-21" , "서울시 노원구 공릉동 91-32", "서울시 은평구 역촌동 82-21"]
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo1LCJlbWFpbCI6ImlvczEyM0BhLmEiLCJpYXQiOjE1MzE0NzE5MjEsImV4cCI6ODc5MzE0NzE5MjEsImlzcyI6InNlcnZpY2UiLCJzdWIiOiJ1c2VyX3Rva2VuIn0.oc7hYEU76E5_gON6XynUlHaJfjg6PW48m0a8PKeQoIM"
    
    var searchAddress: [Address] = []
    var flag = false
    
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
        searchBarTxtFd.addTarget(self, action: #selector(search(_:)), for: .editingChanged)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func search(_ sender: UITextField) {
        if let searchText = sender.text {
            if searchText == "" {
                flag = false
                return
            }
            flag = true
            KakaoAddressService.shareInstance.searchAddressWithKeyword(query: searchText, completion: { data in
                self.searchAddress = data
                self.searchTableView.reloadData()
            }) { (errCode) in
                self.simpleAlert(title: "네트워크 오류", message: "서버가 응답하지 않습니다.")
            }
        }
    }
    
}

extension LocationSearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !flag {
            return addressArr.count
        } else {
            return searchAddress.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LocationSearchCell
        if !flag {
            cell.addressLabel.text = addressArr[indexPath.row]
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteCellFromButton(button:)), for: .touchUpInside)
            
        } else {
            cell.addressLabel.text = searchAddress[indexPath.row].placeName
            cell.roadAddressLabel.text = searchAddress[indexPath.row].roadAddressName
            cell.deleteButton.isHidden = true
            
        }
        return cell
    }
    
    @objc func deleteCellFromButton(button: UIButton) {
        addressArr.remove(at: button.tag)
        searchTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        simpleAlertWithCompletion(title: "배달 받을 주소가 맞나요?", message: "", okCompletion: { (_) in
            let address = self.searchAddress[indexPath.row]
            let body = [
                "latitude" : address.x,
                "longitude" : address.y,
                "address" : address.addressName
            ]
            LocationService.shareInstance.setLocation(body: body, token: self.token, completion: {
                    print("성공")
            }) { (errCode) in
                print("nonono")
            }
            self.dismiss(animated: true, completion: nil)
        }, cancelCompletion: nil)
        
    }
    
}
