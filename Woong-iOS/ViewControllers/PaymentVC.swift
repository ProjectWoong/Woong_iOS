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
    let paymentFailImage = UIImage(named: "payment-fail-character")
    let paymentNoSelectImage = UIImage(named: "payment-no-select-character")
    @IBOutlet var OrderProductTableView: UITableView!
    @IBOutlet var shadowView: UIView!
    
    @IBOutlet weak var phoneNumView: UIView!
    @IBOutlet weak var requestView: UIView!

    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var requestTextField: UITextField!
    
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var popupImageView: UIImageView!
    
    @IBOutlet weak var popupLabel: UILabel!
    
    @IBOutlet weak var okButton: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "결제 페이지"
        shadowView.isHidden = true
        
        phoneNumView.layer.masksToBounds = true
        phoneNumView.layer.cornerRadius = 35/2
        phoneNumView.layer.borderWidth = 1
        phoneNumView.layer.borderColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
        
        requestView.layer.masksToBounds = true
        requestView.layer.cornerRadius = 35/2
        requestView.layer.borderWidth = 1
        requestView.layer.borderColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
        
        okButton.layer.masksToBounds = true
        okButton.layer.cornerRadius = 20/667 * self.view.frame.height
        
        alertView.layer.masksToBounds = true
        alertView.layer.cornerRadius = 5
        
        setTableView()
        setupTextField()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func payMethodAction(_ sender: UIButton) {
        shadowView.isHidden = false
        popupImageView.image = paymentFailImage
        popupLabel.text = "죄송합니다\n서비스를 준비중입니다"
    }
    
    @IBAction func okAction(_ sender: UIButton) {
        shadowView.isHidden = true
    }
    
    private func setTableView() {
        OrderProductTableView.delegate = self
        OrderProductTableView.dataSource = self
        
    }
    private func setupTextField() {
        phoneNumTextField.delegate = self
        requestTextField.delegate = self
        let tapDidsmiss = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapDidsmiss)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
}


extension PaymentVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == phoneNumTextField {
            requestTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @objc func dismissKeyboard() {
        phoneNumTextField.resignFirstResponder()
        requestTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if let keyboardFrame: NSValue = sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y = -keyboardHeight
        }
        
        // = -250  // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
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





