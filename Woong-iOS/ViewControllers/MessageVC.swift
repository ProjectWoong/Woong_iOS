//
//  MessageVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 4..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class MessageVC: UIViewController {
    var chattingRoomId: Int = 0
           var marketId: Int = 0
    var ud = UserDefaults.standard
    var chatList: [Chat] = []
   
    @IBOutlet var messageTableView: UITableView!
    @IBOutlet var messageTextView: UITextView!
    @IBOutlet var messageView: UIView!
    @IBOutlet var messageRootView: UIView!
    
    @IBOutlet weak var textViewBottom: NSLayoutConstraint!
           
    override func viewDidLoad() {
        super.viewDidLoad()
        messageView.applyRadius(radius: messageView.frame.height/2)
        messageView.applyBorder(width: 1, color: #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1))
        dataInit()
        setupTableView()
        setupTextView()
    }
    
    private func dataInit() {
        if let token = ud.string(forKey: "token"){
            ChatMessageService.shareInstance.getChatList(roomId: chattingRoomId, token: token, completion: { (data) in
                self.chatList = data
                self.messageTableView.reloadData()
                self.scrollToBottom()
            }) { (errCode) in
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
     func scrollToBottom(){
        DispatchQueue.main.async {
            if self.chatList.count > 0{
                let indexPath = IndexPath(row: self.chatList.count - 1, section: 0)
                self.messageTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
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
       if messageTextView.text != "" {
           if let token = ud.string(forKey: "token"){
              let body: [String : Any] = [ "room_user_id": 1,
                                            "market_user_id": marketId,
                                            "content": messageTextView.text ]
              ChatMessageService.shareInstance.postChatList(body: body, token: token, completion: {
                 self.dataInit()
              }) { (errCode) in
                      
              }
           messageTextView.text = ""
           scrollToBottom()
           }
                      
      }
   }
}

extension MessageVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = chatList[indexPath.row]
        
        if message.sendUserID == 0 {
           let cell = messageTableView.dequeueReusableCell(withIdentifier: "SendMessageCell") as! SendMessageCell
            cell.messageTextView.text = message.content
            cell.timeLabel.text = message.date
            return cell
            
        } else {
            let cell = messageTableView.dequeueReusableCell(withIdentifier: "RecieveMessageCell") as! RecieveMessageCell
            cell.messageTextView.text = message.content
            cell.timeLabel.text = message.date
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
           self.textViewBottom.constant = keyboardHeight
           self.scrollToBottom()
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
            self.textViewBottom.constant = 0
    }
    
}
