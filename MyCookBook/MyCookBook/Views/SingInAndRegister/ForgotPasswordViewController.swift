//
//  ForgotPasswordViewController.swift
//  MyCookBook
//
//  Created by sleman on 13.09.21.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var EmailtextField: UITextField!
    @IBOutlet weak var sendNewPasswordBt: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        openingSeting()
    }
    
    @IBAction func sendNwwPasBtAct() {
        sendPasswordReset(withEmail: EmailtextField.text!)
    }
    func sendPasswordReset(withEmail email: String, _ callback: ((Error?) -> ())? = nil){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            callback?(error)
            self.alertAddAndEdite()
        }
    }
    fileprivate func openingSeting() {
        sendNewPasswordBt.layer.cornerRadius = Border.borderRadius
    }
    
    public func alertAddAndEdite() {
        guard let email = EmailtextField.text else { return }
        let alert = UIAlertController(title: "We have sent an email to your email: \n \(email)", message: "", preferredStyle: .alert)
        self.present(alert, animated: true)
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            alert.dismiss(animated: true, completion: nil)
            self.navigationController?.popToRootViewController(animated: true)
        })
    }
}
// remove keyboard
extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
