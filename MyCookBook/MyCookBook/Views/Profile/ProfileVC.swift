//
//  ProfileVC.swift
//  MyCookBook
//
//  Created by sleman on 30.08.21.
//

import UIKit

class ProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func addNewBrAct() {
        let alert = UIAlertController(title: "New Recipte", message: "Add new recepte", preferredStyle: .alert)
        alert.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textField = alert.textFields?.first, textField.text != "" else { return }
                
        }
        let cencel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(save)
        alert.addAction(cencel)
        present(alert, animated: true, completion: nil)
    }
    
}
