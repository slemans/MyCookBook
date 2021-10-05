//
//  ProfileStartVC.swift
//  MyCookBook
//
//  Created by sleman on 24.08.21.
//

import UIKit

class StartVC: UIViewController {

    @IBOutlet weak var titleVC: UIStackView!
    @IBOutlet weak var singInBt: UIButton!
    @IBOutlet weak var singUpBt: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        openingSeting()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if Core.shared.inNewUser(){
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let welcomViewControllerVC = storyboard.instantiateViewController(identifier: "welcom") as! WelcomViewController
            welcomViewControllerVC.modalPresentationStyle = .fullScreen
            present(welcomViewControllerVC, animated: true)
        }
    }
    
    
    private func requestAutorization(){
      //  notificationCenter.
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
         self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    @IBAction func singInAct() {
        performSegue(withIdentifier: Constants.Segues.singIn, sender: nil)
    }

    @IBAction func singUpAct() {
        performSegue(withIdentifier: Constants.Segues.singUp, sender: nil)
    }
}

class Core{
    static let shared = Core()
    
    func inNewUser() -> Bool{
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    func setIsNotNewUser(){
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
