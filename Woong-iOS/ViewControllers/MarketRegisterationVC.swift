//
//  MarketRegisterationVC.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 8..
//  Copyright © 2018년 Leess. All rights reserved.
//

import UIKit

class MarketRegisterationVC: UIViewController {
       let imagePicker : UIImagePickerController = UIImagePickerController()
    
    @IBOutlet var registerationView: UIView!
    @IBOutlet var hint1View: UIView!
    @IBOutlet var hint2View: UIView!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var registerationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerationView.layer.borderWidth = 1
        registerationView.layer.borderColor = #colorLiteral(red: 0.6784313725, green: 0.6784313725, blue: 0.6784313725, alpha: 1)
        hint1View.isHidden = true
        hint2View.isHidden = true
        registerationButton.layer.cornerRadius = 24/667 * self.view.frame.height
    }
    
    @IBAction func photoAddAction(_ sender: UIButton) {
        openGallery()
    }
    
    @IBAction func hintAction(_ sender: UIButton) {
        
//        self.hint1View.isHidden = false
//         self.hint1View.alpha = 1
//        UIView.animate(withDuration: 2, delay:4, options:UIViewAnimationOptions.transitionFlipFromTop, animations: {
//            self.hint1View.alpha = 0
//        }, completion: { finished in
//            self.hint1View.isHidden = true
//
//        })

       
//        if sender.tag == 10 {
//            hint1View.fadeIn(type: .Normal) {
//                UIView.animate(withDuration: 2.0, delay: 10.0, options: .transitionFlipFromTop, animations: {
//                    self.hint1View.fadeOut(type: .Normal, completed: nil)
//                })
//            }
//        } else {
//            hint2View.fadeIn(type: .Normal) {
//                self.hint2View.fadeOut(type: .Slow, completed: nil)
//            }
//        }
    }
}

extension MarketRegisterationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            self.photoImageView.image = editedImage
        } else if let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.photoImageView.image = originalImage
        }
        self.dismiss(animated: true) {
            print("이미지피커 사라짐")
        }
    }
    
    
}
