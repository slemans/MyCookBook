//
//  SIngUpVC.swift
//  MyCookBook
//
//  Created by sleman on 28.08.21.
//

import UIKit

class SIngUpVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var registrationBt: UIButton!
    @IBOutlet weak var registrationLB: UILabel!
    @IBOutlet weak var errorLbEmailAlready: UILabel!
    @IBOutlet weak var errorLbEmail: UILabel!
    @IBOutlet weak var errorLbPasword: UILabel!
    @IBOutlet weak var errorLbEconPass: UILabel!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var econfirmPasTf: UITextField!
    @IBOutlet var verifPassLine: [UIView]!
    
    private var isValidEmail = false
    private var passwordStrenngth: PasswordLine = .veryWeak
    private var isValidEconfPass = false
    
    var passworUser: String?
    var nameUser: String?
    var emailUser: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openingSeting()
        startKeyboardObserver()
    }
    
    @IBAction func emailTexFieldAction(_ sender: UITextField) {
        isValidEmail = Registration.checkEmail(sender.text)
        errorLbEmail.isHidden = isValidEmail
        registrationBt.isUserInteractionEnabled = isValidEmail
        checkValidTf()
    }
    @IBAction func passwordTextFieldAction(_ sender: UITextField) {
        guard let pass = sender.text else { return }
        passwordStrenngth = Registration.checkPassword(pass: pass)
        errorLbPasword.isHidden = !(passwordStrenngth == .veryWeak)
        verifPassLine.enumerated().forEach { (index, view) in
            if (index < (passwordStrenngth.rawValue)) {
                view.alpha = 1
            } else {
                view.alpha = 0.1
            }
        }
        checkConfPass()
        checkValidTf()
    }
    @IBAction func passwordEconTextFieldAction(_ sender: UITextField) {
        checkConfPass()
        checkValidTf()
    }
    @IBAction func registrationBtAction() {
        if emailCheckUsedDefault(emailTf.text) == false {
            guard let email = emailTf.text,
                  let password = passwordTf.text else { return }
            Registration.newUser = User(name: nameTf.text, email: email, password: password)
            performSegue(withIdentifier: "singUpSegue", sender: nil)
        } else {
            errorLbEmailAlready.isHidden = false
        }
    }
    private func emailCheckUsedDefault(_ emeil: String?) -> Bool {
        guard let emailTwo = emeil else { return false }
        return emailTwo == Registration.userEmail
    }
    
    
    
    
    
    private func checkConfPass() {
        isValidEconfPass = Registration.checkEconPass(passwordTf.text, econfirmPasTf.text)
        errorLbEconPass.isHidden = isValidEconfPass
    }
    private func checkValidTf() {
        if isValidEmail == true && isValidEconfPass == true && (passwordStrenngth != .veryWeak) {
            registrationBt.isUserInteractionEnabled = true
            registrationBt.alpha = 1
        } else {
            registrationBt.isUserInteractionEnabled = false
            registrationBt.alpha = 0.2
        }
    }
    
    

    private func openingSeting() {
        registrationLB.alpha = 0.0
        registrationBt.layer.cornerRadius = Border.borderRadius
        UIView.animate(withDuration: 1.05) {
            self.registrationLB.alpha = 1.0
        }
    }
    
}

// Work with keyboord
extension SIngUpVC{
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(SIngUpVC.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SIngUpVC.keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize =
            (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    @objc func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
}
