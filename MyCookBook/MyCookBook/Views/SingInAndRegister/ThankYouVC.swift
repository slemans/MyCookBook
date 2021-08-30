//
//  ThankYouVC.swift
//  MyCookBook
//
//  Created by sleman on 29.08.21.
//

import UIKit

class ThankYouVC: UIViewController {

    @IBOutlet weak var goBackBt: UIButton!
    @IBOutlet weak var thankYouLB: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        openingSeting()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    @IBAction func goBackBtAct() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    private func openingSeting() {
        thankYouLB.alpha = 0.0
        goBackBt.layer.cornerRadius = Border.borderRadius
        UIView.animate(withDuration: 1.05) {
            self.thankYouLB.alpha = 1.0
        }
    }
}