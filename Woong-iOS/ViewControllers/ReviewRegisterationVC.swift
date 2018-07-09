//
//  ReviewRegisterationVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 4..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class ReviewRegisterationVC: UIViewController {
    @IBOutlet var reviewView: UIView!
    @IBOutlet var reviewTextView: UITextView!
    @IBOutlet var reviewImageCollectionView: UICollectionView!

    @IBOutlet var deliverySpeedButtonArr: [UIButton]!
    
    @IBOutlet var tastyButtonArr: [UIButton]!
    
    let rateArr = ["1", "2", "3", "4", "5"]
    
    @IBOutlet var deliveryRateLabel: UILabel!
    
    let imagePicker : UIImagePickerController = UIImagePickerController()
    var reviewImageArr: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        setupCollectionView()
    }
    
    private func setupTextView() {
        reviewTextView.delegate = self
        if reviewTextView.text == "" {
            textViewDidEndEditing(reviewTextView)
        }
        
        let tapDidsmiss = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.reviewView.addGestureRecognizer(tapDidsmiss)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    private func setupCollectionView(){
        reviewImageCollectionView.delegate = self
        reviewImageCollectionView.dataSource = self
    }
    @IBAction func openImagePicker(_ sender: UIButton) {
        openGallery()
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deliveryRateAction(_ sender: UIButton) {
        deliveryRateLabel.text = "aa"
        
    }
    
}

extension ReviewRegisterationVC: UITextViewDelegate {
    
    @objc func dismissKeyboard() {
        reviewTextView.resignFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "식품은 만족스러우셨나요? 식품의 장점과 아쉬운 점을 다른사람에게 알려주세요. 작성하신 후기는 지금 구매를 고민하는 사람에게 큰 도움이 됩니다."
            textView.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        textView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "식품은 만족스러우셨나요? 식품의 장점과 아쉬운 점을 다른사람에게 알려주세요. 작성하신 후기는 지금 구매를 고민하는 사람에게 큰 도움이 됩니다." {
            textView.text = ""
            textView.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        textView.becomeFirstResponder()
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        
        self.view.frame.origin.y = -250  // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
}

extension ReviewRegisterationVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewImageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = reviewImageCollectionView.dequeueReusableCell(withReuseIdentifier: "reviewImageCell", for: indexPath) as! reviewImageCell
        cell.reviewImageView.image = reviewImageArr[indexPath.row]
        cell.removeButton.tag = indexPath.row
        cell.removeButton.addTarget(self, action: #selector(deleteCellFromButton(button:)), for: .touchUpInside)
        
        return cell
    }
    @objc func deleteCellFromButton(button: UIButton) {
        reviewImageArr.remove(at: button.tag)
        reviewImageCollectionView.reloadData()
    }
}

extension ReviewRegisterationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            
            // false이면 이미지를 자르지 않고
            // true면 자유자제로 크롭 가능
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: { print("이미지 피커 나옴") })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("사용자가 취소함")
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //        defer {
        //            self.dismiss(animated: true) {
        //                print("이미지 피커 사라짐")
        //            }
        //        }
        
        if let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            reviewImageArr.append(editedImage)
        } else if let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            reviewImageArr.append(originalImage)
        }
        self.dismiss(animated: true) {
            self.reviewImageCollectionView.reloadData()
        }
    }
    

}
