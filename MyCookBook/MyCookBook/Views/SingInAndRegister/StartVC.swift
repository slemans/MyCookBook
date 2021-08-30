//
//  ProfileStartVC.swift
//  MyCookBook
//
//  Created by sleman on 24.08.21.
//

import UIKit
import Firebase
class StartVC: UIViewController {

    @IBOutlet weak var titleVC: UIStackView!
    @IBOutlet weak var singInBt: UIButton!
    @IBOutlet weak var singUpBt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openingSeting()
//        Auth.auth().addStateDidChangeListener({ [weak self] (auth, user) in
//            if user != nil {
//                self?.performSegue(withIdentifier: "BarBatonSegue", sender: nil)
//                self?.dismiss(animated: true, completion: nil)
//            }
//        })
    }
    private func openingSeting() {
        titleVC.alpha = 0.0
        singInBt.layer.cornerRadius = Border.borderRadius
        singUpBt.layer.cornerRadius = Border.borderRadius
        singUpBt.layer.borderWidth = Border.borderWidth
        singUpBt.layer.borderColor = Color.backgroundColor
        UIView.animate(withDuration: 1.05) {
            self.titleVC.alpha = 1.0
            // self.titleVC.transform = CGAffineTransform(translationX: 15, y: 0) передвигает
        }
    }
    @IBAction func singInAct() {
        performSegue(withIdentifier: "singInSegue", sender: nil)
    }
    
    @IBAction func singUpAct() {
        
//        if let singUpVC = storyboard?.instantiateViewController(
//            withIdentifier: "SingUpVC") as? Register {
//            singUpVC.modalPresentationStyle = .fullScreen
//            present(singUpVC, animated: true)
//        }
        performSegue(withIdentifier: "singUpSegue", sender: nil)
    }
}