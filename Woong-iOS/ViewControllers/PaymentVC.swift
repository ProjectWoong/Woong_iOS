//
//  PaymentVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 2..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class PaymentVC: UIViewController {

    var orderProductArr = ["왕감자","왕감자","왕감자","왕감자"]
    
    @IBOutlet var OrderProductTableView: UITableView!
    @IBOutlet var shadowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.isHidden = true
        setTableView()
    }
    
    @IBAction func payMethodAction(_ sender: UIButton) {
        shadowView.isHidden = false
    }
    
    @IBAction func okAction(_ sender: UIButton) {
        shadowView.isHidden = true
    }
    
    private func setTableView() {
        OrderProductTableView.delegate = self
        OrderProductTableView.dataSource = self
        
    }
    
}


extension PaymentVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderProductArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OrderProductTableView.dequeueReusableCell(withIdentifier: "OrderProductCell") as! OrderProductCell
        
        return cell
    }
    
    
}





