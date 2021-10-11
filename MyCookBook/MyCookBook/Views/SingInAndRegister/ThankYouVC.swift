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
        performSegue(withIdentifier: "segueSingInforBack", sender: nil)
    }
    private func openingSeting() {
        thankYouLB.alpha = NumberCGFloat.numberZero
        goBackBt.layer.cornerRadius = Border.borderRadius
        UIView.animate(withDuration: NumberOther.numberOnePointZeroFive) {
            self.thankYouLB.alpha = NumberCGFloat.numberOneZero
        }
    }
}
