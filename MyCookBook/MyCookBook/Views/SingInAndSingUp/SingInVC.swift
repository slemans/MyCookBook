//
//  SingInVC.swift
//  MyCookBook
//
//  Created by sleman on 27.08.21.
//

import UIKit

class SingInVC: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorLB: UILabel!
    @IBOutlet weak var singInBT: UIButton!
    @IBOutlet weak var singInLB: UILabel!
    
    private let BoolFalse = false
    private let Booltrue = true
    private var isValidEmail = false
    private var isValidPass = false
    
    
    override func viewDidLoad() {
        openingSeting()
        startKeyboardObserver()
    }
    
    
    @IBAction func emailTextFielAct(_ sender: UITextField) {
        isValidEmail = emailCheckUsedDefault(email: sender.text)
    }
    
    @IBAction func passwordTextFielAct(_ sender: UITextField) {
        isValidPass = passCheckUsedDefault(pass: sender.text)
    }
    
    @IBAction func singIngAction() {
        if isValidEmail == true && isValidPass == true {
            performSegue(withIdentifier: "segueApp", sender: nil)
            errorLB.isHidden = Booltrue
            // поменять тру на фолс когда залогинится
            

        } else {
            errorLB.isHidden = BoolFalse
            errorLB.text = "User does not exist"
        }
    }
    
    
    private func emailCheckUsedDefault(email: String?) -> Bool {
        guard let emailTwo = email else { return false }
        return "1" == emailTwo
    }
    private func passCheckUsedDefault(pass: String?) -> Bool {
        guard let passTwo = pass else { return false }
        return "1" == passTwo
    }
    
    private func openingSeting() {
        singInLB.alpha = 0.0
        singInBT.layer.cornerRadius = Border.borderRadius
        UIView.animate(withDuration: 1.05) {
            self.singInLB.alpha = 1.0
        }
    }
    
}

// Work with keyboord
extension SingInVC{
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y = 100 - keyboardSize.height
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}
