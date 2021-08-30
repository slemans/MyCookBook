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
        Auth.auth().addStateDidChangeListener({ [weak self] (auth, user) in
            if user != nil {
                self?.performSegue(withIdentifier: "BarBatonSegue", sender: nil)
                self?.dismiss(animated: true, completion: nil)
            }
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
            displayWarningText(text: "User does not exist")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] (user, error) in
            if error != nil {
                self?.displayWarningText(text: "Error occured")
                return
            }
            if user != nil {
                self?.performSegue(withIdentifier: "BarBatonSegue", sender: nil)
                self?.dismiss(animated: true, completion: nil)
                return
            }
            self?.displayWarningText(text: "No such user")
        })
    }
    @IBAction func registrationBtAct() {
        performSegue(withIdentifier: "singUpSegue", sender: nil)
        dismiss(animated: true, completion: nil)
    }



    private func openingSeting() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        errorLB.alpha = 0.0
        singInLB.alpha = 0.0
        singInBT.layer.cornerRadius = Border.borderRadius
        UIView.animate(withDuration: 1.05) {
            self.singInLB.alpha = 1.0
        }
    }

}

// Warning
extension SingInVC {
    private func displayWarningText(text: String) {
        errorLB.text = text
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.errorLB.alpha = 1.0
        }) { [weak self] complete in
            self?.errorLB.alpha = 0
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
