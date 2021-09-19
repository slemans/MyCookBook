//
//  SIngUpVC.swift
//  MyCookBook
//
//  Created by sleman on 28.08.21.
//

import UIKit
import Firebase

class Register: UIViewController {

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

//    var passworUser: String?
//    var nameUser: String?
//    var emailUser: String?
//    var newUser: User!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        openingSeting()
        startKeyboardObserver()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTf.text = ""
        nameTf.text = ""
        passwordTf.text = ""
        econfirmPasTf.text = ""
    }
    @IBAction func emailTexFieldAction(_ sender: UITextField) {
        isValidEmail = Registration.checkEmail(sender.text)
        if isValidEmail == false {
            displayWarningLabelEmail(withText: "Wrong Email")
        }
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
        if isValidEmail == true && isValidEconfPass == true {
            guard let email = emailTf.text,
                let password = passwordTf.text
                /* let name = nameTf.text */ else { return }
            Auth.auth().createUser(withEmail: email,
                password: password,
                completion: { [weak self] (user, error) in
                    if let error = error {
                        self?.displayWarningLabelEmail(withText: "\(error.localizedDescription)")
                    } else {
                        // guard let user = user else { return } // delete
                        self?.performSegue(withIdentifier: Constants.Segues.start, sender: nil)
                    }
                })
            // newUser = User(name: name, email: email, password: password)
        } else {
            displayWarningLabelEmail(withText: "Wrong Email")
        }
    }
//    @IBAction func singInBtAct() {
//        performSegue(withIdentifier: Constants.Segues.singIn, sender: nil)
//        dismiss(animated: true, completion: nil)
//    }

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
        self.navigationItem.setHidesBackButton(true, animated: true)
        //registrationLB.alpha = 0.0
        errorLbEmail.alpha = 0
        registrationBt.layer.cornerRadius = Border.borderRadius
//        UIView.animate(withDuration: 1.05) {
//            self.registrationLB.alpha = 1.0
//        }

    }



}

// Label
extension Register {
    private func displayWarningLabelEmail(withText text: String) {
        errorLbEmail.text = text
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in self?.errorLbEmail.alpha = 1 }) { [weak self] _ in
            self?.errorLbEmail.alpha = 0
        }
    }
}

// Work with keyboord
extension Register {
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(Register.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Register.keyboardWillHide),
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
