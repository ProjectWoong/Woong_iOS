//
//  MessageVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 4..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class MessageVC: UIViewController {

    var row = 9
    var section = 0
    
    @IBOutlet var messageTableView: UITableView!
    @IBOutlet var messageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTextView()
        scrollToBottom()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.row, section: self.section)
            self.messageTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    private func setupTableView(){
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.tableFooterView = UIView(frame: .zero)
        messageTableView.separatorStyle = .none
    }
    
    private func setupTextView() {
        messageTextView.delegate = self
        
        let tapDidsmiss = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.messageTableView.addGestureRecognizer(tapDidsmiss)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func sendAction(_ sender: UIButton) {
        row = row + 1
        messageTableView.reloadData()
        scrollToBottom()
    }
}

extension MessageVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return row + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0{
            let cell = messageTableView.dequeueReusableCell(withIdentifier: "SendMessageCell") as! SendMessageCell
            
            return cell
        } else {
            let cell = messageTableView.dequeueReusableCell(withIdentifier: "RecieveMessageCell") as! RecieveMessageCell
            
            return cell
            
        }
    }
}


extension MessageVC: UITextViewDelegate {
    
    @objc func dismissKeyboard() {
        messageTextView.resignFirstResponder()
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
