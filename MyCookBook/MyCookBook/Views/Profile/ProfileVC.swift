//
//  ProfileVC.swift
//  MyCookBook
//
//  Created by sleman on 30.08.21.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func goOutBtAct() {
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            dismiss(animated: true, completion: nil)
        } catch{
            print(error.localizedDescription)
        }
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
