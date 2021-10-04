//
//  SingInVC.swift
//  MyCookBook
//
//  Created by sleman on 27.08.21.
//

import UIKit
import Firebase

class SingInVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var singInBT: UIButton!
    @IBOutlet weak var singInLB: UILabel!
    @IBOutlet weak var inLb: UILabel!
    @IBOutlet weak var paswordAndEmaileErrorLb: UILabel!
    
    private let BoolFalse = false
    private let Booltrue = true
    private var isValidEmail = false
    private var isValidPass = false


    override func viewDidLoad() {
        openingSeting()
        startKeyboardObserver()
        
        
        Auth.auth().addStateDidChangeListener({ [weak self] _, user in
            guard let _ = user else { return }
            let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
            controller.modalPresentationStyle = .fullScreen
            self?.present(controller, animated: true, completion: nil)
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTF.text = ""
        passwordTF.text = ""
    }

    @IBAction func singIngAction() {
        guard let email = emailTF.text,
            let password = passwordTF.text,
            email != "", password != "" else {
            displayWarningText(text: "Email or password is not correct")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] user, error in
            if let _ = error {
                self?.displayWarningText(text: "User is not found")
                return
            } else if let _ = user {
                // self?.performSegue(withIdentifier: "BarBatonSegue", sender: nil)
                //  self?.dismiss(animated: true, completion: nil)
                return
            } else {
                self?.displayWarningText(text: "Email or password is not correct")
            }
        })
    }
    @IBAction func registrationBtAct() {
        performSegue(withIdentifier: Constants.Segues.singUp, sender: nil)
        dismiss(animated: true, completion: nil)
    }
    fileprivate func openingSeting() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        paswordAndEmaileErrorLb.alpha = 0.0
        singInLB.alpha = 0.0
        inLb.alpha = 0.0
        singInBT.layer.cornerRadius = Border.borderRadius
        UIView.animate(withDuration: 1.05) { [weak self] in
            self?.singInLB.alpha = 1.0
            self?.inLb.alpha = 1.0
        }
    }

}

// Warning
extension SingInVC {
    private func displayWarningText(text: String) {
        paswordAndEmaileErrorLb.text = text
        UIView.animate(withDuration: 4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.paswordAndEmaileErrorLb.alpha = 1.0
        }) { [weak self] complete in
            self?.paswordAndEmaileErrorLb.alpha = 0
        }
    }
}


// Work with keyboord
extension SingInVC {
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y = 20 - keyboardSize.height
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

}

// remove keyboard
extension SingInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
