//
//  ProfileVC.swift
//  MyCookBook
//
//  Created by sleman on 30.08.21.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {

    @IBOutlet weak var nameUserLb: UILabel!
    @IBOutlet weak var logOutBt: UIButton!
    @IBOutlet weak var imagesUser: UIImageView!
    @IBOutlet weak var myRecipeLb: UILabel!
    @IBOutlet weak var favoritesLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openingSeting()
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
    fileprivate func openingSeting() {
        logOutBt.layer.cornerRadius = Border.borderRadius
        imagesUser.layer.cornerRadius = Border.borderRadius
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
