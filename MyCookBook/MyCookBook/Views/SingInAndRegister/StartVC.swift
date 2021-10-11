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
    private func openingSeting() {
        titleVC.alpha = NumberCGFloat.numberZero
        singInBt.layer.cornerRadius = Border.borderRadius
        singUpBt.layer.cornerRadius = Border.borderRadius
        singUpBt.layer.borderWidth = Border.borderWidth
        singUpBt.layer.borderColor = Color.backgroundColorCG
        UIView.animate(withDuration: TimeIntervalNumber.numberOnePointZeroFive) {
            self.titleVC.alpha = NumberCGFloat.numberOneZero
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


