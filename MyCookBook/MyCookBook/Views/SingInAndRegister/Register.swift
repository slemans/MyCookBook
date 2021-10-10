//
//  SIngUpVC.swift
//  MyCookBook
//
//  Created by sleman on 28.08.21.
//

import UIKit
import Firebase
import CoreData

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

    var users: [User] = []
    private var isValidEmail = false
    private var passwordStrenngth: PasswordLine = .veryWeak
    private var isValidEconfPass = false

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
                view.alpha = NumberCGFloat.numberOneZero
            } else {
                view.alpha = NumberCGFloat.numberZeroPointOne
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
                let password = passwordTf.text,
                let name = nameTf.text else { return }
            Auth.auth().createUser(withEmail: email,
                password: password,
                completion: { [weak self] (user, error) in
                    if let error = error {
                        self?.displayWarningLabelEmail(withText: "\(error.localizedDescription)")
                    } else {
                        let userUid = Auth.auth().currentUser!.uid
                        self!.saveItems(name: name, email: email, userUid: userUid)
                        self?.performSegue(withIdentifier: Constants.Segues.start, sender: nil)
                    }
                })

        } else {
            displayWarningLabelEmail(withText: "Wrong Email")
        }
    }
    private func saveItems(name: String?, email: String, userUid: String) {
        let context = SettingCoreDate.getContext()
        let newUser = User(context: SettingCoreDate.getContext())
        newUser.name = name
        newUser.email = email
        newUser.uid = userUid
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    @IBAction func singInBtAct() {
        performSegue(withIdentifier: Constants.Segues.singIn, sender: nil)
    }

    private func checkConfPass() {
        isValidEconfPass = Registration.checkEconPass(passwordTf.text, econfirmPasTf.text)
        errorLbEconPass.isHidden = isValidEconfPass
    }
    private func checkValidTf() {
        if isValidEmail == true && isValidEconfPass == true && (passwordStrenngth != .veryWeak) {
            registrationBt.isUserInteractionEnabled = true
            registrationBt.alpha = NumberCGFloat.numberOneZero
        } else {
            registrationBt.isUserInteractionEnabled = false
            registrationBt.alpha = NumberCGFloat.numberZeroPointTwo
        }
    }
    private func openingSeting() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        errorLbEmail.alpha = NumberCGFloat.numberZero
        registrationBt.layer.cornerRadius = Border.borderRadius
    }
}

// Label
extension Register {
    private func displayWarningLabelEmail(withText text: String) {
        errorLbEmail.text = text
        UIView.animate(withDuration: 3, delay: NumberOther.numberZeroDouble, usingSpringWithDamping: NumberCGFloat.numberOneZero, initialSpringVelocity: NumberCGFloat.numberOneZero, options: .curveEaseInOut, animations: { [weak self] in
            self?.errorLbEmail.alpha = NumberCGFloat.numberOneZero
        }) { [weak self] _ in
            self?.errorLbEmail.alpha = NumberCGFloat.numberZero
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
        let contentInsets = UIEdgeInsets(top: NumberCGFloat.numberZero, left: NumberCGFloat.numberZero, bottom: keyboardSize.height, right: NumberCGFloat.numberZero)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    @objc func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: NumberCGFloat.numberZero, left: NumberCGFloat.numberZero, bottom: NumberCGFloat.numberZero, right: NumberCGFloat.numberZero)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}

// remove keyboard
extension Register: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
